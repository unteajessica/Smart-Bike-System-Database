-- =====================================================
-- Topic: Performance Testing Framework - Test Runner Procedure
-- File: testing_framework/run_test.sql
-- =====================================================

CREATE OR ALTER PROCEDURE usp_RunTest
    @TestID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 0. Validate test

    DECLARE @TestName NVARCHAR(100);
    SELECT @TestName = Name
    FROM Tests
    WHERE TestID = @TestID;

    IF @TestName IS NULL
    BEGIN
        RAISERROR('Invalid TestID %d', 16, 1, @TestID);
        RETURN;
    END;

    -- 1. Insert row in TestRuns

    DECLARE @startRun DATETIME = GETDATE();
    DECLARE @TestRunID INT;

    INSERT INTO TestRuns(Description, StartAt, EndAt)
    VALUES (CONCAT('Run for test ', @TestName, ' at ', CONVERT(VARCHAR(19), @startRun, 120)),
            @startRun,
            @startRun);  -- EndAt will be updated later

    SET @TestRunID = SCOPE_IDENTITY();

    -- 2. DELETE test data from tables (Position ASC)

    DECLARE @TableID INT, @TableName SYSNAME, @NoOfRows INT;

    DECLARE curDel CURSOR FOR
        SELECT tt.TableID, t.Name, tt.NoOfRows
        FROM TestTables tt
        JOIN Tables t ON tt.TableID = t.TableID
        WHERE tt.TestID = @TestID
        ORDER BY tt.Position ASC;      -- delete children first

    OPEN curDel;
    FETCH NEXT FROM curDel INTO @TableID, @TableName, @NoOfRows;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @sqlDel NVARCHAR(MAX);

        IF @TableName = 'Station'
        BEGIN
            -- delete only the newest @NoOfRows stations
            SET @sqlDel = N'
                WITH ToDelete AS (
                    SELECT TOP (' + CAST(@NoOfRows AS NVARCHAR(10)) + N') s.StationID
                    FROM Station s
                    WHERE NOT EXISTS (
                        SELECT 1 FROM Bike b
                        WHERE b.StationID = s.StationID
                    )
                    ORDER BY s.StationID DESC
                )
                DELETE FROM Station
                WHERE StationID IN (SELECT StationID FROM ToDelete);';
        END
        ELSE
        BEGIN
            -- default: delete all rows from that table
            SET @sqlDel = N'DELETE FROM ' + QUOTENAME(@TableName) + N';';
        END

        EXEC (@sqlDel);

        FETCH NEXT FROM curDel INTO @TableID, @TableName, @NoOfRows;
    END


    CLOSE curDel;
    DEALLOCATE curDel;

    -- 3. INSERT data into tables (Position DESC) and log to TestRunTables

    DECLARE curIns CURSOR FOR
        SELECT tt.TableID, t.Name, tt.NoOfRows
        FROM TestTables tt
        JOIN Tables t ON tt.TableID = t.TableID
        WHERE tt.TestID = @TestID
        ORDER BY tt.Position DESC;     -- insert parents first

    OPEN curIns;
    FETCH NEXT FROM curIns INTO @TableID, @TableName, @NoOfRows;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @startIns DATETIME = GETDATE();

        IF @TableName = 'Station'
            EXEC usp_GenerateStations @NoOfRows;
        ELSE IF @TableName = 'Alert'
            EXEC usp_GenerateAlerts @NoOfRows;
        ELSE IF @TableName = 'UserFavoriteStation'
            EXEC usp_GenerateUserFavoriteStation @NoOfRows;
        -- add more ELSE IF branches if you add more tables to tests

        DECLARE @endIns DATETIME = GETDATE();

        INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
        VALUES (@TestRunID, @TableID, @startIns, @endIns);

        FETCH NEXT FROM curIns INTO @TableID, @TableName, @NoOfRows;
    END

    CLOSE curIns;
    DEALLOCATE curIns;

    -- 4. Evaluate views and log to TestRunViews

    DECLARE @ViewID INT, @ViewName SYSNAME;

    DECLARE curView CURSOR FOR
        SELECT tv.ViewID, v.Name
        FROM TestViews tv
        JOIN Views v ON tv.ViewID = v.ViewID
        WHERE tv.TestID = @TestID;

    OPEN curView;
    FETCH NEXT FROM curView INTO @ViewID, @ViewName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @startView DATETIME = GETDATE();

        DECLARE @sqlView NVARCHAR(MAX) =
            N'SELECT * FROM ' + QUOTENAME(@ViewName) + N';';

        EXEC (@sqlView);

        DECLARE @endView DATETIME = GETDATE();

        INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
        VALUES (@TestRunID, @ViewID, @startView, @endView);

        FETCH NEXT FROM curView INTO @ViewID, @ViewName;
    END

    CLOSE curView;
    DEALLOCATE curView;

    -- 5. Finish test run

    UPDATE TestRuns
    SET EndAt = GETDATE()
    WHERE TestRunID = @TestRunID;
END;
GO
