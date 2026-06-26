# Modélisation Redis — CityFlow

## Convention de nommage

```
cityflow:{entité}:{identifiant}[:{attribut}]
```

- Préfixe `cityflow:` pour éviter les collisions en multi-tenant
- Séparateur `:` (convention universelle Redis)
- Pas d'espaces, d'accents ni de caractères spéciaux
- Singulier : `station` et non `stations`

---

## Schéma de clés

| Structure | Clé Redis | TTL | Commandes principales |
|-----------|-----------|-----|-----------------------|
| **String** | `cityflow:station:{ville}:{id}:bikes` | 60 s | `SET … EX 60`, `GET`, `MGET`, `INCR`, `DECR` |
| **String** | `cityflow:station:{ville}:{id}:scooters` | 60 s | `SET … EX 60`, `GET`, `MGET`, `INCR`, `DECR` |
| **String** | `cityflow:session:token_{user}` | 1800 s | `SET … EX 1800`, `GET`, `EXPIRE`, `DEL` |
| **Sorted Set** | `cityflow:leaderboard:monthly` | Permanent | `ZADD`, `ZINCRBY`, `ZREVRANGE`, `ZRANK`, `ZCOUNT` |
| **Sorted Set** | `cityflow:leaderboard:archive:{YYYY-MM}` | Permanent | `RENAME`, `ZREVRANGE` |
| **String** | `cityflow:ratelimit:{userId}:{action}` | 60 s | `INCR`, `EXPIRE`, `GET` |
| **List** | `cityflow:user:{id}:notifications` | Permanent (LTRIM 50) | `LPUSH`, `LRANGE`, `LTRIM` |
| **Set** | `cityflow:user:{id}:tags` | Permanent | `SADD`, `SMEMBERS`, `SISMEMBER` |

---

## Justifications par besoin

### US-R1 — Disponibilité temps réel des stations

**Structure choisie : String (deux clés séparées par véhicule)**

Deux clés String distinctes (`bikes` et `scooters`) plutôt qu'un Hash, car :

- `INCR` / `DECR` sont atomiques sur une String — parfait pour la concurrence (deux locations simultanées ne peuvent pas corrompre le compteur)
- `MGET` permet de lire plusieurs stations en un seul aller-retour réseau
- `HMSET` ne supporte pas le paramètre `EX` directement (le TTL doit être posé séparément avec `EXPIRE`)

Le TTL de 60 s signifie qu'on tolère des données vieilles d'une minute maximum. \

---

### US-R2 — Session utilisateur à expiration glissante

**Structure choisie : String (JSON sérialisé)**

La session est un objet lu et écrit en entier à chaque requête. Un Hash serait plus efficace si on ne modifiait qu'un champ à la fois, mais ici on lit systématiquement tout le bloc — la String JSON est donc plus simple.

Le TTL de 1800 s (30 min) est renouvelé via `EXPIRE cityflow:session:token_{user} 1800` à chaque requête HTTP authentifiée.

---

### US-R3 — Leaderboard mensuel

**Structure choisie : Sorted Set**

Le Sorted Set maintient automatiquement l'ordre par score. `ZREVRANGE … 0 9 WITHSCORES` renvoie le top 10 en O(log n). `ZINCRBY` incrémente le score d'un utilisateur en une commande atomique.

La réinitialisation mensuelle se fait par `RENAME` vers une clé d'archive, sans bloquer le jeu — le Sorted Set courant est recréé vide pour le nouveau mois.

Pas de TTL : l'archive est conservée indéfiniment pour l'historique.

---

### US-R4 — Rate limiting 100 req/min

**Structure choisie : String compteur**

`INCR` crée la clé à 1 si elle n'existe pas, puis incrémente. `EXPIRE` est posé uniquement si la clé vient d'être créée (valeur retournée = 1), ce qui ouvre une fenêtre glissante de 60 s sans jamais réinitialiser une fenêtre en cours.

Si la valeur dépasse 100, la requête est rejetée avec HTTP 429. Le header `Retry-After` est alimenté par `TTL cityflow:ratelimit:{userId}:{action}`.

---

### Bonus — Notifications & Tags

| Besoin                 | Structure | Raison |
|------------------------|-----------|--------|
| Notifications récentes | List + LTRIM 50 | Ordre chronologique naturel, les 50 dernières suffisent |
| Tags utilisateur       | Set | Unicité garantie, `SISMEMBER` en O(1), opérations ensemblistes possibles |
