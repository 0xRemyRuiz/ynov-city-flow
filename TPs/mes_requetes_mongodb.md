Important
=========
Avant de tester les requêtes dans mongosh il faut faire : `use tp_mongo`

PARTIE 8
========
Niveau 1 — Filtres simples
--------------------------
1. Trouvez tous les utilisateurs entre 25 et 35 ans (inclus aux deux bornes).
 - Requête : `db.users.find({ age: { "$gte": 25, "$lte": 35 } })`
 - Réponse :
```javascript
[
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
  }
]
```
2. Trouvez les utilisateurs dont l'email contient example.com (indice : opérateur $regex).
 - Requête : `db.users.find({ email: { "$regex": "example.com$" } })`
 - Réponse :
```javascript
[
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
  }
]
```
3. Trouvez les utilisateurs qui ont exactement 2 adresses.
 - Requête : `db.users.find({ addresses: { "$size": 2 } })`
 - Réponse :
```javascript
[
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
  }
]
```
4. Trouvez les utilisateurs qui n'ont pas le champ preferences.
 - Requête : `db.users.find({ preferences: { $exists: false } })`
 - Réponse :
```javascript
[
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
```

Niveau 2 — Combinaisons
-----------------------
5. Trouvez les utilisateurs habitant Lyon OU Villeurbanne, et de plus de 25 ans.
 - Requête : `db.users.find({
  "addresses.city": { "$in": ["Lyon", "Villeurbanne"] },
  "age": { "$gt": 25 }
})`
  - Réponse :
```javascript
[
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
```
6. Trouvez les utilisateurs qui ont au moins une adresse de type home à Lyon.
 - Requête : `db.users.find({ addresses: { "$elemMatch": { "type": "home", "city": "Lyon" } } })`
 - Réponse :
```javascript
[
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
  }
]
```
7. Trouvez les utilisateurs qui ont les tags premium ET eco-friendly ensemble.
 - Requête : `db.users.find({ tags: { "$all": ["premium", "eco-friendly"] } })`
 - Réponse :
```javascript
[
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
  }
]
```

Niveau 3 — Tri et pagination
----------------------------
8. Affichez les 3 utilisateurs les plus âgés, en ne renvoyant que firstName, age et email.
 - Requête : `db.users.find({}, { _id: 0, firstName: 1, age: 1, email: 1 }).sort({ age: -1 }).limit(3)`
 - Réponse :
```javascript
[
  { email: 'francois.roux@mail.com', firstName: 'François', age: 60 },
  { email: 'emma.moreau@example.com', firstName: 'Emma', age: 52 },
  { email: 'chloe.bernard@mail.com', firstName: 'Chloé', age: 34 }
]
```
9. Affichez les utilisateurs triés par ville (alphabétique), puis par âge décroissant.
 - Requête : `db.users.find().sort({ "addresses.city": 1, age: -1 })`
 - Réponse :
```javascript
[
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
  }
]
```
10. Implémentez une pagination : page 2 avec 2 utilisateurs par page, triés par createdAt.
 - Requête : `db.users.find().sort({ createdAt: 1 }).skip(2).limit(2)`
 - Réponse :
```javascript
[
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
  }
]
```


Niveau 4 — Bonus pour les rapides
---------------------------------
11. Trouvez les utilisateurs vérifiés âgés de moins de 30 ans, n'habitant pas Lyon.
 - Requête : `db.users.find({ isVerified: true, age: { "$lt": 30 }, "addresses.city": { "$ne": "Lyon" } })`
 - Réponse :
```javascript
[
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
  }
]
```
12. Trouvez les utilisateurs dont au moins un tag commence par la lettre 'p' (indice : $regex dans
un tableau).
 - Requête : `db.users.find({ "tags": { "$regex": "^p" } })`
 - Réponse :
```javascript
[
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
  }
]
```

PARTIE 9
========
Niveau 1 — Agrégations simples
------------------------------
1. Comptez le nombre total d'utilisateurs dans votre collection.
 - Requête : `db.users.countDocuments({})`
 - Réponse : `6`
2. Calculez l'âge moyen, le plus jeune et le plus âgé de votre base.
 - Requête : `db.users.aggregate([
  { $group: {
      _id: null,
      avgAge: { $avg: "$age" },
      youngest: { $min: "$age" },
      oldest: { $max: "$age" }
  }}
])`
 - Réponse :
```javascript
[ { _id: null, avgAge: 36.166666666666664, youngest: 18, oldest: 60 } ]
```
3. Comptez combien d'utilisateurs sont vérifiés (et combien ne le sont pas). 
 - Requête : `db.users.aggregate([
  { $group: {
      _id: "$isVerified",
      count: { $sum: 1 }
  }}
])`
 - Réponse :
```javascript
[
  { _id: true, count: 4 },
  { _id: null, count: 1 },
  { _id: false, count: 1 }
]
```

Niveau 2 — Regroupements
------------------------
4. Comptez le nombre d'utilisateurs par ville (utilisez $unwind sur addresses).
 - Requête : `db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "userCount": { "$sum": 1 }
  }},
  { "$sort": { "userCount": -1 } }
])`
 - Réponse :
```javascript
[
  { _id: 'Villeurbanne', userCount: 3 },
  { _id: 'Lyon', userCount: 3 },
  { _id: 'Vénissieux', userCount: 1 }
]
```

5. Trouvez l'âge moyen par ville, trié par âge moyen décroissant.
 - Requête : `db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "avgAge": { "$avg": "$age" }
  }},
  { "$sort": { "avgAge": -1 } }
])`
 - Réponse :
```javascript
[
  { _id: 'Villeurbanne', avgAge: 42.666666666666664 },
  { _id: 'Lyon', avgAge: 32.666666666666664 },
  { _id: 'Vénissieux', avgAge: 25 }
]
```
6. Identifiez les 3 tags les plus utilisés et le nombre d'utilisateurs pour chacun.
 - Requête : `db.users.aggregate([
   { "$unwind": "$tags" },
   { "$group": {
       "_id": "$tags",
       "count": { "$sum": 1 }
   }},
   { "$sort": { "count": -1 }},
   { "$limit": 3 }
 ])`
 - Réponse :
```javascript
[
  { _id: 'early-adopter', count: 3 },
  { _id: 'premium', count: 3 },
  { _id: 'new', count: 1 }
]
```

Niveau 3 — Pipelines complexes
------------------------------
7. Pour chaque ville, listez les firstName de tous les utilisateurs qui y habitent (utilisez $push ou $addToSet).
 - Requête : `db.users.aggregate([
   { "$unwind": "$addresses" },
   { "$group": {
       "_id": "$addresses.city",
       "residents": { "$addToSet": "$firstName" }
   }}
 ])`
 - Réponse :
```javascript
[
  { _id: 'Villeurbanne', residents: [ 'Chloé', 'François' ] },
  { _id: 'Lyon', residents: [ 'Alice', 'Bruno', 'Emma' ] },
  { _id: 'Vénissieux', residents: [ 'David' ] }
]
```
8. Calculez la proportion d'utilisateurs vérifiés par ville (champ calculé : verifiedCount /totalCount).
 - Requête : `db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "totalCount": { "$sum": 1 },
      "verifiedCount": {
        "$sum": { "$cond": [{ "$eq": ["$isVerified", true] }, 1, 0] }
      }
  }},
  { "$project": {
      "_id": 1,
      "totalCount": 1,
      "verifiedCount": 1,
      "verifiedRatio": { "$divide": ["$verifiedCount", "$totalCount"] }
  }}
])`
 - Réponse :
```javascript
[
  {
    _id: 'Villeurbanne',
    totalCount: 3,
    verifiedCount: 0,
    verifiedRatio: 0
  },
  { _id: 'Lyon', totalCount: 3, verifiedCount: 3, verifiedRatio: 1 },
  {
    _id: 'Vénissieux',
    totalCount: 1,
    verifiedCount: 1,
    verifiedRatio: 1
  }
]
```
9. Trouvez les utilisateurs qui ont le plus grand nombre d'adresses ($project pour ajouter un champ addressCount).
 - Requête : `db.users.aggregate([
   { "$project": {
       "firstName": 1,
       "email": 1,
       "addressCount": { "$size": "$addresses" }
   }},
   { "$sort": { "addressCount": -1 } }
 ])`
 - Réponse :
```javascript
[
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a5'),
    email: 'chloe.bernard@mail.com',
    firstName: 'Chloé',
    addressCount: 2
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a3'),
    email: 'alice.dupont@example.com',
    firstName: 'Alice',
    addressCount: 1
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a4'),
    email: 'bruno.martin@example.com',
    firstName: 'Bruno',
    addressCount: 1
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a6'),
    email: 'david.petit@example.com',
    firstName: 'David',
    addressCount: 1
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a7'),
    email: 'emma.moreau@example.com',
    firstName: 'Emma',
    addressCount: 1
  },
  {
    _id: ObjectId('6a3a5f7b2200da061e9df8a8'),
    email: 'francois.roux@mail.com',
    firstName: 'François',
    addressCount: 1
  }
]
```

Stratégie d'indexation
======================
1. Listez les champs les plus utilisés en filtre dans vos requêtes.
 - Réponse : `age, addresses.city, isVerified, tags, email et preferences`
2. Listez les champs les plus utilisés en tri.
 - Réponse : `age et createdAt`
3. Proposez au moins 3 index pertinents (un simple, un composé, un éventuellement unique).
 - Requête 1 : `db.users.createIndex({ age: 1 })`
 - Requête 2 : `db.users.createIndex({ lastName: 1, firstName: 1 })`
 - Requête 3 : `db.users.createIndex({ email: 1 }, { unique: true })`
5. Pour chaque index créé, justifiez son existence dans votre fichier mes_requetes.md.
 - Réponse pour `db.users.createIndex({ age: 1 })` : l'index simple ici permet d'avoir plusieurs personnes avec le même âge et pouvoir faire le tri selon ce critère. Ce n'est pas un critère pour lequel on peut avoir besoin d'informations complémentaires.
 - Réponse pour `db.users.createIndex({ lastName: 1, firstName: 1 })` : l'index composé ici peut être pertinent afin d'optimiser la recherche précise par personne
 - Réponse pour `db.users.createIndex({ email: 1 }, { unique: true })` : l'index unique ici est parfaitement justifié dans le cas d'une création de compte où l'on souhaite avoir une contrainte d'unicité vis-à-vis de l'e-mail
