# Guitar Practice App - Installation Script
# Run this in PowerShell to set up and run the app

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Guitar Practice App - Setup Script  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Flutter installation
Write-Host "[1/5] Checking Flutter installation..." -ForegroundColor Yellow
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    Write-Host "✓ Flutter found" -ForegroundColor Green
    flutter --version
} else {
    Write-Host "✗ Flutter not found!" -ForegroundColor Red
    Write-Host "Please install Flutter from https://flutter.dev" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Navigate to project directory
Write-Host "[2/5] Navigating to project directory..." -ForegroundColor Yellow
$projectPath = "s:\Guitar App"
if (Test-Path $projectPath) {
    Set-Location $projectPath
    Write-Host "✓ Project directory found: $projectPath" -ForegroundColor Green
} else {
    Write-Host "✗ Project directory not found: $projectPath" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Install dependencies
Write-Host "[3/5] Installing dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Check for connected devices
Write-Host "[4/5] Checking for connected devices..." -ForegroundColor Yellow
flutter devices
Write-Host ""

# Analyze code
Write-Host "[5/5] Running code analysis..." -ForegroundColor Yellow
flutter analyze
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ No issues found!" -ForegroundColor Green
} else {
    Write-Host "⚠ Some issues found, but continuing..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!                      " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the app, use one of these commands:" -ForegroundColor White
Write-Host ""
Write-Host "  flutter run                    # Run on default device" -ForegroundColor Cyan
Write-Host "  flutter run --release          # Run optimized version" -ForegroundColor Cyan
Write-Host "  flutter build apk --release    # Build APK file" -ForegroundColor Cyan
Write-Host ""
Write-Host "Happy practicing! 🎸" -ForegroundColor Green
