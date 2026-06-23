

const databases = ["tp_mongo", "cityflow"];
const initCollectionName = "__init__";

for (const dbName of databases) {
  const database = db.getSiblingDB(dbName);

  // Check whether the initializer collection already exists
  const existingCollection = database.getCollectionNames().includes(initCollectionName);

  if (!existingCollection) {
    database.createCollection(initCollectionName);
    print(`Initialized database: ${dbName}`);
  } else {
    print(`Database already initialized: ${dbName}`);
  }
}

