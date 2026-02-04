-- =====================================================
-- Topic: Seed Data - Users
-- File: seed/seed_users.sql
-- =====================================================

INSERT INTO [User](Email, MembershipID)
VALUES
('jessica@yahoo.com', 3),
('vanessza@yahoo.com', 2),
('antonia@yahoo.com',1);

INSERT INTO [User] (Email, MembershipID)
VALUES 
('alex@email.com', 1),
('maria@email.com', 2),
('john@email.com', 1),
('emma@email.com', 3);

INSERT INTO [User] (Email, MembershipID)
VALUES
('george@email.com', 4),  -- Premium
('laura@email.com', 1),   -- Day Ride
('matthew@email.com', 2), -- Week Ride
('sophia@email.com', 3),  -- Month Ride
('nora@email.com', 5);    -- Trial
