; ---------------------
;      MDACVer.nsh
;      Written by: David Grinberg
;      Homepage: http://ontheperiphery.veraida.com/
; ---------------------
;
; LogicLib extensions for checking Microsoft Data Access Component versions.
;
; "IsMDAC<version>" checks if the specific version of MDAC is installed.
; "AtLeastMDAC<version>" checks if the MDAC version is at least as specified.
; "AtMostMDAC<version>" checks if the MDAC version is at most as specified.
;
; <version> can be replaced with the following values:
;
;   2.0
;   2.1
;   2.5
;   2.6
;   2.7
;   2.8
;   6.0
;
;
; Usage examples:
;
;    DetailPrint "Verifying MDAC installation"
;    ${If} ${AtLeastMDAC2.8}
;        DetailPrint "Microsoft Data Access Components (MDAC 2.8) already installed"
;    ${Else}
;        MessageBox MB_OKCANCEL "Microsoft Data Access Components (MDAC 2.8) required! Do you wish to install?" IDOK +2
;        Abort
;        
;        Banner::show /NOUNLOAD /set 76 "Please Wait..." "Installing MDAC 2.8"
;        SetOverwrite On
;        File "..\..\lib\mdac_typ28.exe"
;        ExecWait '$INSTDIR\mdac_typ28.exe /Q:A /C:"dasetup /Q /N"'
;        SetRebootFlag True
;        Banner::destroy
;    ${EndIf}


!verbose push
!verbose 3

!ifndef ___MDACVER__NSH___
!define ___MDACVER__NSH___

!include LogicLib.nsh
!include Util.nsh

# constants

!define MDACVER_2_0 "2.0"
!define MDACVER_2_1 "2.1"
!define MDACVER_2_5 "2.5"
!define MDACVER_2_6 "2.6"
!define MDACVER_2_7 "2.7"
!define MDACVER_2_8 "2.8"
!define MDACVER_6_0 "6.0"

# variable declaration

Var /GLOBAL __MDAC_FOUNDVER


!macro __MDACVer_DeclareVars
    !ifndef __MDACVer_VARS_DECLARED
        !define __MDACVer_VARS_DECLARED
        Var /GLOBAL __MDACVER
  !endif
!macroend


# lazy initialization macro

!macro __MDACVer_InitVars
    # only calculate version once
    StrCmp $__MDAC_FOUNDVER "" mdacver.noveryet
        Return

    mdacver.noveryet:
    !insertmacro __MDACVer_DeclareVars
    
    Push $0
    
    ClearErrors
    ReadRegStr $0 HKLM "SOFTWARE\Microsoft\DataAccess" "FullInstallVer"
    IfErrors mdacver.notfound mdacver.found
    mdacver.found:
        StrCpy $__MDACVER $0 3
        Goto mdacver.done
    mdacver.notfound:
        StrCpy $__MDACVER 0
        Goto mdacver.done

    mdacver.done:

    StrCpy $__MDAC_FOUNDVER "1"
    
    Pop $0
!macroend

!macro _IsMDAC _a _b _t _f
    ${CallArtificialFunction} __MDACVer_InitVars

   !insertmacro _= `$__MDACVER` `${_b}` `${_t}` `${_f}`
!macroend
!define IsMDAC `IsMDAC`

!macro _AtLeastMDAC _a _b _t _f
    ${CallArtificialFunction} __MDACVer_InitVars
    
    !insertmacro _>= `$__MDACVER` `${_b}` `${_t}` `${_f}`
!macroend
!define AtLeastMDAC `AtLeastMDAC`

!macro _AtMostMDAC _a _b _t _f
    ${CallArtificialFunction} __MDACVer_InitVars

    !insertmacro _<= `$__MDACVER` `${_b}` `${_t}` `${_f}`
!macroend
!define AtMostMDAC `AtMostMDAC`

!macro __MDACVer_DefineTest Ver
  !define IsMDAC${Ver} `"" IsMDAC ${Ver}`
  !define AtLeastMDAC${Ver} `"" AtLeastMDAC ${Ver}`
  !define AtMostMDAC${Ver} `"" AtMostMDAC ${Ver}`
!macroend

!insertmacro __MDACVer_DefineTest ${MDACVER_2_0}
!insertmacro __MDACVer_DefineTest ${MDACVER_2_1}
!insertmacro __MDACVer_DefineTest ${MDACVER_2_5}
!insertmacro __MDACVer_DefineTest ${MDACVER_2_6}
!insertmacro __MDACVer_DefineTest ${MDACVER_2_7}
!insertmacro __MDACVer_DefineTest ${MDACVER_2_8}
!insertmacro __MDACVer_DefineTest ${MDACVER_6_0}

# done

!endif # !___MDACVER__NSH___

!verbose pop
