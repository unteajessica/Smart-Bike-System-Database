-- =====================================================
-- Topic: Queries - Aggregations (GROUP BY/HAVING)
-- File: queries/aggregations.sql
-- =====================================================

SELECT U.UserID, U.Email, COUNT(R.RentalID) AS TotalRentals
FROM [User] U
JOIN Rental R ON U.UserID = R.UserID
GROUP BY U.UserID, U.Email
HAVING COUNT(R.RentalID) > 0
ORDER BY TotalRentals DESC;

SELECT U.UserID, U.Email, COUNT(R.RentalID) AS UserRentals
FROM [User] U
JOIN Rental R ON U.UserID = R.UserID
GROUP BY U.UserID, U.Email
HAVING COUNT(R.RentalID) > ( 
    SELECT AVG(UserCount)
    FROM ( 
        SELECT COUNT(R2.RentalID) AS UserCount
        FROM Rental R2
        GROUP BY R2.UserID ) AS Subquery
   )
ORDER BY UserRentals DESC;

SELECT B.BikeID, B.Model, SUM(R.TotalCost) AS RentalIncome
FROM Bike B
JOIN Rental R ON B.BikeID = R.BikeID
GROUP BY B.BikeID, B.Model
HAVING SUM(R.TotalCost) > ( 
    SELECT AVG(BikeIncome)
    FROM (
        SELECT SUM(R2.TotalCost) AS BikeIncome
        FROM Rental R2
        GROUP BY R2.BikeID ) AS Subquery
    )
ORDER BY RentalIncome DESC;

SELECT T.TeamID, T.TeamName, COUNT(M.LogID) AS TeamRepairs
FROM MaintenanceTeam T
JOIN MaintenanceLog M ON T.TeamID = M.TeamID
GROUP BY T.TeamID, T.TeamName
HAVING COUNT(M.LogID) > (
    SELECT AVG(RepTeam)
    FROM (
        SELECT COUNT(M2.LogID) AS RepTeam
        FROM MaintenanceLog M2
        GROUP BY M2.TeamID ) AS Subquery
    )
ORDER BY TeamRepairs DESC;
