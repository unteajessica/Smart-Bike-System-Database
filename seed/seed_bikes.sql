-- =====================================================
-- Topic: Seed Data - Bikes
-- File: seed/seed_bikes.sql
-- =====================================================

INSERT INTO Bike(Model, [Status], StationID)
VALUES
('CityBike X1', 'Available', 1),
('E-Bike Z2', 'Available', 1),
('CityBike X1', 'In Use', 2),
('Hybrid Pro', 'Maintenance', 3),
('Basic Bike', 'Maintenance', 2);

INSERT INTO Bike (Model, Status, StationID)
VALUES
('CityRide Gen1', 'Available', 1),
('CityRide Gen1', 'Available', 2),
('Mountain Pro X', 'Available', 3),
('Speedy E-Bike', 'Available', 4);

INSERT INTO Bike (Model, [Status], StationID)
VALUES
('City Pro Max', 'Available', 6),
('City Pro Max', 'Available', 7),
('Hybrid Street', 'Maintenance', 8),
('Roadster 500', 'Available', 6),
('Electric Glide', 'In Maintenance', 7);
