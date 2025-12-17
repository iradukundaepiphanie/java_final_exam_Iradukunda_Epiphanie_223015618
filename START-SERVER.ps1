# Education Platform - Start Server Script
# This script starts the Jetty server with proper configuration

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Education Platform - Server Startup" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to project directory
Set-Location "C:\Users\user\education\education-platform"

Write-Host "📁 Project Directory: $PWD" -ForegroundColor Green
Write-Host ""

# Check if port 8090 is available
Write-Host "🔍 Checking if port 8090 is available..." -ForegroundColor Yellow
$portCheck = Get-NetTCPConnection -LocalPort 8090 -ErrorAction SilentlyContinue

if ($portCheck) {
    Write-Host "⚠️  Port 8090 is in use!" -ForegroundColor Red
    Write-Host "   Would you like to kill the process and continue? (Y/N): " -NoNewline
    $response = Read-Host
    
    if ($response -eq 'Y' -or $response -eq 'y') {
        $portCheck | ForEach-Object {
            $processId = $_.OwningProcess
            Write-Host "   Killing process $processId..." -ForegroundColor Yellow
            Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
        }
        Start-Sleep -Seconds 2
        Write-Host "✅ Port 8090 is now available" -ForegroundColor Green
    } else {
        Write-Host "❌ Exiting..." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "✅ Port 8090 is available" -ForegroundColor Green
}

Write-Host ""
Write-Host "🔧 Building and starting the server..." -ForegroundColor Cyan
Write-Host "   This may take a few moments..." -ForegroundColor Gray
Write-Host ""

# Build and run
Write-Host "📦 Running: mvn clean install jetty:run" -ForegroundColor Magenta
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Start Maven Jetty
mvn clean install jetty:run

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Server stopped." -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
