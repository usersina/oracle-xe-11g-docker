## Initializing the data

1. Copy the init sql files in the running `oracledb` container

```bash
docker cp . oracledb:/u01/app/oracle/use_case/
```

2. Run a shell instance to the database

```bash
docker exec -it oracledb /bin/bash # or make shell from the root dir
```

3. Open `sqlplus` as `system`

```bash
sqlplus system
```

4. Inside the `sqlplus` shell, run the scripts in this order

```sql
-- create new user
SQL> CREATE USER NORTHWIND IDENTIFIED BY NORTHWIND;

-- grant privileges
SQL> GRANT CONNECT, RESOURCE, DBA TO NORTHWIND;

-- switch to the created user
SQL> CONNECT NORTHWIND;

-- run the sql script as the new user
SQL> @/u01/app/oracle/use_case/northwind_data.sql
```
