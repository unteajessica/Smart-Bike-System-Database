-- =====================================================
-- Topic: Performance Testing Framework - Demo Run
-- File: testing_framework/demo_run.sql
-- =====================================================

EXEC usp_GenerateStations @NoOfRows = 1000;
EXEC usp_GenerateAlerts @NoOfRows = 1000;
EXEC usp_GenerateUserFavoriteStation @NoOfRows = 1000;

SELECT COUNT(*) AS Stations FROM Station;
SELECT COUNT(*) AS Alerts FROM Alert;
SELECT COUNT(*) AS Favorites FROM UserFavoriteStation;

EXEC usp_RunTest @TestID = 1;
SELECT * FROM TestRuns        ORDER BY TestRunID DESC;

SELECT TOP 1 * 
FROM TestRuns
ORDER BY TestRunID DESC;

SELECT * FROM TestRunTables WHERE TestRunID = 1;
SELECT * FROM TestRunViews  WHERE TestRunID = 1;
