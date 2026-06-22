
PARTIE 8
========
Niveau 1 — Filtres simples
--------------------------
1. Trouvez tous les utilisateurs entre 25 et 35 ans (inclus aux deux bornes).
{ "age": { "$gte": 25, "$lte": 35 } }
2. Trouvez les utilisateurs dont l'email contient example.com (indice : opérateur $regex).{ "email": { "$regex": "example.com" } }
3. Trouvez les utilisateurs qui ont exactement 2 adresses.{ "addresses": { "$size": 2 } }
4. Trouvez les utilisateurs qui n'ont pas le champ preferences.{ "addresses": { "$size": 2 } }

Niveau 2 — Combinaisons
-----------------------
5. Trouvez les utilisateurs habitant Lyon OU Villeurbanne, et de plus de 25 ans.{
  "addresses.city": { "$in": ["Lyon", "Villeurbanne"] },
  "age": { "$gt": 25 }
}
6. Trouvez les utilisateurs qui ont au moins une adresse de type home à Lyon.{ "addresses": { "$elemMatch": { "type": "home", "city": "Lyon" } } }
7. Trouvez les utilisateurs qui ont les tags premium ET eco-friendly ensemble.{ "tags": { "$all": ["premium", "eco-friendly"] } }

Niveau 3 — Tri et pagination
----------------------------
8. Affichez les 3 utilisateurs les plus âgés, en ne renvoyant que firstName, age et email.
9. Affichez les utilisateurs triés par ville (alphabétique), puis par âge décroissant. { "addresses.city": 1, "age": -1 }
10. Implémentez une pagination : page 2 avec 2 utilisateurs par page, triés par createdAt.

Niveau 4 — Bonus pour les rapides
---------------------------------
11. Trouvez les utilisateurs vérifiés âgés de moins de 30 ans, n'habitant pas Lyon.
{
  "isVerified": true,
  "age": { "$lt": 30 },
  "addresses.city": { "$ne": "Lyon" }
}
12. Trouvez les utilisateurs dont au moins un tag commence par la lettre 'p' (indice : $regex dans
un tableau).{ "tags": { "$regex": "^p" } }

PARTIE 9
========
Niveau 1 — Agrégations simples
------------------------------
1. Comptez le nombre total d'utilisateurs dans votre collection. db.users.countDocuments({})
2. Calculez l'âge moyen, le plus jeune et le plus âgé de votre base.
db.users.aggregate([
  { $group: {
      _id: null,
      avgAge: { $avg: "$age" },
      youngest: { $min: "$age" },
      oldest: { $max: "$age" }
  }}
])
3. Comptez combien d'utilisateurs sont vérifiés (et combien ne le sont pas). 
db.users.aggregate([
  { $group: {
      _id: "$isVerified",
      count: { $sum: 1 }
  }}
])

Niveau 2 — Regroupements
------------------------
4. Comptez le nombre d'utilisateurs par ville (utilisez $unwind sur addresses).
db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "userCount": { "$sum": 1 }
  }},
  { "$sort": { "userCount": -1 } }
])

5. Trouvez l'âge moyen par ville, trié par âge moyen décroissant.
db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "avgAge": { "$avg": "$age" }
  }},
  { "$sort": { "avgAge": -1 } }
])
6. Identifiez les 3 tags les plus utilisés et le nombre d'utilisateurs pour chacun.
db.users.aggregate([
  { "$unwind": "$tags" },
  { "$group": {
      "_id": "$tags",
      "count": { "$sum": 1 }
  }},
  { "$sort": { "count": -1 }},
  { "$limit": 3 }
])

Niveau 3 — Pipelines complexes
------------------------------
7. Pour chaque ville, listez les firstName de tous les utilisateurs qui y habitent (utilisez $push ou $addToSet).
db.users.aggregate([
  { "$unwind": "$addresses" },
  { "$group": {
      "_id": "$addresses.city",
      "residents": { "$addToSet": "$firstName" }
  }}
])
8. Calculez la proportion d'utilisateurs vérifiés par ville (champ calculé : verifiedCount /totalCount).
db.users.aggregate([
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
])
9. Trouvez les utilisateurs qui ont le plus grand nombre d'adresses ($project pour ajouter un champ addressCount).
db.users.aggregate([
  { "$project": {
      "firstName": 1,
      "email": 1,
      "addressCount": { "$size": "$addresses" }
  }},
  { "$sort": { "addressCount": -1 } }
])

Stratégie d'indexation
======================
1. Listez les champs les plus utilisés en filtre dans vos requêtes.age,addresses.city,isVerified,tags,email et preferences
2. Listez les champs les plus utilisés en tri. age, createdAt
3. Proposez au moins 3 index pertinents (un simple, un composé, un éventuellement unique).
db.users.createIndex({ age: 1 })
db.users.createIndex({ "addresses.city": 1, age: -1 })
b.users.createIndex({ email: 1 }, { unique: true })
4. Créez-les dans mongo-express via l'onglet Indexes.
Collection users → onglet Indexes → bouton Create Index :
-Champ{"age": 1}
-Cocher Unique uniquement pour l'index sur email
-Valider
5. Pour chaque index créé, justifiez son existence dans votre fichier mes_requetes.md.
Question bonus : quel serait l'index idéal pour la requête « utilisateurs habitant Lyon, âgés de 18
à 30 ans, triés par createdAt décroissant » ? Appliquez la règle ESR.