-- =====================================================
-- Topic: Schema Versioning - Metadata Seed
-- File: procedures/versioning_seed.sql
-- =====================================================

INSERT INTO Version(VersionNumber) VALUES(0);

INSERT INTO ProceduresTable(fromVersion, toVersion, ProcedureName)
VALUES
(0, 1, 'ModifyRatingColumnType'),
(1, 0, 'UndoModifyRatingColumnType'),
(1, 2, 'AddTypeColumn'),
(2, 1, 'RemoveTypeColumn'),
(2,3,'AddDefaultConstraint'),
(3,2, 'RemoveDefaultConstraint'),
(3,4, 'AddPrimaryKey'),
(4,3, 'RemovePrimaryKey'),
(4,5, 'AddCandidateKey'),
(5,4, 'RemoveCandidateKey'),
(5,6, 'AddForeignKey'),
(6,5, 'RemoveForeignKey'),
(6,7, 'CreateTable'),
(7,6, 'DropTable');
