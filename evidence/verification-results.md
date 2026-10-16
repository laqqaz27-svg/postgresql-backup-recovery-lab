# Verification Results

These are the results observed during the lab run and recorded in the working session. Counts and container IP addresses can differ on a fresh run. Use `scripts/03-capture-replication-checks.sh` to capture fresh output from your current containers.

## WAL archiving

The primary server's `pg_stat_archiver` check showed:

```text
archived_count = 4
failed_count   = 0
```

## Streaming replication: primary

Command:

```sql
SELECT client_addr, application_name, state, sync_state
FROM pg_stat_replication;
```

Observed row:

```text
client_addr | application_name | state     | sync_state
172.18.0.1  | walreceiver      | streaming | async
```

## Streaming replication: standby

Command:

```sql
SELECT status, sender_host, sender_port FROM pg_stat_wal_receiver;
```

Observed row:

```text
status    | sender_host | sender_port
streaming | 172.18.0.1  | 5432
```

The standby also returned `pg_is_in_recovery() = t`, confirming it was in recovery/standby mode.

## Replicated data

After inserting Grace's test record on the primary, the standby query:

```sql
SELECT * FROM students ORDER BY id;
```

returned:

```text
1 | Amina | Database Administration
2 | John  | Python Programming
3 | Mary  | Web Development
4 | Grace | PostgreSQL Replication Test
```

## Point-in-time recovery

The recovery container replayed WAL to the configured target time and was promoted. The recovered database returned the three records that existed at the target time (Amina, John, and Mary). The query `SELECT pg_is_in_recovery();` returned `f` after promotion.

## Important limitation

These excerpts document the checks observed during the lab session; they are not a substitute for fresh raw output from a rerun. Capture current primary and standby results with `scripts/03-capture-replication-checks.sh` and commit the generated `evidence/replication-checks.txt` if the containers are still available.
