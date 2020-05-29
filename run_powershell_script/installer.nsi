; https://github.com/madchills/ps_exporter/blob/a2eaa65737df31f7ad107674889842e26c10e2b4/pkg/PSEcreator.nsi

; The name of the installer
Name "Run Shell Command"

; The file to write
OutFile "run_shell_command.exe"

; The default installation directory
InstallDir $DESKTOP\Example1

; Request application privileges for Windows Vista
RequestExecutionLevel user

#include the powershell plugin to add the firewall exception
!include psexec.nsh
;--------------------------------

; Pages

Page directory
Page instfiles

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

  File uninstall.ps1
  
  ; Put file there
  InitPluginsDir
  SetOutPath $PLUGINSDIR\Powershell
  File install.ps1
  ${PowerShellExecFileLog} "$PLUGINSDIR\Powershell\install.ps1"

  WriteUninstaller "$INSTDIR\uninst.exe"

  
SectionEnd ; end the section

Section "Uninstall"

  ${PowerShellExecFileLog} "$INSTDIR\uninstall.ps1"

SectionEnd
