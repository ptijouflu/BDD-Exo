#On supprime les reservations des utilisateurs 1 et 4
DELETE FROM Reservation
WHERE Reservation.IdUtilisateur = 1 or Reservation.IdUtilisateur = 4;

#On souhaite suprimer l'utilisateur nommé Jackson. Pour cela il faut d'abord supprimer les reservations de l'utilisateur Jackson
#On fait cela car il y a des cles étrangeres sur la table reservation
DELETE FROM Reservation
WHERE IdUtilisateur = (SELECT Id_utilisateur FROM Utilisateurs WHERE nom = 'Jackson');

#Ensuite on supprime l'utilisateur Jackson de la table Utilisateur 
DELETE FROM Utilisateurs WHERE nom = 'Jackson';

