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
===============================================================================
*/


-- SET Base Directory For data source

\set base_dir '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets';
\set crm_dir :base_dir '/source_crm/';
\set erp_dir :base_dir '/source_erp/';


-- SET FILES CRM
\set cust_info :crm_dir 'cust_info.csv';
\set prd_info :crm_dir 'prd_info.csv';
\set sales_details :crm_dir 'sales_details.csv';

-- SET FILES ERP
\set cust_az12 :erp_dir 'cust_az12.csv';
\set loc_a101 :erp_dir 'loc_a101.csv';
\set erp_px_cat_g1v2 :erp_dir 'erp_px_cat_g1v2.csv';

-- USE datawarehouse Database
\c datawarehouse

-- Load in to bronze.crm_cust_info
COPY bronze.crm_cust_info FROM :'cust_info';

-- Load in to bronze.crm_prd_info
COPY bronze.crm_prd_info FROM :'prd_info';

-- Load in to bronze.crm_sales_details
COPY bronze.crm_sales_details FROM :'sales_details';


-- Load in to bronze.erp_cust_az12 from file
COPY bronze.erp_cust_az12 FROM :'cust_az12';

-- Load in to bronze.erp_loc_a101 from file
COPY bronze.erp_loc_a101 FROM :'loc_a101';

-- Load in to bronze.erp_px_cat_g1v2 from file
COPY bronze.erp_px_cat_g1v2 FROM :'erp_px_cat_g1v2';