!Include MUI2.nsh
Name "Luxcore Uninstaller dev.0"
OutFile "C:\Users\Fanghe\AppData\Local\Temp\tempinstaller.exe"
!addplugindir "nsis_plugins\liteFirewall\bin"
SetCompress off
!insertmacro MUI_LANGUAGE "English"
Section "" _sec1
  SectionIn RO
  WriteUninstaller "C:\Users\Fanghe\AppData\Local\Temp\uninstall.exe"
SectionEnd
Section "Uninstall" _sec2
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Luxcore"
  DeleteRegKey HKLM "Software\Luxcore"
  RMDir /r /rebootok "$INSTDIR"
  Delete "$SMPROGRAMS\Luxcore\*.*"
  Delete "$DESKTOP\Luxcore.lnk"
  liteFirewall::RemoveRule "$INSTDIR\luxd.exe" "Luxcoin Daemon"
  Pop $0
  DetailPrint "liteFirewall::RemoveRule: $0"
SectionEnd
