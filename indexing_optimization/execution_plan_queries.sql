-- =====================================================
-- Topic: Indexing Lab - Execution Plan Queries
-- File: indexing_optimization/execution_plan_queries.sql
-- =====================================================

-- Ta = MaintenanceTeam
select * from MaintenanceTeam
order by TeamName desc

select TeamName
from MaintenanceTeam
where TeamId > 2

select * from MaintenanceTeam
order by RoomNr;

select RoomNr
from MaintenanceTeam
where RoomNr = 102;

select TeamName, PhoneNumber
from MaintenanceTeam
where RoomNr = 101;

-- Tb = Bike
select BikeId, [Model] 
from Bike
where StationID = 1;

select BikeID, [Model]
from Bike
where StationID = 1;
