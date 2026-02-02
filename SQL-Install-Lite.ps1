<#
.SYNOPSIS
    SQL Server Basic Unattended Installer (Community Edition)
    Product Version: 1.0.0 (Community)

.DESCRIPTION
    Basic version of the installation script.
    Requires manual path configuration and account setup.
    
    -----------------------------------------------------------------------
    WANT THE PRO VERSION? 
    (Auto-CPU Tuning, ISO Detect, Launcher .BAT, Smart Accounts)
    Check it out here: https://hubert-sql.lemonsqueezy.com/checkout/buy/ae392883-fec5-430e-86bd-f6ee5872dc53
    -----------------------------------------------------------------------
    
.NOTES
    1. Run PowerShell as Administrator.
    2. Type: Set-ExecutionPolicy Unrestricted -Scope Process
    3. You MUST edit the CONFIGURATION section below before running.
    
.AUTHOR
    Hubert Jablonski
#>

# ==============================================================================
# 1. CONFIGURATION (YOU MUST EDIT THIS MANUALLY)
# ==============================================================================

# Path to setup.exe (You must type the full path manually)
# Example: "D:\setup.exe" or "C:\Downloads\SQL2022\setup.exe"
$SetupExePath = "CHANGE_ME_TO_FULL_PATH\setup.exe"

# Instance Name
$InstanceName = "MSSQLSERVER"

# SysAdmin Account (Type yours or leave as current user)
$SysAdminAccount = "$env:USERDOMAIN\$env:USERNAME"

# Drives (Default C:\)
$DataDir   = "C:\SQLData"
$LogDir    = "C:\SQLLog"
$BackupDir = "C:\SQLBackup"
$TempDir   = "C:\SQLTemp"

# ==============================================================================
# 2. EXECUTION
# ==============================================================================

Write-Host "--- SQL INSTALLER LITE (Community) ---" -ForegroundColor Cyan

# Check if setup.exe exists
if (!(Test-Path $SetupExePath)) {
    Write-Error "ERROR: setup.exe not found at: $SetupExePath"
    Write-Warning "ACTION REQUIRED: Edit the script and fix `$SetupExePath variable (Line 30)."
    exit
}

# Create Directories
try {
    New-Item -Path $DataDir -ItemType Directory -Force | Out-Null
    New-Item -Path $LogDir -ItemType Directory -Force | Out-Null
    New-Item -Path $BackupDir -ItemType Directory -Force | Out-Null
    New-Item -Path $TempDir -ItemType Directory -Force | Out-Null
} catch {
    Write-Error "Error creating directories: $_"
    exit
}

Write-Host "Starting installation... (This may take 15-20 mins)" -ForegroundColor Yellow
Write-Host "Note: This is a basic install. No performance tuning applied." -ForegroundColor Gray

# Argument List (Standard Defaults, No Tuning)
$Arguments = @(
    "/Q",
    "/ACTION=Install",
    "/IACCEPTSQLSERVERLICENSETERMS",
    "/FEATURES=SQLEngine",
    "/INSTANCENAME=$InstanceName",
    "/SQLSYSADMINACCOUNTS=`"$SysAdminAccount`"",
    
    # Paths
    "/INSTALLSQLDATADIR=`"$DataDir`"",
    "/SQLUSERDBDIR=`"$DataDir`"",
    "/SQLUSERDBLOGDIR=`"$LogDir`"",
    "/SQLTEMPDBDIR=`"$TempDir`"",
    "/SQLTEMPDBLOGDIR=`"$TempDir`"",
    "/SQLBACKUPDIR=`"$BackupDir`"",
    
    # Network
    "/TCPENABLED=1",
    "/NPENABLED=0"
)

# Run Process
$Process = Start-Process -FilePath $SetupExePath -ArgumentList $Arguments -Wait -PassThru

if ($Process.ExitCode -eq 0 -or $Process.ExitCode -eq 3010) {
    Write-Host "SUCCESS: SQL Server installed." -ForegroundColor Green
} else {
    Write-Error "FAILED: Exit Code $($Process.ExitCode)"
    Write-Host "Please check SQL Server summary logs."
}