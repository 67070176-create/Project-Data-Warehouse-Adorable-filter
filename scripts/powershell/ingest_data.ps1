Write-Host "1. Copying DDL script from scripts/sql/ to raw_data/..." -ForegroundColor Cyan
Copy-Item scripts/sql/create_raw_tables.sql raw_data/

Write-Host "2. Creating Raw Tables and Truncating..." -ForegroundColor Cyan
docker exec -it dw_postgres psql -U dw_user -d project_db -f /home/raw_data/create_raw_tables.sql

Write-Host "3. Bulk Loading CSVs into PostgreSQL..." -ForegroundColor Cyan
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.orders FROM '/home/raw_data/orders.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.order_items FROM '/home/raw_data/order_items.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.payments FROM '/home/raw_data/payments.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.shipments FROM '/home/raw_data/shipments.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.returns FROM '/home/raw_data/returns.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.customers FROM '/home/raw_data/customers.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.products FROM '/home/raw_data/products.csv' WITH (FORMAT csv, HEADER true);"
docker exec -it dw_postgres psql -U dw_user -d project_db -c "\copy raw.employees FROM '/home/raw_data/employees.csv' WITH (FORMAT csv, HEADER true);"

Write-Host "4. Running Row Count Audit Check..." -ForegroundColor Cyan
docker exec -it dw_postgres psql -U dw_user -d project_db -c "select 'orders' t, count(*) from raw.orders union all select 'order_items', count(*) from raw.order_items union all select 'payments', count(*) from raw.payments union all select 'shipments', count(*) from raw.shipments union all select 'returns', count(*) from raw.returns union all select 'customers', count(*) from raw.customers union all select 'products', count(*) from raw.products union all select 'employees', count(*) from raw.employees;"

Write-Host "`nData Ingestion Completed Successfully!" -ForegroundColor Green