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
    psql -U <user> -d datawarehouse -f proc_load_bronze.sql

Notes:
	Do change the directory structure according to your machine and source system
===============================================================================
*/

-- STORED PROCEDURES RUN ON THE POSTGRESQL SERVER NOT ON THE PSQL CLI
-- THUS PSQL META COMMANDS DO NOT RUN ON IT


CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	base_path TEXT;
	crm_path TEXT;
	erp_path TEXT;
BEGIN
	start_time := NOW();
	RAISE NOTICE 'Starting data load, %', start_time;

	-- set base path and sourcesystem path
	base_path := '/Users/sidhant/Desktop/project/sql-data-warehouse-project/datasets';
	crm_path := base_path || '/source_crm/';
	erp_path := base_path || '/source_erp/';

	-- main block
	RAISE NOTICE 'BASE PATH = %' , base_path;
	RAISE NOTICE ' crm path = %'	 , crm_path;
	RAISE NOTICE ' erp path = %' , erp_path;

	-- %L is a SQL FORMAT() to quote as a string literal
	-- load cust_info
	TRUNCATE bronze.crm_cust_info;
	RAISE NOTICE 'Loading file cust_info.csv ...';
	EXECUTE format('COPY bronze.crm_cust_info FROM %L WITH (FORMAT csv, HEADER true)',crm_path || 'cust_info.csv');
	-- load prd_info
	TRUNCATE bronze.crm_prd_info;
	RAISE NOTICE 'Loading file prd_info.csv ...';
	EXECUTE format('COPY bronze.crm_prd_info FROM %L WITH (FORMAT csv, HEADER true)',crm_path || 'prd_info.csv');
	-- load sales_details
	TRUNCATE bronze.crm_sales_details;
	RAISE NOTICE 'Loading file sales_details.csv ...';
	EXECUTE format('COPY bronze.crm_sales_details FROM %L WITH (FORMAT csv, HEADER true)',crm_path || 'sales_details.csv');
	-- load cust_az12
	TRUNCATE bronze.erp_cust_az12;
	RAISE NOTICE 'Loading file cust_az12.csv ...';
	EXECUTE format('COPY bronze.erp_cust_az12 FROM %L WITH (FORMAT csv, HEADER true)',erp_path || 'cust_az12.csv');
	-- load loc_a101
	TRUNCATE bronze.erp_loc_a101;
	RAISE NOTICE 'Loading file loc_a101.csv ...';
	EXECUTE format('COPY bronze.erp_loc_a101 FROM %L WITH (FORMAT csv, HEADER true)',erp_path || 'loc_a101.csv');
	-- load px_cat_g1v2
	TRUNCATE bronze.erp_px_cat_g1v2;
	RAISE NOTICE 'Loading file px_cat_g1v2.csv ...';
	EXECUTE format('COPY bronze.erp_px_cat_g1v2 FROM %L WITH (FORMAT csv, HEADER true)',erp_path || 'px_cat_g1v2.csv');


	end_time := NOW();
	RAISE NOTICE 'Data load completed, %', end_time;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE NOTICE 'ERROR : %', SQLERRM;

END;
$$;

CALL bronze.load_bronze();
