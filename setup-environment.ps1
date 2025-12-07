# Education Platform - Environment Setup Script
# This script downloads and configures Maven and Tomcat

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Education Platform - Environment Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Define paths
$baseDir = "C:\dev-tools"
$mavenVersion = "3.9.9"
$tomcatVersion = "9.0.98"
$mavenUrl = "https://archive.apache.org/dist/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$tomcatUrl = "https://archive.apache.org/dist/tomcat/tomcat-9/v$tomcatVersion/bin/apache-tomcat-$tomcatVersion-windows-x64.zip"
$mavenDir = "$baseDir\apache-maven-$mavenVersion"
$tomcatDir = "$baseDir\apache-tomcat-$tomcatVersion"

# Create base directory
Write-Host "Creating tools directory at $baseDir..." -ForegroundColor Yellow
if (!(Test-Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir | Out-Null
}

# Download Maven
Write-Host "Downloading Apache Maven $mavenVersion..." -ForegroundColor Yellow
$mavenZip = "$baseDir\maven.zip"
if (!(Test-Path $mavenDir)) {
    try {
        Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip -UseBasicParsing
        Write-Host "Extracting Maven..." -ForegroundColor Yellow
        Expand-Archive -Path $mavenZip -DestinationPath $baseDir -Force
        Remove-Item $mavenZip
        Write-Host "[SUCCESS] Maven installed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERROR] Error downloading Maven: $_" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "[SUCCESS] Maven already installed" -ForegroundColor Green
}

# Download Tomcat
Write-Host "Downloading Apache Tomcat $tomcatVersion..." -ForegroundColor Yellow
$tomcatZip = "$baseDir\tomcat.zip"
if (!(Test-Path $tomcatDir)) {
    try {
        Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip -UseBasicParsing
        Write-Host "Extracting Tomcat..." -ForegroundColor Yellow
        Expand-Archive -Path $tomcatZip -DestinationPath $baseDir -Force
        Remove-Item $tomcatZip
        Write-Host "[SUCCESS] Tomcat installed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERROR] Error downloading Tomcat: $_" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "[SUCCESS] Tomcat already installed" -ForegroundColor Green
}

# Set environment variables for current session
Write-Host ""
Write-Host "Setting up environment variables..." -ForegroundColor Yellow
$env:MAVEN_HOME = $mavenDir
$env:CATALINA_HOME = $tomcatDir
$env:Path = "$mavenDir\bin;$tomcatDir\bin;$env:Path"

Write-Host "[SUCCESS] Environment variables set for current session" -ForegroundColor Green

# Ask to set permanent environment variables
Write-Host ""
Write-Host "Do you want to set permanent environment variables? (Y/N)" -ForegroundColor Cyan
$response = Read-Host
if ($response -eq 'Y' -or $response -eq 'y') {
    try {
        [Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenDir, "User")
        [Environment]::SetEnvironmentVariable("CATALINA_HOME", $tomcatDir, "User")
        
        $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($currentPath -notlike "*$mavenDir\bin*") {
            $newPath = "$mavenDir\bin;$currentPath"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        }
        if ($currentPath -notlike "*$tomcatDir\bin*") {
            $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
            $newPath = "$tomcatDir\bin;$currentPath"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        }
        
        Write-Host "[SUCCESS] Permanent environment variables set!" -ForegroundColor Green
        Write-Host "  (You may need to restart PowerShell for system-wide changes)" -ForegroundColor Yellow
    }
    catch {
        Write-Host "[ERROR] Error setting permanent variables: $_" -ForegroundColor Red
    }
}

# Verify installations
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Verifying Installations" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Maven version:" -ForegroundColor Yellow
& "$mavenDir\bin\mvn.cmd" --version

Write-Host ""
Write-Host "Tomcat version:" -ForegroundColor Yellow
& "$tomcatDir\bin\version.bat"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Maven Home: $mavenDir" -ForegroundColor White
Write-Host "Tomcat Home: $tomcatDir" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Build the project: mvn clean package" -ForegroundColor White
Write-Host "2. Deploy to Tomcat: Copy target\education-platform.war to $tomcatDir\webapps" -ForegroundColor White
Write-Host "3. Start Tomcat: $tomcatDir\bin\startup.bat" -ForegroundColor White
Write-Host "4. Access application: http://localhost:8080/education-platform" -ForegroundColor White
Write-Host ""
