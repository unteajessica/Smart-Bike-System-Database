-- =====================================================
-- Topic: Seed Data - Maintenance Logs
-- File: seed/seed_maintenance_logs.sql
-- =====================================================

INSERT INTO MaintenanceLog (BikeID, TeamID, IssueDescription, RepairDate)
VALUES
(3, 1, 'Replaced tire and adjusted brakes', '2025-10-15'),
(4, 2, 'Fixed loose chain and checked lights', '2025-10-16'),
(2, 3, 'Battery replaced and system reset', '2025-10-17'),
(1, 1, 'Cleaned and performed safety check', '2025-10-18');

INSERT INTO MaintenanceLog (BikeID, TeamID, IssueDescription, RepairDate)
VALUES
(19, 4, 'Replaced tires and chain', '2025-10-23'),
(20, 5, 'Adjusted brakes and oiling', '2025-10-23'),
(21, 6, 'Battery inspection', '2025-10-22'),
(22, 4, 'Handlebar tightening', '2025-10-21'),
(23, 5, 'Software update for electric motor', '2025-10-22');
