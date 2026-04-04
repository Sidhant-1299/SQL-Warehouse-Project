/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    psql -U <user> bronze.load_bronze;

Notes:
	Do change the directory structure according to your machine and source system
===============================================================================
*/


-- CONNECT TO DB FIRST
\c datawarehouse

-- Load into bronze.crm_cust_info (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'crm_cust_info'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.crm_cust_info FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv' WITH (FORMAT csv, HEADER true)
\endif

-- Load into bronze.crm_prd_info (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'crm_prd_info'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.crm_prd_info FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv' WITH (FORMAT csv, HEADER true)
\endif

-- Load into bronze.crm_sales_details (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'crm_sales_details'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.crm_sales_details FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv' WITH (FORMAT csv, HEADER true)
\endif

-- Load into bronze.erp_cust_az12 (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'erp_cust_az12'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.erp_cust_az12 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv' WITH (FORMAT csv, HEADER true)
\endif

-- Load into bronze.erp_loc_a101 (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'erp_loc_a101'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.erp_loc_a101 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv' WITH (FORMAT csv, HEADER true)
\endif

-- Load into bronze.erp_px_cat_g1v2 (if table exists)
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'bronze' AND table_name = 'erp_px_cat_g1v2'
) AS tbl_exists \gset
\if :tbl_exists
    \copy bronze.erp_px_cat_g1v2 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv' WITH (FORMAT csv, HEADER true)
\endif