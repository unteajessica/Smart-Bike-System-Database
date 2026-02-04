-- =====================================================
-- Topic: Queries - Subqueries (IN/EXISTS/FROM)
-- File: queries/subqueries.sql
-- =====================================================

-- IN (nested)
SELECT U.UserID, U.Email
FROM [User] U
WHERE U.UserID IN (
    SELECT R.UserID
    FROM Rental R
    WHERE R.BikeID IN (
        SELECT B.BikeID
        FROM Bike B
        WHERE B.StationID IN (
            SELECT S.StationID
            FROM Station S
            WHERE S.City = 'Cluj-Napoca'
        )
    )
);

SELECT T.TeamID, T.TeamName
FROM MaintenanceTeam T
WHERE T.TeamID IN (
    SELECT M.TeamID
    FROM MaintenanceLog M
    WHERE M.BikeID IN (
        SELECT B.BikeID
        FROM Bike B
        WHERE B.BikeID IN (
            SELECT R.BikeID
            FROM Rental R
            JOIN [User] U ON R.UserID = U.UserID
            WHERE U.MembershipID IN (
                SELECT MEM.MembershipID
                FROM Membership MEM
                WHERE MEM.[Type] = 'DAY RIDE'
             )
        )
    )
);

-- EXISTS
SELECT R.RentalID, R.BikeID
FROM Rental R
WHERE EXISTS ( SELECT 1 FROM Alert A
                WHERE A.BikeID = R.BikeID AND A.isresolved = 0);

SELECT U.UserID, U.Email
FROM [User] U
WHERE EXISTS ( SELECT 1 FROM Rental R WHERE R.UserID = U.UserID );

-- subquery in FROM
SELECT DISTINCT X.UserID, X.Email
FROM ( SELECT U.UserID, U.Email FROM [User] U JOIN Rental R ON 
        U.UserID = R.UserID) X

SELECT X.UserID, X.Email
FROM ( SELECT U.UserID, U.Email FROM [User] U JOIN Membership M ON
        U.MembershipID = M.MembershipID WHERE M.Type = 'MONTH RIDE') X;
