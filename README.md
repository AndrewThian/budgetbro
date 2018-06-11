# budgetbro 💸 💸 💸

## ❗️Caution:

always remember to check and clear any background running postgres servers with:
```
1. % lsof -n -i:5432 | grep LISTEN
2. % pkill postgres
```
---

## 🔧Database:

How to run stuff locally:
```bash
# run docker container
% ./start_db.sh
# check if container built correctly
% psql -h 127.0.0.1 -p 5432 -U budgetbro_dev -W 
# quit the CLI
% \q
```
