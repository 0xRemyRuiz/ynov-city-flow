

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
const cityflow_users = []

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

// curr_db_name = "cityflow"
// if (!databaseExists(curr_db_name)) {
//   const database = db.getSiblingDB(curr_db_name)
//   database.createCollection(init_collection_name)
//   database.users.insertMany(cityflow_users)
// }
