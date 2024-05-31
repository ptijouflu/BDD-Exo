#On cree la table disponibilite 
CREATE TABLE disponibilite (
    id_disponibilite INT PRIMARY KEY AUTO_INCREMENT, #on cree la cle primaire de disponibilité qui s'incremente toute seule
    id_materiel INT,
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (id_materiel) REFERENCES materiel(id_materiel) #on cree aussi le cle etrangere vers la table materiel
);

ALTER TABLE reservation
ADD COLUMN id_disponibilite INT,
ADD CONSTRAINT fk_reservation_disponibilite FOREIGN KEY (id_disponibilite) REFERENCES disponibilite(id_disponibilite);


ALTER TABLE reservation
ADD COLUMN id_disponibilite INT,
ADD CONSTRAINT fk_reservation_disponibilite FOREIGN KEY (id_disponibilite) REFERENCES disponibilite(id_disponibilite);


DELIMITER //

CREATE TRIGGER before_reservation_insert
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE date_debut DATE;
    DECLARE date_fin DATE;
    
    -- Récupérer les dates de disponibilité du matériel
    SELECT date_debut, date_fin INTO date_debut, date_fin
    FROM disponibilite
    WHERE id_disponibilite = NEW.id_disponibilite;
    
    -- Vérifier si la réservation est en dehors de la période de disponibilité
    IF NEW.dateDebutReservation < date_debut OR NEW.dateFinReservation > date_fin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La réservation est en dehors de la période de disponibilité.';
    END IF;
END;

//

DELIMITER ;


DELIMITER //

CREATE TRIGGER before_reservation_update
BEFORE UPDATE ON reservation
FOR EACH ROW
BEGIN
    DECLARE date_debut DATE;
    DECLARE date_fin DATE;
    
    -- Récupérer les dates de disponibilité du matériel
    SELECT date_debut, date_fin INTO date_debut, date_fin
    FROM disponibilite
    WHERE id_disponibilite = NEW.id_disponibilite;
    
    -- Vérifier si la réservation est en dehors de la période de disponibilité
    IF NEW.dateDebutReservation < date_debut OR NEW.dateFinReservation > date_fin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La réservation est en dehors de la période de disponibilité.';
    END IF;
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE verifier_disponibilite_materiel(
    IN p_id_materiel INT,
    IN p_date_debut DATE,
    IN p_date_fin DATE
)
BEGIN
    DECLARE disponibilite_count INT;

    -- Vérifier le nombre de périodes de disponibilité pour le matériel donné pendant la période spécifiée
    SELECT COUNT(*) INTO disponibilite_count
    FROM disponibilite
    WHERE id_materiel = p_id_materiel
    AND p_date_debut BETWEEN date_debut AND date_fin
    AND p_date_fin BETWEEN date_debut AND date_fin;

    -- Si le nombre de périodes de disponibilité est 0, le matériel n'est pas disponible
    IF disponibilite_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le matériel n''est pas disponible pour la période spécifiée.';
    END IF;
END//

DELIMITER ;




DELIMITER //

CREATE PROCEDURE ajouter_disponibilite_materiel(
    IN p_id_materiel INT,
    IN p_date_debut DATE,
    IN p_date_fin DATE
)
BEGIN
    INSERT INTO disponibilite (id_materiel, date_debut, date_fin)
    VALUES (p_id_materiel, p_date_debut, p_date_fin);
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modifier_disponibilite_materiel(
    IN p_id_disponibilite INT,
    IN p_date_debut DATE,
    IN p_date_fin DATE
)
BEGIN
    UPDATE disponibilite
    SET date_debut = p_date_debut, date_fin = p_date_fin
    WHERE id_disponibilite = p_id_disponibilite;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE supprimer_disponibilite_materiel(
    IN p_id_disponibilite INT
)
BEGIN
    DELETE FROM disponibilite
    WHERE id_disponibilite = p_id_disponibilite;
END//

DELIMITER ;


# Test 1: Ajouter une réservation valide
# Cette réservation doit être valide car elle est dans la période de disponibilité de l'ordinateur portable
INSERT INTO Reservation ( DateDebutReservation, DateFinReservation, idUtilisateur, idMateriel, StatutReservation, ID_Disponibilite)
VALUES ( '2024-03-06', '2024-03-07', 1, 1, 'confirmée', 1);

# Test 2: Ajouter une réservation invalide
# Cette réservation doit échouer car elle chevauche une réservation existante
INSERT INTO Reservation ( DateDebutReservation, DateFinReservation, idUtilisateur, idMateriel, StatutReservation, ID_Disponibilite)
VALUES ('2024-03-07', '2024-03-09', 1, 1, 'confirmée', 1);

# Test 3: Ajouter une réservation avec une période en dehors de la disponibilité
# Cette réservation doit échouer car elle est en dehors de la période de disponibilité de l'ordinateur portable
INSERT INTO Reservation ( DateDebutReservation, DateFinReservation, idUtilisateur, idMateriel, StatutReservation, ID_Disponibilite)
VALUES ( '2024-02-25', '2024-03-01', 1, 1, 'confirmée', 1);

# Test 4: Ajouter une réservation pour un autre matériel disponible
# Cette réservation doit être valide car elle est dans la période de disponibilité d'un autre matériel
INSERT INTO Reservation ( DateDebutReservation, DateFinReservation, idUtilisateur, idMateriel, StatutReservation, ID_Disponibilite)
VALUES ( '2024-03-06', '2024-03-07', 2, 2, 'confirmée', NULL);

# Test 5: Modifier une période de disponibilité (valide)
# Cette modification doit réussir car elle ne chevauche aucune réservation existante
UPDATE Disponibilite SET Date_Debut = '2024-03-02', Date_Fin = '2024-03-10' WHERE ID_Disponibilite = 1;

# Test 6: Modifier une période de disponibilité (chevauchement)
# Cette modification doit échouer car elle chevauche des réservations existantes
UPDATE Disponibilite SET Date_Debut = '2024-03-05', Date_Fin = '2024-03-15' WHERE ID_Disponibilite = 1;

-- Test 7: Supprimer une période de disponibilité associée à des réservations
-- Supprimer d'abord les réservations associées à la période de disponibilité
DELETE FROM reservation WHERE id_disponibilite = 1;

-- Ensuite, supprimer la période de disponibilité
DELETE FROM disponibilite WHERE id_disponibilite = 1;

-- Test 8: Supprimer une période de disponibilité sans réservations associées
DELETE FROM disponibilite WHERE id_disponibilite = 2;