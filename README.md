
# Useful Queries and Procedures for MySQL

A procedure to fetch data from multiple tables and list in a single resultset by using UNION:
(Key point is that it automatically iterates through newly added databases. So no need to write extra sql statement)

https://github.com/eyelboga/mysql/blob/main/multi_table_fetch.sql

A procedure to delete records from multiple tables:
(it automatically iterates through newly added databases. So no need to write extra sql statement)

https://github.com/eyelboga/mysql/blob/main/multi_table_delete.sql


A linux shell script to backup a website's filesystem and database:

https://github.com/eyelboga/mysql/blob/main/backup.website.sh
