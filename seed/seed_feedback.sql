-- =====================================================
-- Topic: Seed Data - Feedback
-- File: seed/seed_feedback.sql
-- =====================================================

INSERT INTO Feedback (UserID, BikeID, Rating, Comment)
VALUES
(1, 1, 5, 'Smooth ride and easy to use.'),
(2, 2, 4, 'Good bike, but the seat was a bit high.'),
(3, 3, 3, 'Average experience, needs cleaning.'),
(1, 2, 5, 'Loved the electric assist feature!'),
(2, 1, 4, 'Worked perfectly for my short trip.');

INSERT INTO Feedback (UserID, BikeID, Rating, Comment)
VALUES
(7, 15, 5, 'Loved the CityRide Gen1, smooth ride!'),
(8, 16, 4, 'Good performance, very comfortable.'),
(9, 17, 3, 'Average experience.'),
(10, 18, 5, 'Great speed, but battery drains fast.');

INSERT INTO Feedback (UserID, BikeID, Rating, Comment)
VALUES
(11, 19, 5, 'Amazing ride, very smooth!'),
(12, 20, 4, 'Good but seat needs adjustment.'),
(13, 21, 3, 'Mediocre, needs tune-up.'),
(14, 22, 5, 'Excellent bike, highly recommend.'),
(15, 23, 2, 'Battery drained quickly.');

INSERT INTO Feedback (UserID, BikeID, Rating, Comment)
VALUES
(11, 20, 5, 'Fantastic performance!'),
(12, 21, 3, 'Average ride, brakes weak.');
