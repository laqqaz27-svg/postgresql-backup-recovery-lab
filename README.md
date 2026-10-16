# PostgreSQL Backup and Recovery Lab

## Project Overview
This lab demonstrates PostgreSQL backups, restoration, point-in-time recovery (PITR), WAL archiving, and streaming replication using Docker.

## Technologies
- PostgreSQL 18
- Docker
- Docker Compose
- Git and GitHub

## Lab Activities

### 1. Logical Backup and Restore
Created a custom-format database backup using pg_dump, restored it into bootcamp_check, and verified the restored student records.

### 2. Physical Backup
Created a physical PostgreSQL base backup using pg_basebackup.

### 3. WAL Archiving
Enabled WAL archiving and verified archived WAL files and archiver statistics.

### 4. Point-in-Time Recovery
Recovered a database to a specified timestamp and verified the recovered records.

### 5. Streaming Replication
Configured a primary PostgreSQL server and a standby server. Verified that the WAL receiver status was streaming, then inserted a test record into the primary and confirmed it appeared on the standby.

## Replication Test Records
- Amina — Database Administration
- John — Python Programming
- Mary — Web Development
- Grace — PostgreSQL Replication Test

## Start the Primary Database
Run:

    docker compose up -d

This starts the primary service defined in compose.yaml. The separately created standby container is managed independently.

## Backup Safety
Database dumps, physical backups, and WAL archives are stored locally under backups/ and excluded from Git using .gitignore.

## Learning Outcomes
- Creating and restoring logical and physical backups
- Understanding WAL archiving and point-in-time recovery
- Configuring PostgreSQL streaming replication
- Verifying replication using PostgreSQL system views
