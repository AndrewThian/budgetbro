# budgetbro 💸 💸 💸

## ❗️Caution:

always remember to check and clear any background running postgres servers with:
```
1. % lsof -n -i:5432 | grep LISTEN
2. % pkill postgres
```
---

## 🔧Database:

__How to run stuff locally:__

```bash
# run docker container
% ./start_local.sh
# check if container built correctly
% psql -h 127.0.0.1 -p 5432 -U budgetbro_dev -W 
# quit the CLI
% \q
```
Random aside..
> `start_local.sh` builds the base tables from a schema.sql file. It mounts from the `/database` directory.

__Environments:__

If doing this locally, remember to enter the pg container:
```bash
# starting a shell in db container
$ docker exec -it budgetbro_dev
```
If not, you need to log in to whatever pg database you've deployed to.

__🔧Impt Commands:__

Some important commands that you might need to manually access your data.

1. 🔧Export to schema.sql file to host from db container:
    ```bash
    container $ pg_dump -s -U budgetbro_dev -h docker budgetbro_dev > schema.sql
    host $ docker cp budgetbro_dev:/schema.sql .
    ```

2. 🔧Import schema into your docker container:
    ```bash
    host $ docker cp schema.sql:budgetbro_dev/schema.sql
    container $ psql -U budgetbro_dev < schema.sql
    ```