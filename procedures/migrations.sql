-- =====================================================
-- Topic: Schema Versioning - Migration Procedures
-- File: procedures/migrations.sql
-- =====================================================

CREATE PROCEDURE ModifyColumnType(
    @TableName VARCHAR(255),
    @ColumnName VARCHAR(255),
    @NewType VARCHAR(255))
AS 
BEGIN 
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'ALTER TABLE [' + @TableName + '] ALTER COLUMN [' + @ColumnName + ']' + ' ' + @NewType;
    EXEC sp_executesql @SQL;
    UPDATE Version
    SET VersionNumber = VersionNumber + 1;
END;

CREATE PROCEDURE ModifyRatingColumnType
AS 
BEGIN
    ALTER TABLE Feedback
    ALTER COLUMN Rating VARCHAR(255) NULL;

    UPDATE Version
    SET VersionNumber = VersionNumber + 1;
END;

CREATE PROCEDURE UndoModifyRatingColumnType
AS 
BEGIN
    ALTER TABLE Feedback
    ALTER COLUMN Rating INT NULL;

    UPDATE Version
    SET VersionNumber = VersionNumber - 1;
END;

CREATE PROCEDURE AddTypeColumn
AS 
BEGIN
    ALTER TABLE Feedback
    ADD Type VARCHAR(255);

    UPDATE Version
    SET VersionNumber = VersionNumber + 1;
END;

CREATE PROCEDURE RemoveTypeColumn
AS
BEGIN
    ALTER TABLE Feedback
    DROP COLUMN Type;

    UPDATE Version
    SET VersionNumber = VersionNumber - 1;
END;

CREATE PROCEDURE AddDefaultConstraint
AS
BEGIN
    ALTER TABLE Feedback
    ADD CONSTRAINT DF_Feedback_Rating DEFAULT(5) FOR Rating;

    UPDATE Version
    SET VersionNumber += 1;
END;

CREATE PROCEDURE RemoveDefaultConstraint
AS
BEGIN
    ALTER TABLE Feedback
    DROP CONSTRAINT DF_Feedback_Rating;

    UPDATE Version
    SET VersionNumber -= 1;
END;

CREATE PROCEDURE AddPrimaryKey
AS
BEGIN
    CREATE TABLE Temp(
    Tid INT NOT NULL,
    CNP VARCHAR(255) NOT NULL);
    
    ALTER TABLE Temp
    ADD CONSTRAINT PK_Temp_Tid PRIMARY KEY (Tid);

    UPDATE Version
    SET VersionNumber += 1;
END;

CREATE PROCEDURE RemovePrimaryKey
AS
BEGIN
    ALTER TABLE Temp
    DROP CONSTRAINT PK_Temp_Tid;

    IF OBJECT_ID('dbo.Temp', 'U') IS NOT NULL
        DROP TABLE Temp;
    
    UPDATE Version
    SET VersionNumber -= 1;
END;

CREATE PROCEDURE AddCandidateKey
AS
BEGIN
    ALTER TABLE Temp
    ADD CONSTRAINT UQ_Temp_CNP UNIQUE (CNP);

    UPDATE Version
    SET VersionNumber += 1;
END;

CREATE PROCEDURE RemoveCandidateKey
AS
BEGIN
    ALTER TABLE Temp
    DROP CONSTRAINT UQ_Temp_CNP;
    
    UPDATE Version
    SET VersionNumber -= 1;
END;

CREATE PROCEDURE AddForeignKey
AS
BEGIN
    ALTER TABLE Feedback
    ADD Tid INT;

    ALTER TABLE Feedback
    ADD CONSTRAINT FK_Feedback_Temp
    FOREIGN KEY (Tid) REFERENCES Temp(Tid);

    UPDATE Version
    SET VersionNumber += 1;
END;

CREATE PROCEDURE RemoveForeignKey
AS
BEGIN
    ALTER TABLE Feedback
    DROP CONSTRAINT FK_Feedback_Temp;

    ALTER TABLE Feedback
    DROP COLUMN Tid;

    UPDATE Version
    SET VersionNumber -= 1;
END;

CREATE PROCEDURE CreateTable
AS
BEGIN
    CREATE TABLE New(Test INT)
    UPDATE Version
    SET VersionNumber += 1;
END;

CREATE PROCEDURE DropTable
AS
BEGIN
    IF OBJECT_ID('dbo.New', 'U') IS NOT NULL
        DROP TABLE New
    UPDATE Version
    SET VersionNumber -= 1;  
END;
