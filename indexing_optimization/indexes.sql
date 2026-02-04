-- =====================================================
-- Topic: Indexing Lab - Indexes
-- File: indexing_optimization/indexes.sql
-- =====================================================

if exists (select name from sys.indexes where name = N'N_idx_StationID')
drop index N_idx_StationID on Bike
GO

create nonclustered index N_idx_StationID
on Bike(StationID)
include (BikeId, [Model]);
GO

create nonclustered index N_idx_Status
on Bike(Status)
include (BikeID, Model, StationID);

create nonclustered index N_idx_log_BikeID
on MaintenanceLog(BikeID)
include (LogID, IssueDescription, TeamID);
