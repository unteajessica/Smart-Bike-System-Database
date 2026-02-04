-- =====================================================
-- Topic: Schema Versioning - Demo Run
-- File: procedures/demo_run.sql
-- =====================================================

EXEC goToVersionState @newVersion = 0;
SELECT VersionNumber FROM Version
