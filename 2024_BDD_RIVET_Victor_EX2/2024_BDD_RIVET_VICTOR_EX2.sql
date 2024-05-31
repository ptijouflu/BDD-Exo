SELECT * FROM Reservation WHERE IdUtilisateur = 1 AND StatutReservation = 'En attente'; #On selectionne l'ensemble des reservations en attentes de l'utilisateur 1

SELECT * FROM Materiel WHERE quantite_dispo > 0; #Cette requête récupère tous les matériels disponibles pour la réservation

SELECT * FROM Utilisateurs WHERE nom = 'Doe' AND prenom = 'John' OR nom = 'Smith' ORDER BY Id_utilisateur; #Cette requête récupère toutes les informations sur les utilisateurs Doe et Smith trié par leur numero