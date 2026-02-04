-- =====================================================
-- Topic: Queries - Set Operations (UNION/INTERSECT/EXCEPT)
-- File: queries/set_operations.sql
-- =====================================================

-- a) 2 queries with the union operation; use UNION [ALL] and OR;
SELECT 
    B.BikeID,
    'Maintenance Needed' AS IssueType,
    M.IssueDescription AS Details
FROM MaintenanceLog M
JOIN Bike B ON M.BikeID = B.BikeID
WHERE M.RepairDate IS NULL 
   OR M.IssueDescription LIKE '%brake%'

UNION

SELECT 
    A.BikeID,
    'Active Alert' AS IssueType,
    A.AlertMessage AS Details
FROM Alert A
WHERE A.IsResolved = 0;

SELECT 
    U.UserID, 
    U.Email, 
    'Feedback Given' AS Activity
FROM [User] U
JOIN Feedback F ON U.UserID = F.UserID
WHERE F.Rating >= 4 
   OR F.Comment LIKE '%good%'

UNION ALL

SELECT 
    U.UserID, 
    U.Email, 
    'Recent Rental' AS Activity
FROM [User] U
JOIN Rental R ON U.UserID = R.UserID
WHERE R.EndTime > '2025-10-01';

-- b) 2 queries with the intersection operation; use INTERSECT and IN; 
SELECT U.UserID, U.Email
FROM [User] U
JOIN Membership M ON U.MembershipID = M.MembershipID
WHERE M.Type = 'Premium'
  AND U.UserID IN (
      SELECT R.UserID
      FROM Rental R
      JOIN Bike B ON R.BikeID = B.BikeID
      JOIN Station S ON B.StationID = S.StationID
      WHERE S.Capacity > 10
  )

INTERSECT

SELECT U.UserID, U.Email
FROM Feedback F
JOIN [User] U ON F.UserID = U.UserID
WHERE F.Rating >= 4;

SELECT BikeID
FROM Rental
WHERE BikeID IN (
    SELECT BikeID FROM Bike WHERE Status = 'In Maintenance'
)

INTERSECT

SELECT BikeID
FROM MaintenanceLog
WHERE IssueDescription IS NOT NULL;

-- c) 2 queries with the difference operation; use EXCEPT and NOT IN;
SELECT BikeID, Model, [Status]
FROM Bike 

EXCEPT

SELECT DISTINCT B.BikeID, Model, [Status]
FROM Bike B
JOIN Rental R ON B.BikeID = R.BikeID

SELECT U.UserID, Email
FROM [User] U
JOIN Rental R ON U.UserID = R.UserID
WHERE U.UserID NOT IN (
    SELECT DISTINCT F.UserID
    FROM Feedback F
    );
