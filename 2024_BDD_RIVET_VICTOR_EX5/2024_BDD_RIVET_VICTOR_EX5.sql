#Requête de modification de la quantité disponible d’un matériel après un emprunt :
UPDATE Materiel
SET quantite_dispo = quantite_dispo - 1 #On va decrementer la quantite du materiel 1 de 1 
WHERE Id_materiel = 1;