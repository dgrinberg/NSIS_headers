# MDACVer.nsh

LogicLib extensions for checking Microsoft Data Access Component versions.

### Functions
*IsMDAC<version>* checks if the specific version of MDAC is installed.
*AtLeastMDAC<version>* checks if the MDAC version is at least as specified.
*AtMostMDAC<version>* checks if the MDAC version is at most as specified.

<version> can be replaced with the following values:

  -  2.0
  -  2.1
  -  2.5
  -  2.6
  -  2.7
  -  2.8
  -  6.0

### Usage examples:


    DetailPrint "Verifying MDAC installation"
    ${If} ${AtLeastMDAC2.8}
        DetailPrint "Microsoft Data Access Components (MDAC 2.8) already installed"
    ${Else}
        MessageBox MB_OKCANCEL "Microsoft Data Access Components (MDAC 2.8) required! Do you wish to install?" IDOK +2
        Abort
        
        Banner::show /NOUNLOAD /set 76 "Please Wait..." "Installing MDAC 2.8"
        SetOverwrite On
        File "..\..\lib\mdac_typ28.exe"
        ExecWait '$INSTDIR\mdac_typ28.exe /Q:A /C:"dasetup /Q /N"'
        SetRebootFlag True
        Banner::destroy
    ${EndIf}