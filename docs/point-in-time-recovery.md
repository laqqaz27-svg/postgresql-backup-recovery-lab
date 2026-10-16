# Point-in-Time Recovery (PITR)

## Purpose
PITR restores a physical base backup and replays archived WAL records until a configured recovery target.

## Configuration used in this lab
The primary server used WAL archiving:

```conf
wal_level = replica
archive_mode = on
archive_command = 'cp %p /backups/wal/%f'
```

The recovery container used a restore command and a target timestamp. The timestamp must be recorded from the actual test before the destructive change is made.

Example recovery settings:

```conf
restore_command = 'cp /backups/wal/%f %p'
recovery_target_time = 'YYYY-MM-DD HH:MM:SS+00'
recovery_target_action = 'promote'
```

Replace the placeholder timestamp with the exact timestamp recorded during your own run. Do not use a made-up time. PostgreSQL 12 and later use a standby signal file and settings in the data directory or command line to initiate recovery; there is no need to create the legacy recovery.conf file.

## Verification
After recovery completes, connect to the recovered database and run:

```sql
SELECT * FROM students ORDER BY id;
SELECT pg_is_in_recovery();
```

For the lab run recorded in `evidence/verification-results.md`, recovery returned the three records present at the chosen target time, and `pg_is_in_recovery()` returned `false` after promotion.
