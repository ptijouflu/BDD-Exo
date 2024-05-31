#Requête d'agrégation pour calculer le nombre total de réservations effectuées sur une période donnée :

SELECT COUNT(*) AS NombreTotalReservations #AS permet de renommer la colonne qui va afficher le resultat de la requete
FROM Reservation
WHERE dateDebutReservation BETWEEN '2024-01-01' AND '2024-12-31'; #


#Requête d'agrégation pour calculer le nombre d'utilisateurs ayant emprunté un matériel donné :

SELECT COUNT(IdUtilisateur) AS NombreUtilisateursEmpruntant #Cette requette permet de compter les utilisateurs qui ont empreintés un materiel de type 1
FROM Reservation 
WHERE IdMateriel = 1; 