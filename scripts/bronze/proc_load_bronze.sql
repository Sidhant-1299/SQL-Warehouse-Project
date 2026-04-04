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



-- Load in to bronze.crm_cust_info
TRUNCATE TABLE bronze.crm_cust_info;
\copy bronze.crm_cust_info FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv' WITH (FORMAT csv, HEADER true)

-- Load in to bronze.crm_prd_info
TRUNCATE TABLE bronze.crm_prd_info;
\echo 'copying crm_prd_info...'
\copy bronze.crm_prd_info FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv' WITH (FORMAT csv, HEADER true)

-- Load in to bronze.crm_sales_details
TRUNCATE TABLE bronze.crm_sales_details;
\echo 'copying crm_sales_details...'
\copy bronze.crm_sales_details FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv' WITH (FORMAT csv, HEADER true)

-- Load in to bronze.erp_cust_az12 from file
TRUNCATE TABLE bronze.erp_cust_az12;
\echo 'copying erp_cust_az12...'
\copy bronze.erp_cust_az12 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv' WITH (FORMAT csv, HEADER true)

-- Load in to bronze.erp_loc_a101 from file
TRUNCATE TABLE bronze.erp_loc_a101;
\echo 'copying erp_loc_a101...'
\copy bronze.erp_loc_a101 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv' WITH (FORMAT csv, HEADER true)


-- Load in to bronze.erp_px_cat_g1v2 from file
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
\echo 'copying erp_px_cat_g1v2...'
\copy bronze.erp_px_cat_g1v2 FROM '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv' WITH (FORMAT csv, HEADER true)

\echo "Copy completed!"
