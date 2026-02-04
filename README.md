# Bike Rental Database (SQL Server)

A SQL Server database project that models a **city bike rental system** end-to-end (users, memberships, stations, bikes, rentals, payments, maintenance, and alerts).  
I built this to practice **relational data modeling** and to go beyond “just tables” by implementing **query patterns**, **schema versioning**, and **performance testing + indexing** using T-SQL.

---

## Tech Stack
- **Microsoft SQL Server** (T-SQL)
- **SQL Server Management Studio (SSMS)**

---

## Domain Model (High Level)
The database covers the full lifecycle of a bike rental platform:
- **Memberships** (pricing + duration)
- **Users**
- **Stations** (city + capacity)
- **Bikes** (model + status + station)
- **Rentals** (time interval + cost)
- **Payments**
- **Feedback** (rating + comment)
- **Maintenance teams & logs**
- **Alerts** (system/battery/repair + resolved state)

---

## Repository Structure
- `schema.sql` – full database schema (tables + constraints)
- `seed/` – dataset inserts split by entity (one topic per file)
- `DML_examples/` – UPDATE / DELETE scenarios
- `queries/` – organized query collection by concept
- `procedures/` – stored procedures (schema versioning + migrations)
- `testing_framework/` – performance testing framework (test runs, timings, data generators)
- `indexing_optimization/` – indexing experiments + execution plan queries + reporting view

---

## Implemented Concepts (Technical Highlights)

### 1) Data Modeling & Integrity
- Relational schema design with normalized entities
- Primary keys, foreign keys, candidate keys, and default constraints
- Consistent relationship modeling across the domain (e.g., user→rentals, bike→station, bike→maintenance logs)

### 2) Seed Data & Reproducibility
- Entity-based seeding scripts to quickly populate the database for demos and testing
- Repeatable data setup using structured SQL files

### 3) DML Scenarios (Realistic Operations)
Included realistic update/delete use-cases:
- Updating bike models and statuses based on conditions
- Assigning trial memberships
- Cleaning old logs or resolved alerts based on filters and state

### 4) Advanced Querying Patterns (in `queries/`)
A curated set of queries demonstrating key SQL patterns used in real systems:

- **Set operations**: `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`
- **Joins**: `INNER`, `LEFT`, `RIGHT`, `FULL` (including multi-table joins)
- **Subqueries**: nested `IN`, `EXISTS`, and subqueries in the `FROM` clause
- **Aggregations**: `GROUP BY`, `HAVING` + `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- **Quantifiers**: `ANY` / `ALL` + equivalent rewrites with aggregates and `IN/NOT IN`

These were implemented as a “query portfolio” to validate correctness and to practice writing clear, optimized SQL.

### 5) Schema Versioning with Stored Procedures (in `procedures/`)
Implemented a lightweight **database schema versioning mechanism**:
- A `Version` table tracks the current schema version
- `ProceduresTable` defines forward/backward migration steps
- `goToVersionState` moves the database to any target version by executing the correct migration/rollback procedures

Supported migration operations include:
- Modify column type (and reverse)
- Add/remove a column
- Add/remove a DEFAULT constraint
- Add/remove primary key
- Add/remove candidate key
- Add/remove foreign key
- Create/drop a table

### 6) Performance Testing Framework (in `testing_framework/`)
Built a small framework for measuring database performance:
- Data generation procedures for controlled scaling (row count)
- Test runner procedure to record performance metadata
- Tracking of test runs and timing results (tables/views)

This helps evaluate how query performance changes with larger datasets.

### 7) Indexing & Optimization (in `indexing_optimization/`)
Explored performance improvements using:
- Non-clustered indexes (with `INCLUDE` columns)
- Execution-plan oriented queries for before/after analysis
- A reporting view (`BikeMaintenanceDetails`) joining Bike + MaintenanceLog + MaintenanceTeam

---

## How to Run (SSMS)

### 1) Create the schema
1. Open `schema.sql` in SSMS
2. Execute the script to create all database objects

### 2) Insert sample data
Run the seed scripts in order (recommended):
1. `seed/01_seed_membership.sql`
2. `seed/02_seed_users.sql`
3. `seed/03_seed_stations.sql`
4. `seed/04_seed_bikes.sql`
5. `seed/05_seed_rentals.sql`
6. `seed/06_seed_payments.sql`
7. `seed/07_seed_feedback.sql`
8. `seed/08_seed_maintenance_teams.sql`
9. `seed/09_seed_maintenance_logs.sql`
10. `seed/10_seed_alerts.sql`

### 3) Explore queries and advanced features
- Run any file inside `queries/` to explore SQL patterns
- Run `procedures/99_demo_run.sql` to test schema versioning
- Run `testing_framework/99_demo_run.sql` to generate data and execute performance tests
- Run scripts in `indexing_optimization/` to evaluate indexes + views

---

## Notes
- The project is designed to be reproducible from scripts alone (schema + seed + features).
- It can be extended with additional stored procedures, views, and reporting queries.
