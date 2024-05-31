#Afficher tous les utilisateurs ayant emprunté au moins un équipement :
SELECT Utilisateurs.* #on affiche l'ensemble des informations des utilisateurs
FROM Utilisateurs
JOIN Reservation ON Utilisateurs.Id_utilisateur = Reservation.IdUtilisateur; #on selectionne ensuite les reservations qui ont été effectuées par les utilisateurs

#Afficher les équipements n’ayant jamais été empruntés :
SELECT * 
FROM Materiel #cette requête recuperes les équipements qui ont leurs Id_materiel qui ne sont pas présentent dans la liste des identifiants de matériel empruntés
WHERE Id_materiel NOT IN (SELECT DISTINCT IdMateriel FROM Reservation);

#Afficher les équipements ayant été empruntés plus de 3 fois :
SELECT Materiel.*, COUNT(Reservation.IdMateriel) AS NombreEmprunts #on calcul le nombre d'emprunts pour chaque équipement et on affiche les données de la table materiel 
FROM Materiel
JOIN Reservation ON Materiel.Id_materiel = Reservation.IdMateriel #on utilise la cle etrangere idmateriel et la cle primaire Id_materiel pour associer chaque emprunt à son équipement correspondant 
GROUP BY Materiel.Id_materiel #on regroupe les reservations qui ont le meme équipement 
HAVING COUNT(Reservation.IdMateriel) > 3; #enfin on filtre les résultats pour ne retourner que les équipements qui ont été empruntés plus de 3 fois

#Afficher le nombre d’emprunt pour chaque utilisateur :
SELECT Utilisateurs.nom, Utilisateurs.prenom, COUNT(Reservation.Id_reservation) AS NombreEmprunts 
#on selectionne les noms et prenoms des utilisateurs et on compte les nombres d'emprunts renommé en NombreEmprunts
FROM Utilisateurs
LEFT JOIN Reservation ON Utilisateurs.Id_utilisateur = Reservation.IdUtilisateur 
#on associe chaque utilisateur à ses réservations. L'utilisation de LEFT JOIN permet d'inclure les utilisateurs l même s'ils n'ont pas de réservations
GROUP BY Utilisateurs.Id_utilisateur; #enfin on regroupe les resultats par utilisateurs pour rassembler toutes les reservations d'un meme utilisateur
