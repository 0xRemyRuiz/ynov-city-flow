# CityFlow — Modélisation MongoDB

---

## Contexte

CityFlow est une plateforme de mobilité urbaine multimodale (covoiturage, vélos, scooters, voitures électriques). Cette documentation décrit les choix de modélisation pour les trois collections MongoDB du projet.

---

## Collections

### 1. `users`

**Champs principaux**

| Champ         | Type    | Obligatoire | Description                              |
|---------------|---------|-------------|------------------------------------------|
| `_id`         | String  | Oui         | Identifiant métier (ex: `"u001"`)        |
| `email`       | String  | Oui         | Email unique (index unique)              |
| `firstName`   | String  | Oui         |                                          |
| `lastName`    | String  | Oui         |                                          |
| `age`         | Int     | Oui         |                                          |
| `city`        | String  | Oui         | Ville principale de l'utilisateur        |
| `isVerified`  | Boolean | Non         | Schéma flexible — absent = non vérifié  |
| `createdAt`   | ISODate | Oui         |                                          |
| `preferences` | Object  | Non         | Préférences UI — embedding (relation 1-1)|

**Choix embedding / référencement**

- `preferences` → **embedding** : relation 1-1, toujours lu avec le profil, pas d'existence propre.
- `trips` → **référencement** (champ `userId` dans la collection `trips`) : un utilisateur peut avoir des milliers de trajets, lus séparément, avec leur propre existence.

---

### 2. `vehicles`

**Champs principaux**

| Champ         | Type       | Obligatoire | Description                              |
|---------------|------------|-------------|------------------------------------------|
| `_id`         | String     | Oui         | Identifiant métier (ex: `"v001"`)        |
| `type`        | String     | Oui         | `"bike"`, `"scooter"`, `"car"`          |
| `brand`       | String     | Oui         | Marque du véhicule                       |
| `plate`       | String     | Oui         | Numéro de plaque                         |
| `city`        | String     | Oui         | Ville de disponibilité actuelle          |
| `isElectric`  | Boolean    | Oui         |                                          |
| `batteryLevel`| Int / null | Oui         | % batterie (null pour vélos non-électriques) |

**Choix embedding / référencement**

- Un véhicule a une **existence propre** indépendante des trajets → collection séparée.
- `trips` référencent les véhicules via `vehicleId` : un véhicule est réutilisé pour de nombreux trajets, et ses données (batterie, ville) peuvent changer sans impacter l'historique des trajets.

---

### 3. `trips`

**Champs principaux**

| Champ         | Type    | Obligatoire | Description                              |
|---------------|---------|-------------|------------------------------------------|
| `_id`         | String  | Oui         | Identifiant métier (ex: `"t001"`)        |
| `userId`      | String  | Oui         | Référence vers `users._id`              |
| `vehicleId`   | String  | Oui         | Référence vers `vehicles._id`           |
| `startCity`   | String  | Oui         | Ville de départ — **dénormalisée**      |
| `endCity`     | String  | Oui         | Ville d'arrivée — **dénormalisée**      |
| `startTime`   | ISODate | Oui         |                                          |
| `endTime`     | ISODate | Oui         |                                          |
| `durationMin` | Int     | Oui         | Durée en minutes                         |
| `distanceKm`  | Double  | Oui         | Distance en kilomètres                   |
| `cost`        | Double  | Oui         | Coût en euros — **figé au moment du trajet** |
| `comment`     | String  | Non         | Commentaire libre (indexé full-text)     |

**Choix embedding / référencement**

- `userId` → **référencement** : l'utilisateur existe indépendamment.
- `vehicleId` → **référencement** : le véhicule existe indépendamment et est partagé entre de nombreux trajets.
- `cost` → **dénormalisation volontaire** : le prix peut évoluer. On copie le coût au moment du trajet pour figer l'état de la transaction (pattern "snapshot", comme une facture).
- `startCity` / `endCity` → **dénormalisation volontaire** : copiés au moment du trajet pour un affichage rapide sans jointure. La ville courante du véhicule peut changer ; l'historique ne doit pas en être affecté.

---

## Schéma de relations

```
users (u001)
  └── référencé par → trips.userId
                        trips (t005, t006, t018...)
                          └── référencé par → trips.vehicleId
                                               vehicles (v001, v002...)
```

---

## Index créés et justifications

| Index                     | Collection | Règle ESR                        | Justification                                             |
|---------------------------|------------|----------------------------------|-----------------------------------------------------------|
| `userId_1_startTime_-1`   | trips      | E: userId / S: startTime         | US-M1 : N derniers trajets d'un utilisateur               |
| `type_1_city_1`           | vehicles   | E: type / E: city                | US-M2 : filtrer les véhicules par type et ville           |
| `startTime_-1`            | trips      | S: startTime                     | US-M3 : pipelines analytiques triés par date              |
| `comment_text`            | trips      | (full-text inversé)              | US-M4 : recherche plein texte sur les commentaires        |
| `email_unique`            | users      | E: email (unique)                | Intégrité : un email = un compte                          |

---

## Dénormalisations volontaires

| Champ dénormalisé        | Collection | Justification                                                              |
|--------------------------|------------|----------------------------------------------------------------------------|
| `cost`                   | trips      | Fige le prix au moment du trajet (indépendant des évolutions tarifaires)   |
| `startCity` / `endCity`  | trips      | Affichage rapide de l'historique sans jointure sur `vehicles`              |
