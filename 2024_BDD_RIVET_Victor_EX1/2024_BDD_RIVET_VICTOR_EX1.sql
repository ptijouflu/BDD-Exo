CREATE TABLE Utilisateurs ( #Création de la table
    Id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(100),
    statut VARCHAR(50),
    numero_etudiant varchar(50) # pas besoin de virgule car fin de la table
);

INSERT INTO Utilisateurs (nom, prenom, email, statut,numero_etudiant) VALUES # Ajout de 10 utilisateurs avec un nom, un prénom, un status et un numEtudiant
('Doe', 'John', 'john.doe@example.com', 'Actif','22310474t'),
('Smith', 'Alice', 'alice.smith@example.com', 'Inactif','22315878t'),
('Johnson', 'Michael', 'michael.johnson@example.com', 'Actif','22323417t'),
('Brown', 'Emma', 'emma.brown@example.com', 'Inactif','21456321t'),
('Wilson', 'James', 'james.wilson@example.com', 'Actif','22318985t'),
('Taylor', 'Olivia', 'olivia.taylor@example.com', 'Inactif','22311305t'),
('Anderson', 'William', 'william.anderson@example.com', 'Actif','22311211t'),
('Thomas', 'Sophia', 'sophia.thomas@example.com', 'Inactif','22318987t'),
('Moore', 'Benjamin', 'benjamin.moore@example.com', 'Actif','22314236t'),
('Jackson', 'Ava', 'ava.jackson@example.com', 'Inactif','22389632t');


CREATE TABLE Materiel ( # Creation de la table materiel
    Id_materiel INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    description TEXT,
    quantite_dispo INT,
    etat VARCHAR(50),
    emplacement VARCHAR(100)
);

INSERT INTO Materiel (nom, description, quantite_dispo, etat, emplacement) VALUES # Insertion des 10 exemples
('Ordinateur portable', 'Ordinateur portable de bureau standard.', 5, 'Bon état', 'Salle A101'),
('Projecteur', 'Projecteur pour les présentations.', 3, 'En réparation', 'Salle de réunion B'),
('Caméra vidéo', 'Caméra vidéo HD pour enregistrements.', 2, 'Disponible', 'Studio de production'),
('Microphone sans fil', 'Microphone sans fil pour les présentations.', 4, 'Bon état', 'Salle de conférence C'),
('Imprimante laser', 'Imprimante laser monochrome.', 1, 'Hors service', 'Bureau administratif'),
('Tablette graphique', 'Tablette graphique pour dessiner.', 3, 'Disponible', 'Salle des arts'),
('Scanner de documents', 'Scanner de documents haute vitesse.', 2, 'En maintenance', 'Service informatique'),
('Enregistreur audio', 'Enregistreur audio portable.', 2, 'Bon état', 'Studio d enregistrement'),
('Casque audio', 'Casque audio avec réduction de bruit.', 6, 'Disponible', 'Bibliothèque'),
('Lampe de bureau', 'Lampe de bureau à LED.', 8, 'Bon état', 'Bureau des enseignants');

CREATE TABLE Reservation ( # Création de la table réservation
    Id_reservation INT PRIMARY KEY AUTO_INCREMENT,
    dateDebutReservation DATE,
    dateFinReservation DATE,
    StatutReservation VARCHAR(50),
    IdUtilisateur INT,
    IdMateriel INT,
    FOREIGN KEY (IdUtilisateur) REFERENCES utilisateurs(Id_utilisateur),  # Lien à la table Utilisateur
    FOREIGN KEY (IdMateriel) REFERENCES materiel(Id_materiel) # Lien à la table matériel
);



INSERT INTO Reservation (dateDebutReservation, dateFinReservation, StatutReservation, IdUtilisateur, IdMateriel) VALUES # Insertion de 10 valeurs
('2024-03-20', '2024-03-25', 'En attente', 1, 1),
('2024-03-21', '2024-03-24', 'Confirmée', 2, 2),
('2024-03-22', '2024-03-23', 'Annulée', 3, 3),
('2024-03-23', '2024-03-26', 'En attente', 4, 4),
('2024-03-24', '2024-03-27', 'Confirmée', 5, 5),
('2024-03-25', '2024-03-28', 'En attente', 6, 6),
('2024-03-26', '2024-03-29', 'En attente', 7, 7),
('2024-03-27', '2024-03-30', 'En attente', 8, 8),
('2024-03-28', '2024-03-31', 'Annulée', 9, 9),
('2024-03-29', '2024-04-01', 'Confirmée', 10, 10);