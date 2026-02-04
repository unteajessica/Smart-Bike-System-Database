-- =====================================================
-- Topic: Schema Versioning - goToVersionState
-- File: procedures/goToVersionState.sql
-- =====================================================

CREATE PROCEDURE goToVersionState (@newVersion INT) 
AS
BEGIN
    DECLARE @fromVersion INT;
    DECLARE @procedureName VARCHAR(255);
    DECLARE @SQL NVARCHAR(MAX);

    SELECT @fromVersion = VersionNumber
    FROM Version

    IF @fromVersion > (select max(toVersion) from ProceduresTable)
        RAISERROR('Invalid version', 16, 1);
    IF @fromVersion < (select min(fromVersion) from ProceduresTable)
        RAISERROR('Invalid version', 16, 1);

    WHILE @fromVersion < @newVersion
    BEGIN
        SELECT @procedureName = ProcedureName
        FROM ProceduresTable
        WHERE fromVersion = @fromVersion AND toVersion = @fromVersion + 1;

        PRINT 'Procedure to execute: ' + @procedureName;

        -- IMPORTANT: added missing space after EXEC
        SET @SQL = 'EXEC ' + QUOTENAME(@procedureName);
        EXEC sp_executesql @SQL;

        SET @fromVersion += 1;

        UPDATE Version
        SET VersionNumber = @fromVersion;
    END;

    WHILE @fromVersion > @newVersion
    BEGIN
        SELECT @procedureName = ProcedureName
        FROM ProceduresTable
        WHERE fromVersion = @fromVersion AND toVersion = @fromVersion - 1;

        PRINT 'Procedure to execute: ' + @procedureName;

        SET @SQL = 'EXEC ' + QUOTENAME(@procedureName);
        EXEC sp_executesql @SQL;

        SET @fromVersion -= 1;

        UPDATE Version
        SET VersionNumber = @fromVersion;
    END;

END;
