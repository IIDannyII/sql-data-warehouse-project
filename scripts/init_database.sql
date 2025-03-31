/*
=====================================
Create database ans scheamas
=====================================
Script purpose:
xxx

WARNING:
This script will drop the entire 'DataWarehouse' database if it exists.

*/
USE master;
GO

  --Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
  BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMIDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

  --Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

  --Create Schemas

CREATE SCHEMA Bronze;
GO
  
CREATE SCHEMA Silver;
GO
  
CREATE SCHEMA Gold;
