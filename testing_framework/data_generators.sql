-- =====================================================
-- Topic: Performance Testing Framework - Data Generator Procedures
-- File: 06_testing_framework/02_data_generators.sql
-- =====================================================

CREATE OR ALTER PROCEDURE usp_GenerateStations @NoOfRows INT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @i INT = 1;

    WHILE @i <= @NoOfRows
    BEGIN
        INSERT INTO Station (StationName, City, Capacity)
        VALUES (
            CONCAT('Station ', @i),               -- StationName
            CASE (@i % 4)                         -- City (rotate between 4 cities)
                WHEN 0 THEN 'Bucharest'
                WHEN 1 THEN 'Cluj-Napoca'
                WHEN 2 THEN 'Iasi'
                ELSE        'Timisoara'
            END,
            10 + (@i % 41)                        -- Capacity between 10 and 50
        );

        SET @i = @i + 1;
    END
END;

GO
CREATE OR ALTER PROCEDURE usp_GenerateAlerts @NoOfRows INT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MaxBikeId INT = 4;
    DECLARE @j INT = 1;

    WHILE @j <= @NoOfRows
    BEGIN
        DECLARE @BikeId INT =
            (ABS(CHECKSUM(NEWID())) % @MaxBikeId) + 1;   -- random bike between 1 and MaxBikeId;
        DECLARE @AlertType VARCHAR(50) =
            CASE (@j % 4)
                WHEN 0 THEN 'Flat tire'
                WHEN 1 THEN 'Brake issue'
                WHEN 2 THEN 'Low battery'
                ELSE        'Software error'
            END;
        DECLARE @CreatedAt DATETIME =
            DATEADD(DAY, - (ABS(CHECKSUM(NEWID())) % 30),  -- random day in last 30 days
                DATEADD(MINUTE, @j % 1440, GETDATE()));-- random minute in the day
        DECLARE @IsResolved BIT =
            CASE WHEN @j % 3 = 0 THEN 1 ELSE 0 END;       -- ~1/3 resolved

        INSERT INTO Alert (BikeID, AlertType, AlertMessage, CreatedAt, isresolved)
        VALUES (
            @BikeId,
            @AlertType,
            CONCAT(@AlertType, ' detected on bike ', @BikeId),
            @CreatedAt,
            @IsResolved
        );

        SET @j = @j + 1;
    END
END;
GO

GO
CREATE OR ALTER PROCEDURE usp_GenerateUserFavoriteStation @NoOfRows INT AS
BEGIN
    SET NOCOUNT ON;
    ;WITH AllPairs AS (
        SELECT 
            u.UserID,
            s.StationID,
            ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
        FROM [User] u
        CROSS JOIN Station s
    )
    INSERT INTO UserFavoriteStation (UserID, StationID, AddedAt, IsHome)
    SELECT TOP (@NoOfRows)
           UserID,
           StationID,
           DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE()),  -- last 30 days
           CASE WHEN ABS(CHECKSUM(NEWID())) % 5 = 0 THEN 1 ELSE 0 END  -- ~20% IsHome
    FROM AllPairs
    ORDER BY rn;
END;
GO
