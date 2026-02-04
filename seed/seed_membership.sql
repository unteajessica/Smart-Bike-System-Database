-- =====================================================
-- Topic: Seed Data - Membership
-- File: seed/seed_membership.sql
-- =====================================================

INSERT INTO Membership(Type, Price, DurationDays)
VALUES 
('Day Ride', 5.00, 1),
('Week Ride', 20.00, 7),
('Month Ride', 60.00, 30);

INSERT INTO Membership (Type, Price, DurationDays)
VALUES
('Premium', 100.00, 90),
('Trial', 0.00, 3);
