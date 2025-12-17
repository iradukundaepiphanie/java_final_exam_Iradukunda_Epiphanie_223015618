@echo off
REM START-DEV.bat - Build and run education-platform using Maven + Jetty (Windows CMD)
REM Usage: START-DEV.bat [--nobrowser] [--import-db dbUser dbPassword dbName sqlFile]

setlocal
pushd %~dp0

:: Check for mvn
where mvn >nul 2>&1
if errorlevel 1 (
  echo Maven (mvn) not found in PATH. Please install Maven and add to PATH.
  popd
  exit /b 1
)

:: Check for java
where java >nul 2>&1
if errorlevel 1 (
  echo Java not found in PATH. Please install JDK and add to PATH.
  popd
  exit /b 1
)

:: Parse args (simple)
set NO_BROWSER=0
set IMPORT_DB=0
set DB_USER=root
set DB_PWD=
set DB_NAME=education-platform
set SQL_FILE=%~dp0src\main\resources\education-platform.sql

:parse_args
if "%1"=="" goto args_done
if "%1"=="--nobrowser" (set NO_BROWSER=1 & shift & goto parse_args)
if "%1"=="--import-db" (
  set IMPORT_DB=1
  shift
  if not "%1"=="" set DB_USER=%1 & shift
  if not "%1"=="" set DB_PWD=%1 & shift
  if not "%1"=="" set DB_NAME=%1 & shift
  if not "%1"=="" set SQL_FILE=%1 & shift
  goto parse_args
)
shift
goto parse_args
:args_done

if %IMPORT_DB%==1 (
  where mysql >nul 2>&1
  if errorlevel 1 (
    echo MySQL client not found in PATH. Skipping DB import.
  ) else (
    echo Creating database %DB_NAME% and importing %SQL_FILE% ...
    mysql -u%DB_USER% -p%DB_PWD% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME% CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    mysql -u%DB_USER% -p%DB_PWD% %DB_NAME% < "%SQL_FILE%"
  )
)

echo Running mvn -DskipTests package ...
mvn -DskipTests package
if errorlevel 1 (
  echo Maven package failed. See output.
  popd
  exit /b 1
)

echo Starting Jetty: mvn jetty:run-war
start "Jetty" mvn jetty:run-war

if %NO_BROWSER%==0 (
  start "" "http://localhost:8090/education-platform"
)

popd
endlocal
exit /b 0
