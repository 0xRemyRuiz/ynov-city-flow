US-R1 : disponibilité de la station S001
----------------------------------------
→ Une commande suffit ? Deux ? Comment gérer le cas de clé expirée (cache miss) ?
**Requêtes :**
  1. `GET cityflow:station:lyon2:perrache:bikes`
  2. `GET cityflow:station:lyon2:perrache:scooters`
  3. *(optionnel)* `MGET cityflow:station:lyon2:perrache:bikes cityflow:station:lyon2:perrache:scooters`

- **Justification :** Nous utilisons deux clés de type String séparées selon le type de véhicule au lieu d’un Hash. Cela permet d’utiliser les opérations INCR et DECR qui sont atomiques sur une String, donc deux locations en même temps ne peuvent pas corrompre le compteur. Avec MGET on peut lire les deux valeurs en un seul aller-retour sur le réseau quand c’est nécessaire. Le TTL de 60 secondes garantit que les données restent fraîches avec un maximum d’une minute. En cas de cache vide (valeur nil), l’application suit le pattern Cache Aside : elle va chercher l’information dans Cassandra qui est la source de vérité, puis elle remet la valeur à jour dans le cache.
- **Réponse :**
  1.
```
"30"
```
  2.
```
"12"
```
  3.
```javascript
["30", "12"]
```

---
US-R2 : session de 30 min renouvelée à chaque action
---------------------------------------------------
→ Écrivez la séquence d'actions à exécuter à chaque requête HTTP (vérification + lecture +
renouvellement du TTL).
**Requêtes :**
  1. `EXISTS cityflow:session:token_alice`
  2. `GET cityflow:session:token_alice`
  3. `EXPIRE cityflow:session:token_alice 1800`
  4. `TTL cityflow:session:token_alice`

- **Justification :** La session est stockée sous forme de chaîne JSON. Elle est lue et écrite complètement à chaque requête HTTP. Un Hash serait plus efficace si on ne changeait qu’un seul champ, mais ici on utilise toujours tout le contenu. C’est pourquoi la chaîne JSON est plus simple et largement suffisante. Le middleware exécute la séquence EXISTS puis GET puis EXPIRE à chaque appel authentifié. Si EXISTS renvoie 0, cela veut dire que la session a expiré et on renvoie une erreur HTTP 401. Sinon, on lit les données de la session et on renouvelle le TTL à 1800 secondes pour donner une nouvelle fenêtre de 30 minutes.
- **Réponse :**
  1.
```
1
```
  2.
```javascript
{
  "userId": "u001",
  "device": "iPhone 15",
  "ip": "192.168.1.45",
  "lat": 45.7578,
  "lng": 4.8320
}
```
  3.
```
1
```
  4.
```
1799
```

US-R3 : top 10 utilisateurs les plus actifs du mois
---------------------------------------------------
→ Une seule commande, avec les scores.
- **Requêtes :**
  1. `ZREVRANGE cityflow:leaderboard:monthly 0 9 WITHSCORES`
  2. `ZSCORE cityflow:leaderboard:monthly user:u013`
  3. `ZREVRANK cityflow:leaderboard:monthly user:u013`
  4. `ZCOUNT cityflow:leaderboard:monthly 1500 +inf`

- **Justification :** La Sorted Set garde automatiquement l’ordre des éléments selon leur score à chaque ajout ou augmentation de points. La commande ZREVRANGE permet de récupérer les 10 premiers utilisateurs en ordre décroissant de façon très rapide, même avec des millions d’utilisateurs. Cela évite complètement de faire un tri dans l’application. Avec ZSCORE et ZREVRANK, on peut connaître facilement la position et le score d’un utilisateur précis sans tout recalculer. Pour la réinitialisation mensuelle, on renomme simplement la clé actuelle vers une clé d’archive sans arrêter le service, puis on repart avec un nouveau Sorted Set vide.
- **Réponse :**
  1.
```javascript
[
  { member: "user:u013", score: 2950 },
  { member: "user:u003", score: 2450 },
  { member: "user:u017", score: 2210 },
  { member: "user:u008", score: 2100 },
  { member: "user:u020", score: 1980 },
  { member: "user:u007", score: 1890 },
  { member: "user:u015", score: 1740 },
  { member: "user:u005", score: 1560 },
  { member: "user:u012", score: 1430 },
  { member: "user:u018", score: 1350 }
]
```
  2.
```
"2950"
```
  3.
```
0
```
  4.
```
8
```

---

US-R4 : rate limiting à 100 requêtes par minute
-----------------------------------------------
→ Écrivez la séquence : incrémenter le compteur, fixer le TTL si nouvelle clé, vérifier le seuil,
bloquer l'utilisateur si dépassement.
- **Requêtes :**
  1. `INCR cityflow:ratelimit:u001:search`
  2. `EXPIRE cityflow:ratelimit:u001:search 60` *(seulement si INCR a renvoyé 1)*
  3. `GET cityflow:ratelimit:u001:search`
  4. `TTL cityflow:ratelimit:u001:search`

- **Justification :** La commande INCR crée la clé avec la valeur 1 si elle n’existe pas, puis elle l’incrémente de 1 en une seule opération atomique. On applique EXPIRE uniquement quand INCR renvoie 1, c’est-à-dire au début d’une nouvelle fenêtre, pour ne pas modifier la durée de la fenêtre en cours. Si la valeur dépasse 100, la requête est refusée avec l’erreur HTTP 429. On renvoie le temps restant dans l’en-tête Retry-After pour indiquer au client quand il pourra réessayer. Cette solution est légère car elle utilise une clé par utilisateur et par action qui disparaît automatiquement à expiration, et elle supporte très bien les accès simultanés grâce à l’atomicité de INCR.

- **Réponse :**

  *(Exemple pour `u001` qui en est à sa 5e requête de la minute)*

  1.
```
5
```
  2.
```
1
```
  3.
```
"5"
```
  4.
```
47
```

  *(Exemple pour `u001` qui dépasse le seuil — 101e requête)*

  1.
```
101
```
  → **HTTP 429 Too Many Requests**
  ```
  Retry-After: 23
  ```
