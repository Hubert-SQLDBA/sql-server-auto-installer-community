# SQL Server Auto-Installer (Community Edition)

A lightweight PowerShell script to install Microsoft SQL Server silently without the GUI ("Next-Next-Finish").

**Ideal for:** Students, Homelab users, and simple Dev environments.

---

## 🚀 Need more power? Check the PRO Version

This repository contains the **Lite (Community)** version.
For production environments, I created the **SQL Server Pro Admin Kit** – a robust toolkit used by Senior DBAs.

| Feature | 🟢 Community (This Repo) | 🏆 PRO Admin Kit ($29) |
| :--- | :---: | :---: |
| **Silent Installation** | ✅ Yes | ✅ Yes |
| **Configuration** | Manual (Edit Script) | **Interactive / Config Block** |
| **ISO Detection** | ❌ No (Manual Path) | ✅ **Auto-Detect & Mount** |
| **Launch Method** | Manual (`Set-ExecutionPolicy`) | ✅ **One-Click `.BAT` Launcher** |
| **Security** | Standard | ✅ **Smart Accounts & Passwords** |
| **Performance Tuning** | ❌ Standard MS Defaults | ✅ **Auto-Calculates MaxDOP & TempDB** |
| **Bonus Tools** | ❌ None | ✅ **RAM Balancer & Auto-Tuner** |

👉 **[Get the PRO Admin Kit here ($49)](https://hubert-sql.lemonsqueezy.com/checkout/buy/ae392883-fec5-430e-86bd-f6ee5872dc53)**

---

## 📖 How to use the Community Version

1. Download `Install-SQL-Lite.ps1` from this repository.
2. Open the file in Notepad/ISE.
3. **Manually edit** the `CONFIGURATION` section (lines 20-35):
   - Path to `setup.exe`
   - Target Directories (`C:\SQLData`, etc.)
   - Account Names
4. Open PowerShell as Administrator.
5. Run: `Set-ExecutionPolicy Unrestricted -Scope Process`
6. Run: `.\Install-SQL-Lite.ps1`

### Disclaimer
This script is provided "as is", without warranty of any kind. For professional support and guaranteed results, please consider the PRO version.

**Author:** Hubert Jablonski
