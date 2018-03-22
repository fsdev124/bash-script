!Include MUI2.nsh
Var _1
Var _2
Var _10
Name "Luxcore (dev.0)"
OutFile "luxcore-win64-dev.0-installer.exe"
!define MUI_ICON "icons\64x64.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "icons\installBanner.bmp"
!define MUI_HEADERIMAGE_RIGHT
VIProductVersion 0.0.0.0
VIAddVersionKey "ProductVersion" dev.0
Unicode true
RequestExecutionLevel Highest
!addplugindir "nsis_plugins\liteFirewall\bin"
InstallDir "$PROGRAMFILES64\Luxcore"
InstallDirRegKey HKLM "Software\Luxcore" "Install_Dir"
!define MUI_PAGE_CUSTOMFUNCTION_PRE PreDirectory
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"
Section "" _sec14
  SectionIn RO
  SetOutPath "$INSTDIR"
  WriteRegStr HKLM "Software\Luxcore" "Install_Dir" "$INSTDIR"
  CreateDirectory "$APPDATA\Luxcore\Secrets-1.0"
  CreateDirectory "$APPDATA\Luxcore\Logs"
  CreateDirectory "$APPDATA\Luxcore\Logs\pub"
  CreateShortcut "$DESKTOP\Luxcore.lnk" "$INSTDIR\launcher.cmd" "" "$INSTDIR\Luxcore.exe" "0" "SW_SHOWMINIMIZED" "" ""
  File "luxd.exe"
  File "launcher.cmd"
  File "version.txt"
  File /r "libressl\"
  File /r "..\release\win32-x64\Luxcore-win32-x64\"
  liteFirewall::AddRule "$INSTDIR\luxd.exe" "Luxcoin Daemon"
  Pop $0
  DetailPrint "liteFirewall::AddRule: $0"
  ExecWait "build-certificates-win64.bat $\"$INSTDIR$\" >$\"%APPDATA%\Luxcore\Logs\build-certificates.log$\" 2>&1"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "InstallLocation" "$INSTDIR\Luxcore"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "Publisher" "216K"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "ProductVersion" "dev.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "VersionMajor" "0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "VersionMinor" "0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "DisplayName" "Luxcore"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "DisplayVersion" "dev.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" \S"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "NoModify" "1"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore" "NoRepair" "1"
  File "C:\Users\Fanghe\AppData\Local\Temp\uninstall.exe"
SectionEnd
Section "Start Menu Shortcuts" _sec15
  CreateDirectory "$SMPROGRAMS\Luxcore"
  CreateShortcut "$SMPROGRAMS\Luxcore\Uninstall Luxcore.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" "0" "" "" ""
  CreateShortcut "$SMPROGRAMS\Luxcore\Luxcore.lnk" "$INSTDIR\launcher.cmd" "" "$INSTDIR\Luxcore.exe" "0" "SW_SHOWMINIMIZED" "" ""
SectionEnd
Function .onInit
  ReadRegStr $_1 HKLM "Software\Luxcore" "Install_Dir"
  StrCpy $_2 "$_1"
FunctionEnd
Function PreDirectory
  StrLen $_10 "$_2"
  StrCmpS "$_10" "0" _lbl5 0
  Abort ""
  _lbl5:
FunctionEnd
