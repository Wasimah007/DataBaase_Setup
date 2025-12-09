@echo off
REM This batch file runs the three SQL scripts for the default environment

REM Set MySQL login credentials and path (change as per your setup)
SET MYSQL_USER=root
SET MYSQL_PASSWORD=Mysql123
SET MYSQL_PATH="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

REM Change directory to SQL scripts location (adjust path)
cd /d "C:\Users\waseem.a\Timesheet\oneview_database"

echo Running onev_portal_database.sql...
%MYSQL_PATH% -u %MYSQL_USER% -p%MYSQL_PASSWORD% < onev_portal_database.sql

echo Running organization_setup_database.sql...
%MYSQL_PATH% -u %MYSQL_USER% -p%MYSQL_PASSWORD% < organization_setup_database.sql

echo Running timesheet_database.sql...
%MYSQL_PATH% -u %MYSQL_USER% -p%MYSQL_PASSWORD% < timesheet_database.sql

echo All databases for default environment created.
pause
