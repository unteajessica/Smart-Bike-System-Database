-- =====================================================
-- Topic: DML Examples - DELETE
-- File: DML_examples/deletes.sql
-- =====================================================

DELETE FROM Bike
WHERE BikeID BETWEEN 5 AND 15
SELECT * FROM Bike

DELETE FROM MaintenanceLog
WHERE RepairDate < '2024-01-01'
AND BikeID IN (
	SELECT BikeID FROM Bike WHERE Status = 'Available'
	);

DELETE FROM Alert
WHERE isresolved = 1
AND ( AlertMessage LIKE '%battery%' OR 
	AlertMessage LIKE '%system%' );
