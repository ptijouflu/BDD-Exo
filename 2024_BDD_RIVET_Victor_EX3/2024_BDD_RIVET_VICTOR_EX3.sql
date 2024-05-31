#Requête de jointure sur les utilisateurs ayant effectué une réservation :

#Cette requête joint la table "Utilisateurs" avec la table "Reservation" sur la clé étrangère "IdUtilisateur" dans latable "Reservation" et la clé primaire "Id_utilisateur" dans la table "Utilisateurs".
SELECT Utilisateurs.*, Reservation.* 
FROM Utilisateurs
JOIN Reservation ON Utilisateurs.Id_utilisateur = Reservation.IdUtilisateur; #Cette requete récupère toutes les colonnes des deux tables pour les utilisateurs qui ont fait une réservation.

#Requête de jointure pour récupérer les informations sur le matériel emprunté par un utilisateur donné :

SELECT Utilisateurs.nom, Utilisateurs.prenom, Materiel.* #Elle sélectionne le nom et le prénom de l'utilisateur, ainsi que toutes les colonnes de la table "Materiel" pour les réservations de cet utilisateur.
FROM Utilisateurs
JOIN Reservation ON Utilisateurs.Id_utilisateur = Reservation.IdUtilisateur 
JOIN Materiel ON Reservation.IdMateriel = Materiel.Id_materiel
#Cette requête joint les tables "Utilisateurs", "Reservation" et "Materiel" pour récupérer les informations sur le matériel emprunté par l'utilisateur 1
WHERE Utilisateurs.Id_utilisateur = 1;

