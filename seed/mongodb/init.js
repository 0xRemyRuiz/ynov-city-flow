

const init_collection_name = "__init__"

const tp_users = [
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a3'),
    email: 'alice.dupont@example.com',
    firstName: 'Alice',
    lastName: 'Dupont',
    age: 28,
    isVerified: true,
    createdAt: ISODate('2025-10-01T08:00:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '12 rue de la République',
        city: 'Lyon',
        zipCode: '69001'
      }
    ],
    tags: [ 'premium', 'early-adopter' ]
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a4'),
    email: 'bruno.martin@example.com',
    firstName: 'Bruno',
    lastName: 'Martin',
    age: 18,
    isVerified: true,
    createdAt: ISODate('2025-09-15T10:30:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '5 cours Gambetta',
        city: 'Lyon',
        zipCode: '69007'
      }
    ],
    tags: [ 'new' ]
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a5'),
    email: 'chloe.bernard@mail.com',
    firstName: 'Chloé',
    lastName: 'Bernard',
    age: 34,
    createdAt: ISODate('2025-08-20T14:00:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '20 rue du 4 Août 1789',
        city: 'Villeurbanne',
        zipCode: '69100'
      },
      {
        type: 'work',
        street: '100 avenue Roger Salengro',
        city: 'Villeurbanne',
        zipCode: '69100'
      }
    ],
    tags: [ 'premium' ]
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a6'),
    email: 'david.petit@example.com',
    firstName: 'David',
    lastName: 'Petit',
    age: 25,
    isVerified: true,
    createdAt: ISODate('2025-07-05T09:15:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '8 boulevard Laurent Gerin',
        city: 'Vénissieux',
        zipCode: '69200'
      }
    ],
    tags: [ 'early-adopter' ],
    preferences: {
      newsletter: true,
      theme: 'dark',
      language: 'fr',
      notifications: { email: true, sms: false }
    }
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a7'),
    email: 'emma.moreau@example.com',
    firstName: 'Emma',
    lastName: 'Moreau',
    age: 52,
    isVerified: true,
    createdAt: ISODate('2025-06-10T16:45:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '30 quai Saint-Antoine',
        city: 'Lyon',
        zipCode: '69002'
      }
    ],
    tags: [ 'premium', 'early-adopter', 'eco-friendly' ]
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a8'),
    email: 'francois.roux@mail.com',
    firstName: 'François',
    lastName: 'Roux',
    age: 60,
    isVerified: false,
    createdAt: ISODate('2025-05-01T11:00:00.000Z'),
    addresses: [
      {
        type: 'home',
        street: '15 rue Léon Blum',
        city: 'Villeurbanne',
        zipCode: '69100'
      }
    ],
    tags: []
  }
]
const cityflow = {
  users: [
    {
      "_id": "u001",
      "email": "alice.dupont@example.com",
      "firstName": "Alice",
      "lastName": "Dupont",
      "age": 58,
      "city": "Lyon 2e",
      "createdAt": ISODate("2026-05-02T12:00:00Z"),
      "preferences": {
        "theme": "dark",
        "language": "es",
        "notifications": true
      }
    },
    {
      "_id": "u002",
      "email": "bruno.martin@example.com",
      "firstName": "Bruno",
      "lastName": "Martin",
      "age": 52,
      "city": "Lyon 2e",
      "createdAt": ISODate("2025-07-16T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "dark",
        "language": "fr",
        "notifications": true
      }
    },
    {
      "_id": "u003",
      "email": "chloé.bernard@example.com",
      "firstName": "Chloé",
      "lastName": "Bernard",
      "age": 53,
      "city": "Lyon 4e",
      "createdAt": ISODate("2025-06-16T12:00:00Z"),
      "preferences": {
        "theme": "light",
        "language": "es",
        "notifications": false
      }
    },
    {
      "_id": "u004",
      "email": "david.petit@example.com",
      "firstName": "David",
      "lastName": "Petit",
      "age": 18,
      "city": "Lyon 3e",
      "createdAt": ISODate("2025-05-22T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "dark",
        "language": "en",
        "notifications": true
      }
    },
    {
      "_id": "u005",
      "email": "emma.moreau@example.com",
      "firstName": "Emma",
      "lastName": "Moreau",
      "age": 23,
      "city": "Lyon 7e",
      "createdAt": ISODate("2026-03-26T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "light",
        "language": "fr",
        "notifications": false
      }
    },
    {
      "_id": "u006",
      "email": "françois.roux@example.com",
      "firstName": "François",
      "lastName": "Roux",
      "age": 52,
      "city": "Lyon 2e",
      "createdAt": ISODate("2025-11-02T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "auto",
        "language": "es",
        "notifications": false
      }
    },
    {
      "_id": "u007",
      "email": "giulia.lefebvre@example.com",
      "firstName": "Giulia",
      "lastName": "Lefebvre",
      "age": 54,
      "city": "Lyon 4e",
      "createdAt": ISODate("2025-05-19T12:00:00Z"),
      "isVerified": true
    },
    {
      "_id": "u008",
      "email": "hugo.garnier@example.com",
      "firstName": "Hugo",
      "lastName": "Garnier",
      "age": 36,
      "city": "Lyon 2e",
      "createdAt": ISODate("2026-01-15T12:00:00Z"),
      "preferences": {
        "theme": "light",
        "language": "es",
        "notifications": false
      }
    },
    {
      "_id": "u009",
      "email": "inès.faure@example.com",
      "firstName": "Inès",
      "lastName": "Faure",
      "age": 28,
      "city": "Lyon 6e",
      "createdAt": ISODate("2025-11-14T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "auto",
        "language": "es",
        "notifications": true
      }
    },
    {
      "_id": "u010",
      "email": "julien.blanc@example.com",
      "firstName": "Julien",
      "lastName": "Blanc",
      "age": 56,
      "city": "Vénissieux",
      "createdAt": ISODate("2026-02-16T12:00:00Z"),
      "isVerified": false,
      "preferences": {
        "theme": "light",
        "language": "en",
        "notifications": false
      }
    },
    {
      "_id": "u011",
      "email": "karim.girard@example.com",
      "firstName": "Karim",
      "lastName": "Girard",
      "age": 58,
      "city": "Caluire-et-Cuire",
      "createdAt": ISODate("2025-08-02T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "dark",
        "language": "fr",
        "notifications": true
      }
    },
    {
      "_id": "u012",
      "email": "léa.bonnet@example.com",
      "firstName": "Léa",
      "lastName": "Bonnet",
      "age": 38,
      "city": "Lyon 7e",
      "createdAt": ISODate("2025-12-28T12:00:00Z"),
      "isVerified": true
    },
    {
      "_id": "u013",
      "email": "marco.henry@example.com",
      "firstName": "Marco",
      "lastName": "Henry",
      "age": 54,
      "city": "Caluire-et-Cuire",
      "createdAt": ISODate("2025-12-04T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "auto",
        "language": "en",
        "notifications": true
      }
    },
    {
      "_id": "u014",
      "email": "nadia.rousseau@example.com",
      "firstName": "Nadia",
      "lastName": "Rousseau",
      "age": 34,
      "city": "Lyon 3e",
      "createdAt": ISODate("2026-01-08T12:00:00Z")
    },
    {
      "_id": "u015",
      "email": "olivier.vincent@example.com",
      "firstName": "Olivier",
      "lastName": "Vincent",
      "age": 55,
      "city": "Lyon 7e",
      "createdAt": ISODate("2025-07-20T12:00:00Z"),
      "isVerified": true,
      "preferences": {
        "theme": "dark",
        "language": "es",
        "notifications": false
      }
    }
  ],
  vehicles: [
    {
      "_id": "v001",
      "type": "bike",
      "brand": "Vélo'v",
      "plate": "BI-873",
      "city": "Lyon 1er",
      "isElectric": false,
      "batteryLevel": null
    },
    {
      "_id": "v002",
      "type": "bike",
      "brand": "Vélo'v",
      "plate": "BI-742",
      "city": "Lyon 3e",
      "isElectric": false,
      "batteryLevel": null
    },
    {
      "_id": "v003",
      "type": "bike",
      "brand": "Decathlon",
      "plate": "BI-710",
      "city": "Lyon 2e",
      "isElectric": false,
      "batteryLevel": null
    },
    {
      "_id": "v004",
      "type": "bike",
      "brand": "Btwin",
      "plate": "BI-579",
      "city": "Lyon 9e",
      "isElectric": true,
      "batteryLevel": null
    },
    {
      "_id": "v005",
      "type": "scooter",
      "brand": "Lime",
      "plate": "SC-981",
      "city": "Lyon 1er",
      "isElectric": true,
      "batteryLevel": 97
    },
    {
      "_id": "v006",
      "type": "scooter",
      "brand": "Lime",
      "plate": "SC-217",
      "city": "Vénissieux",
      "isElectric": true,
      "batteryLevel": 78
    },
    {
      "_id": "v007",
      "type": "scooter",
      "brand": "Tier",
      "plate": "SC-887",
      "city": "Vénissieux",
      "isElectric": true,
      "batteryLevel": 53
    },
    {
      "_id": "v008",
      "type": "car",
      "brand": "Citroën Ami",
      "plate": "CA-400",
      "city": "Lyon 7e",
      "isElectric": true,
      "batteryLevel": 30
    },
    {
      "_id": "v009",
      "type": "car",
      "brand": "Renault Zoe",
      "plate": "CA-103",
      "city": "Caluire-et-Cuire",
      "isElectric": true,
      "batteryLevel": 43
    },
    {
      "_id": "v010",
      "type": "car",
      "brand": "Peugeot e-208",
      "plate": "CA-880",
      "city": "Lyon 3e",
      "isElectric": true,
      "batteryLevel": 74
    }
  ],
  trips: [
    {
      "_id": "t001",
      "userId": "u014",
      "vehicleId": "v009",
      "startCity": "Lyon 8e",
      "endCity": "Lyon 2e",
      "startTime": ISODate("2026-06-01T02:35:00Z"),
      "endTime": ISODate("2026-06-01T03:27:00Z"),
      "durationMin": 52,
      "distanceKm": 14.31,
      "cost": 10.64,
      "comment": "Scooter rapide mais batterie faible à l'arrivée."
    },
    {
      "_id": "t002",
      "userId": "u002",
      "vehicleId": "v004",
      "startCity": "Lyon 1er",
      "endCity": "Lyon 2e",
      "startTime": ISODate("2026-06-13T11:23:00Z"),
      "endTime": ISODate("2026-06-13T12:38:00Z"),
      "durationMin": 75,
      "distanceKm": 14.4,
      "cost": 15.34,
      "comment": "Trajet agréable, vélo en bon état."
    },
    {
      "_id": "t003",
      "userId": "u013",
      "vehicleId": "v002",
      "startCity": "Lyon 9e",
      "endCity": "Lyon 4e",
      "startTime": ISODate("2026-06-16T09:03:00Z"),
      "endTime": ISODate("2026-06-16T09:12:00Z"),
      "durationMin": 9,
      "distanceKm": 3.99,
      "cost": 3.77,
      "comment": "Trajet domicile-travail habituel, sans encombre."
    },
    {
      "_id": "t004",
      "userId": "u006",
      "vehicleId": "v008",
      "startCity": "Lyon 7e",
      "endCity": "Lyon 4e",
      "startTime": ISODate("2026-06-16T18:52:00Z"),
      "endTime": ISODate("2026-06-16T19:57:00Z"),
      "durationMin": 65,
      "distanceKm": 12.82,
      "cost": 8.26,
      "comment": "Excellent trajet, je recommande ce véhicule."
    },
    {
      "_id": "t005",
      "userId": "u001",
      "vehicleId": "v001",
      "startCity": "Vénissieux",
      "endCity": "Vénissieux",
      "startTime": ISODate("2026-06-10T00:33:00Z"),
      "endTime": ISODate("2026-06-10T01:30:00Z"),
      "durationMin": 57,
      "distanceKm": 16.35,
      "cost": 20.44,
      "comment": "Scooter rapide mais batterie faible à l'arrivée."
    },
    {
      "_id": "t006",
      "userId": "u001",
      "vehicleId": "v002",
      "startCity": "Lyon 4e",
      "endCity": "Lyon 4e",
      "startTime": ISODate("2026-06-21T23:14:00Z"),
      "endTime": ISODate("2026-06-22T00:02:00Z"),
      "durationMin": 48,
      "distanceKm": 20.17,
      "cost": 13.77,
      "comment": "Trajet domicile-travail habituel, sans encombre."
    },
    {
      "_id": "t007",
      "userId": "u003",
      "vehicleId": "v002",
      "startCity": "Lyon 8e",
      "endCity": "Lyon 9e",
      "startTime": ISODate("2026-06-18T22:49:00Z"),
      "endTime": ISODate("2026-06-18T23:29:00Z"),
      "durationMin": 40,
      "distanceKm": 11.4,
      "cost": 7.48,
      "comment": "Excellent trajet, je recommande ce véhicule."
    },
    {
      "_id": "t008",
      "userId": "u004",
      "vehicleId": "v008",
      "startCity": "Lyon 8e",
      "endCity": "Lyon 4e",
      "startTime": ISODate("2026-06-06T11:55:00Z"),
      "endTime": ISODate("2026-06-06T12:30:00Z"),
      "durationMin": 35,
      "distanceKm": 5.83,
      "cost": 7.44,
      "comment": "Trajet agréable, vélo en bon état."
    },
    {
      "_id": "t009",
      "userId": "u011",
      "vehicleId": "v008",
      "startCity": "Lyon 5e",
      "endCity": "Lyon 7e",
      "startTime": ISODate("2026-06-18T00:00:00Z"),
      "endTime": ISODate("2026-06-18T00:54:00Z"),
      "durationMin": 54,
      "distanceKm": 11.13,
      "cost": 11.99,
      "comment": "Trajet nocturne tranquille dans Villeurbanne."
    },
    {
      "_id": "t010",
      "userId": "u009",
      "vehicleId": "v005",
      "startCity": "Lyon 4e",
      "endCity": "Lyon 1er",
      "startTime": ISODate("2026-05-28T18:18:00Z"),
      "endTime": ISODate("2026-05-28T19:25:00Z"),
      "durationMin": 67,
      "distanceKm": 10.85,
      "cost": 10.82,
      "comment": "Embouteillage à Part-Dieu, trajet plus long que prévu."
    },
    {
      "_id": "t011",
      "userId": "u005",
      "vehicleId": "v008",
      "startCity": "Lyon 9e",
      "endCity": "Lyon 9e",
      "startTime": ISODate("2026-06-21T12:40:00Z"),
      "endTime": ISODate("2026-06-21T12:52:00Z"),
      "durationMin": 12,
      "distanceKm": 1.44,
      "cost": 1.88,
      "comment": "Embouteillage à Part-Dieu, trajet plus long que prévu."
    },
    {
      "_id": "t012",
      "userId": "u002",
      "vehicleId": "v004",
      "startCity": "Lyon 7e",
      "endCity": "Lyon 2e",
      "startTime": ISODate("2026-06-21T06:56:00Z"),
      "endTime": ISODate("2026-06-21T07:09:00Z"),
      "durationMin": 13,
      "distanceKm": 4.81,
      "cost": 6.58,
      "comment": "Vélo avec un pneu un peu mou, à vérifier."
    },
    {
      "_id": "t013",
      "userId": "u015",
      "vehicleId": "v007",
      "startCity": "Vénissieux",
      "endCity": "Villeurbanne",
      "startTime": ISODate("2026-06-15T17:22:00Z"),
      "endTime": ISODate("2026-06-15T17:32:00Z"),
      "durationMin": 10,
      "distanceKm": 3.48,
      "cost": 4.12,
      "comment": "Pluie pendant le trajet, route glissante."
    },
    {
      "_id": "t014",
      "userId": "u013",
      "vehicleId": "v007",
      "startCity": "Lyon 3e",
      "endCity": "Vénissieux",
      "startTime": ISODate("2026-05-25T03:47:00Z"),
      "endTime": ISODate("2026-05-25T04:32:00Z"),
      "durationMin": 45,
      "distanceKm": 8.8,
      "cost": 9.38,
      "comment": "Trajet domicile-travail habituel, sans encombre."
    },
    {
      "_id": "t015",
      "userId": "u002",
      "vehicleId": "v010",
      "startCity": "Lyon 2e",
      "endCity": "Lyon 2e",
      "startTime": ISODate("2026-06-13T10:00:00Z"),
      "endTime": ISODate("2026-06-13T11:03:00Z"),
      "durationMin": 63,
      "distanceKm": 21.95,
      "cost": 20.24,
      "comment": "Embouteillage à Part-Dieu, trajet plus long que prévu."
    },
    {
      "_id": "t016",
      "userId": "u003",
      "vehicleId": "v004",
      "startCity": "Lyon 6e",
      "endCity": "Lyon 5e",
      "startTime": ISODate("2026-06-15T07:01:00Z"),
      "endTime": ISODate("2026-06-15T07:50:00Z"),
      "durationMin": 49,
      "distanceKm": 22.16,
      "cost": 14.53,
      "comment": "Embouteillage à Part-Dieu, trajet plus long que prévu."
    },
    {
      "_id": "t017",
      "userId": "u014",
      "vehicleId": "v009",
      "startCity": "Lyon 5e",
      "endCity": "Vénissieux",
      "startTime": ISODate("2026-06-01T02:21:00Z"),
      "endTime": ISODate("2026-06-01T03:33:00Z"),
      "durationMin": 72,
      "distanceKm": 7.43,
      "cost": 5.25,
      "comment": "Petit détour par le parc de la Tête d'Or, superbe."
    },
    {
      "_id": "t018",
      "userId": "u001",
      "vehicleId": "v003",
      "startCity": "Lyon 5e",
      "endCity": "Lyon 5e",
      "startTime": ISODate("2026-06-15T08:04:00Z"),
      "endTime": ISODate("2026-06-15T08:22:00Z"),
      "durationMin": 18,
      "distanceKm": 7.15,
      "cost": 7.6,
      "comment": "Trajet nocturne tranquille dans Villeurbanne."
    },
    {
      "_id": "t019",
      "userId": "u010",
      "vehicleId": "v005",
      "startCity": "Lyon 1er",
      "endCity": "Lyon 2e",
      "startTime": ISODate("2026-06-13T05:17:00Z"),
      "endTime": ISODate("2026-06-13T05:55:00Z"),
      "durationMin": 38,
      "distanceKm": 11.48,
      "cost": 11.84,
      "comment": "Voiture propre et confortable, rien à signaler."
    },
    {
      "_id": "t020",
      "userId": "u001",
      "vehicleId": "v005",
      "startCity": "Lyon 3e",
      "endCity": "Caluire-et-Cuire",
      "startTime": ISODate("2026-06-22T11:39:00Z"),
      "endTime": ISODate("2026-06-22T12:00:00Z"),
      "durationMin": 21,
      "distanceKm": 7.45,
      "cost": 7.03,
      "comment": "Trajet nocturne tranquille dans Villeurbanne."
    },
    {
      "_id": "t021",
      "userId": "u002",
      "vehicleId": "v003",
      "startCity": "Lyon 9e",
      "endCity": "Lyon 1er",
      "startTime": ISODate("2026-06-09T19:00:00Z"),
      "endTime": ISODate("2026-06-09T19:19:00Z"),
      "durationMin": 19,
      "distanceKm": 2.47,
      "cost": 3.68,
      "comment": "Vélo avec un pneu un peu mou, à vérifier."
    },
    {
      "_id": "t022",
      "userId": "u002",
      "vehicleId": "v006",
      "startCity": "Lyon 1er",
      "endCity": "Lyon 6e",
      "startTime": ISODate("2026-06-06T07:33:00Z"),
      "endTime": ISODate("2026-06-06T07:54:00Z"),
      "durationMin": 21,
      "distanceKm": 2.45,
      "cost": 2.59,
      "comment": "Circulation dense sur les quais du Rhône."
    },
    {
      "_id": "t023",
      "userId": "u002",
      "vehicleId": "v003",
      "startCity": "Lyon 4e",
      "endCity": "Lyon 3e",
      "startTime": ISODate("2026-06-02T08:38:00Z"),
      "endTime": ISODate("2026-06-02T09:35:00Z"),
      "durationMin": 57,
      "distanceKm": 27.9,
      "cost": 34.02,
      "comment": "Petit détour par le parc de la Tête d'Or, superbe."
    },
    {
      "_id": "t024",
      "userId": "u001",
      "vehicleId": "v006",
      "startCity": "Lyon 7e",
      "endCity": "Vénissieux",
      "startTime": ISODate("2026-05-25T22:59:00Z"),
      "endTime": ISODate("2026-05-25T23:26:00Z"),
      "durationMin": 27,
      "distanceKm": 10.65,
      "cost": 12.77,
      "comment": "Circulation dense sur les quais du Rhône."
    },
    {
      "_id": "t025",
      "userId": "u015",
      "vehicleId": "v001",
      "startCity": "Lyon 8e",
      "endCity": "Lyon 4e",
      "startTime": ISODate("2026-06-15T06:10:00Z"),
      "endTime": ISODate("2026-06-15T06:28:00Z"),
      "durationMin": 18,
      "distanceKm": 4.55,
      "cost": 3.91,
      "comment": "Trajet domicile-travail habituel, sans encombre."
    },
    {
      "_id": "t026",
      "userId": "u011",
      "vehicleId": "v004",
      "startCity": "Lyon 7e",
      "endCity": "Lyon 6e",
      "startTime": ISODate("2026-06-12T02:08:00Z"),
      "endTime": ISODate("2026-06-12T02:42:00Z"),
      "durationMin": 34,
      "distanceKm": 6.43,
      "cost": 5.47,
      "comment": "Scooter rapide mais batterie faible à l'arrivée."
    },
    {
      "_id": "t027",
      "userId": "u002",
      "vehicleId": "v009",
      "startCity": "Lyon 6e",
      "endCity": "Lyon 1er",
      "startTime": ISODate("2026-05-30T03:38:00Z"),
      "endTime": ISODate("2026-05-30T04:48:00Z"),
      "durationMin": 70,
      "distanceKm": 18.19,
      "cost": 11.56,
      "comment": "Voiture propre et confortable, rien à signaler."
    },
    {
      "_id": "t028",
      "userId": "u009",
      "vehicleId": "v007",
      "startCity": "Lyon 6e",
      "endCity": "Caluire-et-Cuire",
      "startTime": ISODate("2026-06-17T17:44:00Z"),
      "endTime": ISODate("2026-06-17T17:53:00Z"),
      "durationMin": 9,
      "distanceKm": 1.29,
      "cost": 2.36,
      "comment": "Belle balade le long de la Saône au coucher du soleil."
    },
    {
      "_id": "t029",
      "userId": "u001",
      "vehicleId": "v004",
      "startCity": "Lyon 5e",
      "endCity": "Lyon 1er",
      "startTime": ISODate("2026-06-03T19:53:00Z"),
      "endTime": ISODate("2026-06-03T20:47:00Z"),
      "durationMin": 54,
      "distanceKm": 24.83,
      "cost": 25.73,
      "comment": "Trajet agréable, vélo en bon état."
    },
    {
      "_id": "t030",
      "userId": "u009",
      "vehicleId": "v002",
      "startCity": "Vénissieux",
      "endCity": "Lyon 6e",
      "startTime": ISODate("2026-06-06T18:17:00Z"),
      "endTime": ISODate("2026-06-06T18:47:00Z"),
      "durationMin": 30,
      "distanceKm": 7.37,
      "cost": 7.9,
      "comment": "Excellent trajet, je recommande ce véhicule."
    }
  ],
}

function databaseExists(db_name) {
  const database = db.getSiblingDB(db_name)
  return !!database.getCollectionNames().includes(init_collection_name)
}

curr_db_name = "tp_mongo"
if (!databaseExists(curr_db_name)) {
  const database = db.getSiblingDB(curr_db_name)
  database.createCollection(init_collection_name)
  database.users.insertMany(tp_users)
}

curr_db_name = "cityflow"
// DEBUG!
db.dropDatabase(curr_db_name)
if (!databaseExists(curr_db_name)) {
  const database = db.getSiblingDB(curr_db_name)
  database.createCollection(init_collection_name)
  database.createCollection("users")
  database.createCollection("trips")
  database.createCollection("vehicles")
  database.users.insertMany(cityflow.users)
  database.vehicles.insertMany(cityflow.vehicles)
  database.trips.insertMany(cityflow.trips)
}
