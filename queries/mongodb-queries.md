
US-M1 : profil + 10 derniers trajets
------------------------------------
 - Requêtes : 
  1. `db.trips.createIndex({ userId: 1, startTime: -1 });`
  2. `db.users.findOne({ _id: "u001" });`
  3. `db.trips.find({ userId: "u001" }).sort({ startTime: -1 }).limit(10);`
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

US-M3 : statistiques globales
-----------------------------

US-M4 : recherche full-text
---------------------------
