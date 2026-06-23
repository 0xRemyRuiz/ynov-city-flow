

const init_collection_name = "__init__"

const tp_users = [
  {
    email: "alice.dupont@example.com",
    firstName: "Alice",
    lastName: "Dupont",
    age: 28,
    isVerified: true,
    createdAt: ISODate("2025-10-01T08:00:00Z"),
    addresses: [
      {
        type: "home",
        street: "12 rue de la République",
        city: "Lyon",
        zipCode: "69001"
      }
    ],
    tags: ["premium", "early-adopter"]
  }, {
    email: "bruno.martin@example.com",
    firstName: "Bruno",
    lastName: "Martin",
    age: 18,
    isVerified: true,
    createdAt: new Date("2025-09-15T10:30:00Z"),
    addresses: [
      {
        type: "home",
        street: "5 cours Gambetta",
        city: "Lyon",
        zipCode: "69007",
      },
    ],
    tags: ["new"],
  }, {
    email: "chloe.bernard@example.com",
    firstName: "Chloé",
    lastName: "Bernard",
    age: 34,
    createdAt: new Date("2025-08-20T14:00:00Z"),
    addresses: [
      {
        type: "home",
        street: "20 rue du 4 Août 1789",
        city: "Villeurbanne",
        zipCode: "69100",
      },
      {
        type: "work",
        street: "100 avenue Roger Salengro",
        city: "Villeurbanne",
        zipCode: "69100",
      },
    ],
    tags: ["premium"],
  }, {
    email: "david.petit@example.com",
    firstName: "David",
    lastName: "Petit",
    age: 45,
    createdAt: new Date("2025-07-05T09:15:00Z"),
    addresses: [
      {
        type: "home",
        street: "8 boulevard Laurent Gerin",
        city: "Vénissieux",
        zipCode: "69200",
      },
    ],
    tags: ["early-adopter"],
    preferences: {
      newsletter: true,
      theme: "dark",
      language: "fr",
      notifications: { email: true, sms: false },
    },
  }, {
    email: "emma.moreau@example.com",
    firstName: "Emma",
    lastName: "Moreau",
    age: 52,
    isVerified: true,
    createdAt: new Date("2025-06-10T16:45:00Z"),
    addresses: [
      {
        type: "home",
        street: "30 quai Saint-Antoine",
        city: "Lyon",
        zipCode: "69002",
      },
    ],
    tags: ["premium", "early-adopter"],
  }, {
    email: "francois.roux@example.com",
    firstName: "François",
    lastName: "Roux",
    age: 60,
    isVerified: false,
    createdAt: new Date("2025-05-01T11:00:00Z"),
    addresses: [
      {
        type: "home",
        street: "15 rue Léon Blum",
        city: "Villeurbanne",
        zipCode: "69100",
      },
    ],
    tags: [],
  },
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
