EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=====================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================';

		PRINT '=====================';
		PRINT 'Loading CRM tables';
		PRINT '=====================';

		SET @start_time = GETDATE()
		TRUNCATE TABLE Bronze.crm_cust_info;
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='

		--SELECT * FROM Bronze.crm_cust_info

		SET @start_time = GETDATE()
		TRUNCATE TABLE Bronze.crm_prd_info;
		BULK INSERT Bronze.crm_prd_info
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) +  ' seconds';
		PRINT '============='

		SET @start_time = GETDATE()
		TRUNCATE TABLE [Bronze].[crm_sales_details];
		BULK INSERT [Bronze].[crm_sales_details]
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='

		PRINT '=====================';
		PRINT 'LoadiNG ERP tables';
		PRINT '=====================';

		SET @start_time = GETDATE()
		TRUNCATE TABLE [Bronze].[erp_cust_az12];
		BULK INSERT [Bronze].[erp_cust_az12]
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='

		SET @start_time = GETDATE()
		TRUNCATE TABLE [Bronze].[erp_loc_a101];
		BULK INSERT [Bronze].[erp_loc_a101]
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='

		SET @start_time = GETDATE()
		TRUNCATE TABLE [Bronze].[erp_px_cat_g1v2];
		BULK INSERT [Bronze].[erp_px_cat_g1v2]
		FROM 'C:\workspace\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT 'Load duration; ' + CAST(DATEDIFF(second , @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='

		SET @batch_end_time = GETDATE();
		PRINT 'Total load duration; ' + CAST(DATEDIFF(second , @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '============='
	END TRY

	BEGIN CATCH
		PRINT '============'
		PRINT 'ERROR OCCURED DURING LOAD';
		PRINT '============';
	END CATCH
END
