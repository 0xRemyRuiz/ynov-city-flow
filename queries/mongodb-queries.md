
US-M1 : profil + 10 derniers trajets
------------------------------------
 - Requêtes : 
  1. `db.users.findOne({ _id: "u001" });`
  2. `db.trips.find({ userId: "u001" }).sort({ startTime: -1 }).limit(10);`
 - Justification : On a préféré 2 requêtes pour des questions de performance tout d'abord. En effet mongodb est optimisé pour des petites requêtes. On a fait ce choix également pour avoir la possibilité de faire évoluer l'application facilement mais également la possibilité de mettre en cache l'une ou l'autre des parties. Par exemple il se peut que le profil évolue moins souvent de les voyages. Ou inversement, il se peut que les voyages soient bien plus souvent consultés. Cela permettrait de gérer le rafraîchissement intempestif de l'application.
 - Réponse :
  1.
```
userId_1_startTime_-1
```
  2.
```javascript
{
  _id: 'u001',
  email: 'alice.dupont@example.com',
  firstName: 'Alice',
  lastName: 'Dupont',
  age: 58,
  city: 'Lyon 2e',
  createdAt: ISODate('2026-05-02T12:00:00.000Z'),
  preferences: { theme: 'dark', language: 'es', notifications: true }
}
```
  3.
```javascript
[
  {
    _id: 't020',
    userId: 'u001',
    vehicleId: 'v005',
    startCity: 'Lyon 3e',
    endCity: 'Caluire-et-Cuire',
    startTime: ISODate('2026-06-22T11:39:00.000Z'),
    endTime: ISODate('2026-06-22T12:00:00.000Z'),
    durationMin: 21,
    distanceKm: 7.45,
    cost: 7.03,
    comment: 'Trajet nocturne tranquille dans Villeurbanne.'
  },
  {
    _id: 't006',
    userId: 'u001',
    vehicleId: 'v002',
    startCity: 'Lyon 4e',
    endCity: 'Lyon 4e',
    startTime: ISODate('2026-06-21T23:14:00.000Z'),
    endTime: ISODate('2026-06-22T00:02:00.000Z'),
    durationMin: 48,
    distanceKm: 20.17,
    cost: 13.77,
    comment: 'Trajet domicile-travail habituel, sans encombre.'
  },
  {
    _id: 't018',
    userId: 'u001',
    vehicleId: 'v003',
    startCity: 'Lyon 5e',
    endCity: 'Lyon 5e',
    startTime: ISODate('2026-06-15T08:04:00.000Z'),
    endTime: ISODate('2026-06-15T08:22:00.000Z'),
    durationMin: 18,
    distanceKm: 7.15,
    cost: 7.6,
    comment: 'Trajet nocturne tranquille dans Villeurbanne.'
  },
  {
    _id: 't005',
    userId: 'u001',
    vehicleId: 'v001',
    startCity: 'Vénissieux',
    endCity: 'Vénissieux',
    startTime: ISODate('2026-06-10T00:33:00.000Z'),
    endTime: ISODate('2026-06-10T01:30:00.000Z'),
    durationMin: 57,
    distanceKm: 16.35,
    cost: 20.44,
    comment: "Scooter rapide mais batterie faible à l'arrivée."
  },
  {
    _id: 't029',
    userId: 'u001',
    vehicleId: 'v004',
    startCity: 'Lyon 5e',
    endCity: 'Lyon 1er',
    startTime: ISODate('2026-06-03T19:53:00.000Z'),
    endTime: ISODate('2026-06-03T20:47:00.000Z'),
    durationMin: 54,
    distanceKm: 24.83,
    cost: 25.73,
    comment: 'Trajet agréable, vélo en bon état.'
  },
  {
    _id: 't024',
    userId: 'u001',
    vehicleId: 'v006',
    startCity: 'Lyon 7e',
    endCity: 'Vénissieux',
    startTime: ISODate('2026-05-25T22:59:00.000Z'),
    endTime: ISODate('2026-05-25T23:26:00.000Z'),
    durationMin: 27,
    distanceKm: 10.65,
    cost: 12.77,
    comment: 'Circulation dense sur les quais du Rhône.'
  }
]
```

US-M2 : véhicules d'un type donné dans un arrondissement
--------------------------------------------------------
 - Requêtes :
 1. db.vehicles.find(
  { type: "scooter", city: "Vénissieux" },
  { _id: 1, brand: 1, plate: 1, batteryLevel: 1, city: 1 }
);
2. db.vehicles.find(
  { type: "bike", city: "Lyon 1er" },
  { _id: 1, brand: 1, plate: 1, isElectric: 1, city: 1 }
);
- Justification :La requête est très simple. On filtre seulement sur deux champs qui doivent être égaux : le type et la ville. Il n'y a aucune transformation à faire, donc pas besoin d'agrégation. On affiche uniquement les informations utiles pour l'admin : la plaque, la batterie et la marque. Cela permet de ne pas surcharger la réponse. Le filtre sur la ville correspond directement au champ qui est enregistré dans les véhicules, ce qui évite de faire des jointures.
 - Réponse :
 1. [
  { _id: 'v006', brand: 'Lime',  plate: 'SC-217', batteryLevel: 78, city: 'Vénissieux' },
  { _id: 'v007', brand: 'Tier',  plate: 'SC-887', batteryLevel: 53, city: 'Vénissieux' }
]
2. [
  { _id: 'v006', brand: 'Lime',  plate: 'SC-217', batteryLevel: 78, city: 'Vénissieux' },
  { _id: 'v007', brand: 'Tier',  plate: 'SC-887', batteryLevel: 53, city: 'Vénissieux' }
]
US-M3 : statistiques globales
-----------------------------
 - Requêtes :
 Requête A — Nombre de trajets par jour
 db.trips.aggregate([
  {
    $group: {
      _id: { $dateToString: { format: "%Y-%m-%d", date: "$startTime" } },
      tripsCount:      { $sum: 1 },
      totalDistanceKm: { $sum: "$distanceKm" },
      avgCost:         { $avg: "$cost" }
    }
  },
  { $sort: { _id: -1 } }
]);
Requête B — Distance moyenne globale et extrêmes
db.trips.aggregate([
  {
    $group: {
      _id: null,
      totalTrips:      { $sum: 1 },
      avgDistanceKm:   { $avg: "$distanceKm" },
      minDistanceKm:   { $min: "$distanceKm" },
      maxDistanceKm:   { $max: "$distanceKm" },
      avgDurationMin:  { $avg: "$durationMin" },
      totalRevenueEur: { $sum: "$cost" }
    }
  }
]);
Requête C — Top 5 des conducteurs (par distance totale)
db.trips.aggregate([
  {
    $group: {
      _id:             "$userId",
      totalTrips:      { $sum: 1 },
      totalDistanceKm: { $sum: "$distanceKm" },
      totalCost:       { $sum: "$cost" }
    }
  },
  { $sort: { totalDistanceKm: -1 } },
  { $limit: 5 },
  {
    $lookup: {
      from:         "users",
      localField:   "_id",
      foreignField: "_id",
      as:           "userInfo"
    }
  },
  {
    $project: {
      totalTrips: 1, totalDistanceKm: 1, totalCost: 1,
      firstName: { $arrayElemAt: ["$userInfo.firstName", 0] },
      lastName:  { $arrayElemAt: ["$userInfo.lastName",  0] }
    }
  }
]);
 - Justification :La fonction $dateToString dans le groupe _id permet de regrouper les résultats par jour calendaire, sans tenir compte de l’heure, et sans avoir besoin de préparation préalable. Les trois requêtes sont bien séparées, chacune répond à un besoin analytique précis et peut être réutilisée facilement de son côté, ce qui rend le tableau de bord plus modulaire. Le $lookup dans la requête C est justifié car il s’agit d’une analyse peu fréquente : on accepte le coût supplémentaire de la jointure pour enrichir les résultats avec les noms des conducteurs
  - Réponse :
  Requête A :
  [
  { _id: '2026-06-22', tripsCount: 2, totalDistanceKm: 27.62, avgCost: 10.40 },
  { _id: '2026-06-21', tripsCount: 3, totalDistanceKm: 27.42, avgCost: 8.78  },
  { _id: '2026-06-18', tripsCount: 2, totalDistanceKm: 22.53, avgCost: 9.74  },
  // ...
]
Requête B :
[
  {
    _id: null,
    totalTrips: 30,
    avgDistanceKm: 10.77,
    minDistanceKm: 1.29,
    maxDistanceKm: 27.9,
    avgDurationMin: 38.97,
    totalRevenueEur: 323.18
  }
]
Requête C — Top 5 conducteurs :
[
  { _id: 'u002', firstName: 'Bruno',   lastName: 'Martin',   totalTrips: 7, totalDistanceKm: 91.17, totalCost: 94.01 },
  { _id: 'u001', firstName: 'Alice',   lastName: 'Dupont',   totalTrips: 6, totalDistanceKm: 86.60, totalCost: 87.34 },
  { _id: 'u013', firstName: 'Marco',   lastName: 'Henry',    totalTrips: 2, totalDistanceKm: 12.79, totalCost: 13.15 },
  { _id: 'u009', firstName: 'Inès',    lastName: 'Faure',    totalTrips: 3, totalDistanceKm: 19.51, totalCost: 21.08 },
  { _id: 'u014', firstName: 'Nadia',   lastName: 'Rousseau', totalTrips: 2, totalDistanceKm: 21.74, totalCost: 15.89 }
]
US-M4 : recherche full-text
---------------------------
Prérequis : créer l'index text : db.trips.createIndex({ comment: "text" }, { name: "comment_text" });
 - Requêtes :
 1. Recherche simple : trajets mentionnant "batterie"
db.trips.find(
  { $text: { $search: "batterie" } },
  { score: { $meta: "textScore" }, comment: 1, userId: 1, startCity: 1, _id: 0 }
).sort({ score: { $meta: "textScore" } });
2. Recherche multi-mots (OR implicite) : "vélo" ou "pneu"
db.trips.find(
  { $text: { $search: "vélo pneu" } },
  { score: { $meta: "textScore" }, comment: 1, userId: 1, _id: 0 }
).sort({ score: { $meta: "textScore" } });
3. Phrase exacte
db.trips.find(
  { $text: { $search: "\"trajet agréable\"" } },
  { comment: 1, userId: 1, _id: 0 }
);
4. Exclusion : trajets mentionnant "trajet" mais pas "embouteillage"
db.trips.find(
  { $text: { $search: "trajet -embouteillage" } },
  { comment: 1, userId: 1, _id: 0 }
);
 - Justification :L’opérateur $text utilise un index inversé créé avec createIndex sur le champ comment. Sans cet index, la recherche dans tout le texte obligerait MongoDB à lire tous les documents de la collection. Le $meta textScore donne un score de pertinence calculé par MongoDB selon la fréquence des mots, ce qui permet de trier les résultats du plus pertinent au moins pertinent. La syntaxe de recherche supporte naturellement plusieurs mots en même temps, l’exclusion avec le signe moins et les phrases exactes entre guillemets.
  - Réponse :
1. Recherche "batterie"
[
  { userId: 'u001', startCity: 'Vénissieux',  comment: "Scooter rapide mais batterie faible à l'arrivée." },
  { userId: 'u014', startCity: 'Lyon 8e',     comment: "Scooter rapide mais batterie faible à l'arrivée." },
  { userId: 'u011', startCity: 'Lyon 7e',     comment: "Scooter rapide mais batterie faible à l'arrivée." }
]
2. Recherche "trajet agréable"
[
  { userId: 'u002', comment: 'Trajet agréable, vélo en bon état.' },
  { userId: 'u004', comment: 'Trajet agréable, vélo en bon état.' },
  { userId: 'u001', comment: 'Trajet agréable, vélo en bon état.' }
]