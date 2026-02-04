-- =====================================================
-- Topic: Seed Data - Alerts
-- File: seed/seed_alerts.sql
-- =====================================================

INSERT INTO Alert (BikeID, AlertType, AlertMessage, CreatedAt, IsResolved)
VALUES
(1, 'Battery', 'Low battery detected', GETDATE(), 0),
(2, 'Maintenance', 'Brake pads require replacement', GETDATE(), 0),
(3, 'Repair', 'Flat tire reported', GETDATE(), 1),
(4, 'System', 'GPS module not responding', GETDATE(), 0);

INSERT INTO Alert (BikeID, AlertType, AlertMessage, CreatedAt, IsResolved)
VALUES
(19, 'Repair', 'Chain slipped, requires adjustment', GETDATE(), 0),
(20, 'Battery', 'Low battery warning', GETDATE(), 1),
(21, 'Maintenance', 'Periodic check due', GETDATE(), 0),
(22, 'System', 'Brake sensor malfunction', GETDATE(), 1),
(23, 'GPS', 'Lost connection intermittently', GETDATE(), 0);
