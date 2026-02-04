-- =====================================================
-- Topic: Queries - ANY/ALL + Rewrites
-- File: queries/any_all.sql
-- =====================================================

SELECT R.BikeID
FROM Rental R
WHERE R.TotalCost > ANY(
    SELECT R2.TotalCost
    FROM Rental R2
    JOIN [User] U ON R2.UserID = U.UserID
    JOIN Membership M ON U.MembershipID = M.MembershipID
    WHERE M.[Type] = 'Day Ride'
    );

SELECT DISTINCT R.BikeID
FROM Rental R
WHERE R.TotalCost > (
    SELECT MIN(R2.TotalCost)
    FROM Rental R2
    JOIN [User] U2 ON U2.UserID = R2.UserID
    JOIN Membership M ON M.MembershipID = U2.MembershipID
    WHERE M.[Type] = 'Day Ride'
);

SELECT B.BikeID, B.Model
FROM Bike B
WHERE (
    SELECT AVG(R.TotalCost)
    FROM Rental R
    WHERE R.BikeID = B.BikeID
) > ALL (
    SELECT AVG(R2.TotalCost)
    FROM Rental R2
    WHERE R2.BikeID IN (
        SELECT BikeID FROM Bike WHERE Status LIKE '%Maintenance%'
    )
    GROUP BY R2.BikeID
);

SELECT R.RentalID
FROM Rental R
WHERE R.EndTime <= ALL (
    SELECT M.RepairDate
    FROM MaintenanceLog M
    WHERE M.BikeID = R.BikeID
    );

SELECT R.RentalID, R.BikeID, R.EndTime
FROM Rental R
WHERE R.RentalID NOT IN (
    SELECT R2.RentalID
    FROM Rental R2
    JOIN MaintenanceLog M ON M.BikeID = R2.BikeID
    WHERE R2.EndTime > M.RepairDate
);

SELECT DISTINCT T.TeamID, T.TeamName
FROM MaintenanceTeam T
WHERE T.TeamID = ANY (
    SELECT M.TeamID
    FROM MaintenanceLog M
    WHERE M.BikeID = ANY (
        SELECT DISTINCT R.BikeID
        FROM Rental R
        JOIN [User] U ON U.UserID = R.UserID
        JOIN Membership MEM ON MEM.MembershipID = U.MembershipID
        WHERE UPPER(MEM.[Type]) = 'DAY RIDE'
    )
);

SELECT DISTINCT T.TeamID, T.TeamName
FROM MaintenanceTeam T
WHERE T.TeamID IN (
    SELECT M.TeamID
    FROM MaintenanceLog M
    WHERE M.BikeID IN (
        SELECT DISTINCT R.BikeID
        FROM Rental R
        JOIN [User] U ON U.UserID = R.UserID
        JOIN Membership MEM ON MEM.MembershipID = U.MembershipID
        WHERE UPPER(MEM.[Type]) = 'DAY RIDE'
    )
);
