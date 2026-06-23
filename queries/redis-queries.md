US-R1 : disponibilité de la station S001
----------------------------------------
→ Une commande suffit ? Deux ? Comment gérer le cas de clé expirée (cache miss) ?

US-R2 : session de 30 min renouvelée à chaque action
----------------------------------------------------
→ Écrivez la séquence d'actions à exécuter à chaque requête HTTP (vérification + lecture +
renouvellement du TTL).

US-R3 : top 10 utilisateurs les plus actifs du mois
---------------------------------------------------
→ Une seule commande, avec les scores.

US-R4 : rate limiting à 100 requêtes par minute
-----------------------------------------------
→ Écrivez la séquence : incrémenter le compteur, fixer le TTL si nouvelle clé, vérifier le seuil,
bloquer l'utilisateur si dépassement.