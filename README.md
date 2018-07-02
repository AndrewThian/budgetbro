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
% ./start_db.sh
# check if container built correctly
% psql -h 127.0.0.1 -p 5432 -U budgetbro_dev -W 
# quit the CLI
% \q
```

__Postgres Cmds:__

If doing this locally, remember to enter the pg container:
```
# starting a shell in db container
$ docker exec -it budgetbro_dev
```

If not, you need to log in to whatever pg database you've deployed to.

Export to schema.pgsql file to host from db container:
```
container $ pg_dump -s -U budgetbro_dev -h docker budgetbro_dev > schema.pgsql
host $ docker cp budgetbro_dev:/schema.pgsql .
```
