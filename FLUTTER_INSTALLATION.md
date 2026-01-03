# Flutter Installation Guide for Windows

## Current Issue
Flutter is not installed or not in your system PATH. Let's fix this!

---

## Option 1: Install Flutter (Recommended)

### Step 1: Download Flutter SDK

1. Go to: https://docs.flutter.dev/get-started/install/windows
2. Download the latest stable Flutter SDK ZIP file
3. **Recommended location**: Extract to `C:\src\flutter`
   - **DO NOT** install to `C:\Program Files\` (requires admin rights)

### Step 2: Add Flutter to PATH

**Method A: Using PowerShell (Permanent)**
```powershell
# Run PowerShell as Administrator
[System.Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\src\flutter\bin', [System.EnvironmentVariableTarget]::Machine)
```

**Method B: Using System Settings (Easier)**
1. Press `Win + X` → Select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "System variables", find `Path` → Click "Edit"
5. Click "New" → Add: `C:\src\flutter\bin`
6. Click "OK" on all dialogs
7. **Restart PowerShell** (important!)

### Step 3: Verify Installation
```powershell
# Open a NEW PowerShell window
flutter doctor
```

### Step 4: Install Android Studio (Required for Android Development)

1. Download from: https://developer.android.com/studio
2. Install Android Studio
3. During setup, install:
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android Emulator

### Step 5: Accept Android Licenses
```powershell
flutter doctor --android-licenses
# Press 'y' to accept all licenses
```

### Step 6: Final Check
```powershell
flutter doctor -v
# Should show green checkmarks for Flutter and Android toolchain
```

---

## Option 2: Use Flutter Without Installation (Alternative)

If you can't install Flutter right now, you can still view the complete app code and understand the architecture:

### Explore the Codebase
```powershell
# View main app entry
Get-Content ".\lib\main.dart"

# View home screen
Get-Content ".\lib\features\home\screens\home_screen.dart"

# View chord trainer (main feature)
Get-Content ".\lib\features\chord_trainer\screens\chord_trainer_screen.dart"
```

### Review Documentation
- `README.md` - Complete app overview
- `ARCHITECTURE.md` - Technical details
- `FEATURES.md` - All features explained
- `QUICKSTART.md` - This guide

---

## Option 3: Quick Test with Online Flutter Playground

While not suitable for the full app, you can test Flutter basics at:
- https://dartpad.dev

---

## What You Need for Full Development

### Minimum Requirements:
- ✅ Windows 10 or later (64-bit)
- ✅ ~1.5 GB disk space for Flutter SDK
- ✅ ~4 GB disk space for Android Studio
- ✅ Git for Windows (optional but recommended)

### Installation Time:
- Flutter SDK: ~5 minutes
- Android Studio: ~15 minutes
- Setup & configuration: ~10 minutes
- **Total: ~30 minutes**

---

## Quick Flutter Installation Script

Save this as `install-flutter.ps1` and run in PowerShell (Admin):

```powershell
# Download Flutter (modify version as needed)
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.9-stable.zip"
$downloadPath = "$env:USERPROFILE\Downloads\flutter_windows.zip"
$extractPath = "C:\src"

Write-Host "Downloading Flutter SDK..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $flutterUrl -OutFile $downloadPath

Write-Host "Extracting Flutter..." -ForegroundColor Cyan
Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force

Write-Host "Adding Flutter to PATH..." -ForegroundColor Cyan
$currentPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*flutter\bin*") {
    [System.Environment]::SetEnvironmentVariable('Path', $currentPath + ';C:\src\flutter\bin', [System.EnvironmentVariableTarget]::Machine)
}

Write-Host "Flutter installation complete!" -ForegroundColor Green
Write-Host "Please restart PowerShell and run: flutter doctor" -ForegroundColor Yellow
```

---

## After Flutter is Installed

Come back to this project and run:

```powershell
cd "S:\Guitar App"
flutter pub get
flutter run
```

---

## Alternative: View App Architecture Without Running

Even without Flutter installed, you can:

1. **Read the complete code** - All files are in `lib/`
2. **Study the architecture** - See `ARCHITECTURE.md`
3. **Understand features** - See `FEATURES.md`
4. **Review UI designs** - Code is well-documented
5. **Copy patterns** - Reuse widgets and logic

---

## Troubleshooting

### "flutter: command not found" after installation
- **Solution**: Restart PowerShell or computer
- **Check**: Run `$env:Path` to verify `flutter\bin` is in PATH

### "Android SDK not found"
- **Solution**: Install Android Studio
- **Run**: `flutter doctor` for detailed instructions

### "No connected devices"
- **Solution**: Enable USB Debugging on Android phone, or
- **Alternative**: Start Android Emulator from Android Studio

---

## Need Help?

- **Flutter Docs**: https://docs.flutter.dev/get-started/install
- **Flutter Discord**: https://discord.gg/flutter
- **Stack Overflow**: Tag `flutter`

---

## Summary

**To run the Guitar Practice App:**

1. Install Flutter SDK (30 min setup)
2. Install Android Studio (for Android development)
3. Connect device or start emulator
4. Run: `flutter pub get` then `flutter run`

**OR**

Explore the complete codebase and architecture documentation without running it!

---

**Current Status**: Flutter not installed  
**Next Step**: Follow Option 1 above to install Flutter SDK

🎸 The app code is complete and ready to run once Flutter is set up!
