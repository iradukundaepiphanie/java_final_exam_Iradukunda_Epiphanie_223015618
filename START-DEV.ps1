<#
START-DEV.ps1
Helper script to build and run the project locally using Maven + Jetty (Windows PowerShell 5.1)
Usage: .\START-DEV.ps1 [-NoBrowser] [-ImportDb] [-DbName name] [-DbUser user] [-DbPassword pwd] [-SqlFile path]
#>
param(
    [switch]$NoBrowser,
    [switch]$ImportDb,
    [string]$DbName = 'education-platform',
    [string]$DbUser = 'root',
    [string]$DbPassword = '',
    [string]$SqlFile = "$PSScriptRoot\src\main\resources\education-platform.sql"
)

$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

function Fail($msg) {
    Write-Error $msg
    exit 1
}

Write-Host "Working directory: $scriptDir"

# Check for mvn
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    Fail "Maven 'mvn' not found in PATH. Please install Apache Maven and ensure 'mvn' is on PATH. See https://maven.apache.org/install.html"
}

# Check for Java
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Fail "Java runtime not found. Install JDK (11+ recommended) and ensure 'java' is on PATH."
}

# Optional DB import
if ($ImportDb) {
    Write-Host "DB import requested. Checking for MySQL client 'mysql'..."
    if (-not (Get-Command mysql -ErrorAction SilentlyContinue)) {
        Write-Warning "MySQL client 'mysql' not found in PATH. Skipping DB import. Install MySQL client or add it to PATH to enable automatic import."
    } else {
        if (-not (Test-Path -Path $SqlFile)) {
            Write-Warning "SQL file not found at $SqlFile. Skipping DB import."
        } else {
            Write-Host "Importing SQL file '$SqlFile' into database '$DbName' as user '$DbUser'..."
            try {
                $env:MYSQL_PWD = $DbPassword
                $createCmd = "CREATE DATABASE IF NOT EXISTS `$DbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
                & mysql -u $DbUser -e $createCmd
                & mysql -u $DbUser $DbName < $SqlFile
                Write-Host "Database import completed (or already present)."
            } catch {
                Write-Warning "Database import failed: $($_.Exception.Message)"
            } finally {
                Remove-Item Env:\MYSQL_PWD -ErrorAction SilentlyContinue
            }
        }
    }
}

Write-Host "Running 'mvn -DskipTests package' to download dependencies and build the WAR (this may take a minute)..."
$mvnPackage = Start-Process -FilePath mvn -ArgumentList '-DskipTests','package' -NoNewWindow -Wait -PassThru
if ($mvnPackage.ExitCode -ne 0) {
    Fail "Maven package failed with exit code $($mvnPackage.ExitCode). Check the build output."
}

# Start Jetty in background
Write-Host "Starting Jetty (mvn jetty:run-war). Logs will appear in a new window."
Start-Process -FilePath mvn -ArgumentList 'jetty:run-war' -WorkingDirectory $scriptDir

# Wait for server to respond
$uri = 'http://localhost:8090/education-platform'
Write-Host "Waiting for $uri to become available..."
$maxSeconds = 120
$elapsed = 0
$delay = 2
while ($elapsed -lt $maxSeconds) {
    try {
        $resp = Invoke-WebRequest -Uri $uri -UseBasicParsing -TimeoutSec 5
        if ($resp.StatusCode -ge 200 -and $resp.StatusCode -lt 400) {
            Write-Host "Server is up at $uri"
            if (-not $NoBrowser) { Start-Process $uri }
            exit 0
        }
    } catch {
        # ignore and retry
    }
    Start-Sleep -Seconds $delay
    $elapsed += $delay
}

Write-Warning "Timed out waiting for $uri. Jetty may still be starting; check the Jetty logs in the mvn window."
if (-not $NoBrowser) { Start-Process $uri }
exit 0
