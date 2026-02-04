-- =====================================================
-- Topic: Queries - Joins (INNER/LEFT/RIGHT/FULL)
-- File: queries/joins.sql
-- =====================================================

-- d) Joins
SELECT R.RentalID, U.UserID, U.Email, S.StationID, S.StationName
FROM Rental R
INNER JOIN [User] U ON R.UserID = U.UserID
INNER JOIN Bike B ON R.BikeID = B.BikeID
INNER JOIN Station S ON B.StationID = S.StationID

SELECT U.UserID, U.Email, F.Rating, F.Comment
FROM [User] U
LEFT JOIN Feedback F ON U.UserID = F.UserID
ORDER BY F.Rating DESC;

SELECT T.TeamName, M.BikeID, M.IssueDescription, M.RepairDate
FROM MaintenanceLog M
RIGHT JOIN MaintenanceTeam T ON M.TeamID = T.TeamID
ORDER BY T.TeamName;

SELECT B.BikeID, B.Model, F.Rating, F.Comment, M.IssueDescription
FROM Bike B
FULL JOIN Feedback F ON B.BikeID = F.BikeID
FULL JOIN MaintenanceLog M ON B.BikeID = M.BikeID
ORDER BY B.BikeID;
