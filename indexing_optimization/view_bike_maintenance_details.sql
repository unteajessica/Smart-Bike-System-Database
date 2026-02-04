-- =====================================================
-- Topic: Indexing Lab - View
-- File: indexing_optimization/view_bike_maintenance_details.sql
-- =====================================================

go
create view BikeMaintenanceDetails
as
select ml.LogID, ml.IssueDescription,
        b.BikeID, b.Model, b.Status, b.StationID,
        mt.TeamID, mt.TeamName, mt.PhoneNumber
from MaintenanceLog ml
join Bike b on b.BikeID = ml.BikeID
join MaintenanceTeam mt on mt.TeamID = ml.TeamID
where b.Status = 'Maintenance';
go

select * from BikeMaintenanceDetails;
