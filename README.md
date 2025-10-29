# FloriDevs W11Fixer - Installation Guide

## 📋 Prerequisites
- Windows 11 operating system
- Administrator access
- Internet connection (for Firefox download)

---

## 🚀 Step-by-Step Installation

### Step 1: Download the Script
1. Copy the entire PowerShell script
2. Open **Notepad** or any text editor
3. Paste the script content
4. Save the file as `FloriDevs-W11Fixer.ps1`
   - Make sure to select "All Files" in the save dialog
   - The file extension MUST be `.ps1` (not `.txt`)

---

### Step 2: Configure PowerShell Execution Policy

Windows blocks PowerShell scripts by default for security. You need to temporarily allow script execution.

#### Method A: Temporary Bypass (Recommended)
1. Press `Win + X` and select **"Terminal (Admin)"** or **"PowerShell (Admin)"**
2. In the PowerShell window, type:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
3. Press `Enter` and confirm with `Y` if prompted
4. This allows scripts ONLY for the current PowerShell session

#### Method B: Permanent Change (Use with caution)
1. Press `Win + X` and select **"Terminal (Admin)"** or **"PowerShell (Admin)"**
2. Type:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```
3. Press `Enter` and confirm with `Y`
4. This allows locally created scripts to run permanently

> **Note:** Method A is safer as it only affects the current session!

---

### Step 3: Navigate to Script Location
In the same PowerShell window, navigate to where you saved the script:

```powershell
cd C:\Users\YourUsername\Downloads
```

Replace `YourUsername` with your actual username, or navigate to wherever you saved the file.

**Tip:** You can also type `cd ` (with a space) and drag-and-drop the folder into PowerShell!

---

### Step 4: Run the Script
Execute the script with this command:

```powershell
.\FloriDevs-W11Fixer.ps1
```

Press `Enter` and the script will start running!

---

## 🛡️ Windows Security Warnings

### If Windows Defender SmartScreen Blocks the Script:

**Option 1: Unblock via File Properties**
1. Right-click on `FloriDevs-W11Fixer.ps1`
2. Select **"Properties"**
3. At the bottom, check the box **"Unblock"**
4. Click **"Apply"** then **"OK"**
5. Run the script again

**Option 2: Bypass SmartScreen Temporarily**
Instead of running the script normally, use:
```powershell
PowerShell.exe -ExecutionPolicy Bypass -File .\FloriDevs-W11Fixer.ps1
```

---

## ⚡ Quick Start (All-in-One Method)

If you want to run the script with a single command without changing system policies:

1. Open **PowerShell as Administrator**
2. Navigate to script location: `cd C:\Path\To\Script`
3. Run this single command:
   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File .\FloriDevs-W11Fixer.ps1
   ```

This bypasses execution policy for this one script only!

---

## 🔄 After Running the Script

1. The script will show progress for each optimization step
2. When complete, you'll be asked if you want to restart
3. **Restart is REQUIRED** for all changes to take effect
4. After restart, check that:
   - Taskbar icons are on the left
   - Right-click shows the old context menu
   - Firefox is installed (if it wasn't before)

---

## ⚠️ Troubleshooting

### "Cannot be loaded because running scripts is disabled"
- You didn't change the execution policy (see Step 2)
- Use the Quick Start method instead

### "Access Denied" errors
- You're not running PowerShell as Administrator
- Right-click PowerShell and select "Run as Administrator"

### Firefox doesn't install
- Check your internet connection
- Download manually from: https://www.mozilla.org/firefox/
- The script will skip installation if Firefox is already present

### Edge is still present
- Edge cannot be fully removed without breaking Windows
- The script disables it as much as possible
- Use Firefox as your default browser instead

### Context menu didn't change
- Restart your computer
- Press `Win + R`, type `explorer.exe`, and restart Explorer

---

## 🔒 Security Notes

- This script only modifies **Windows settings and registry entries**
- It does NOT download or install anything malicious
- Firefox is downloaded directly from Mozilla's official servers
- All changes can be reversed manually if needed
- The script does NOT:
  - Delete language packs
  - Change keyboard layouts
  - Modify system files
  - Send data anywhere

---

## 📞 Support

If you encounter any issues:
1. Make sure you're running as Administrator
2. Check that you followed all steps correctly
3. Verify Windows 11 is up to date
4. Create a System Restore Point before running (optional but recommended)

---

## 🔙 How to Undo Changes

If you want to revert some changes:

**Restore Windows 11 Context Menu:**
```powershell
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
```

**Move Taskbar Back to Center:**
```powershell
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 1
```

Then restart Explorer or your computer.

---

## ✅ Verification Checklist

After running and restarting, verify:
- [ ] Taskbar icons are aligned to the left
- [ ] Right-click shows classic Windows menu
- [ ] Bloatware apps are removed (check Start menu)
- [ ] Firefox is installed and working
- [ ] Edge doesn't start automatically
- [ ] System is running smoothly

---

**Enjoy your optimized Windows 11! 🎉**

*FloriDevs W11Fixer v1.0*
