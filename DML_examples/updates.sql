-- =====================================================
-- Topic: DML Examples - UPDATE
-- File: DML_examples/updates.sql
-- =====================================================

UPDATE Bike
SET Model='BMX 3'
WHERE [Status]='Maintenance' AND StationID=2
SELECT * FROM Bike

UPDATE Bike
SET Model = 'CityRide Gen1', Status = 'Available'
WHERE Model LIKE 'BMX%' AND Status = 'Maintenance';

UPDATE [USER]
SET MembershipID = 1
WHERE MembershipID IS NULL;

UPDATE Payment
SET PaymentMethod='Card'
WHERE Amount>13
SELECT * FROM Payment
