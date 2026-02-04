-- =====================================================
-- Topic: Indexing Lab - Schema Changes
-- File: indexing_optimization/schema_changes.sql
-- =====================================================

ALTER TABLE dbo.MaintenanceTeam
ADD RoomNr INT NULL;

UPDATE dbo.MaintenanceTeam
SET RoomNr = 101
WHERE TeamID = 1;

UPDATE dbo.MaintenanceTeam
SET RoomNr = 102
WHERE TeamID = 2;

UPDATE dbo.MaintenanceTeam
SET RoomNr = 103
WHERE TeamID = 3;

ALTER TABLE dbo.MaintenanceTeam
ALTER COLUMN RoomNr INT NOT NULL;

ALTER TABLE dbo.MaintenanceTeam
ADD CONSTRAINT UQ_MaintenanceTeam_RoomNr UNIQUE (RoomNr);
