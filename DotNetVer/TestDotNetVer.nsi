!define PRODUCT_NAME "Test DotNetVer"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Veraida Pty Ltd"
!define PRODUCT_WEB_SITE "http://www.veraida.com"

SetCompressor lzma

!include "LogicLib.nsh"
!include "DotNetVer.nsh"

Page instfiles


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Test DotNetVer"
ShowInstDetails show



Section "MainSection" SEC01

 ${If} ${HasDotNet1.0}
    DetailPrint "Microsoft .NET Framework 1.0 installed."
 ${EndIf}

 ${If} ${HasDotNet1.1}
    DetailPrint "Microsoft .NET Framework 1.1 installed."
 ${EndIf}

 ${If} ${HasDotNet2.0}
    ${If} ${DOTNETVER_2_0} IsDotNetServicePack 1
        DetailPrint "Microsoft .NET Framework 2.0 SP1 installed."
    ${Else}
        DetailPrint "Microsoft .NET Framework 2.0 SP1 not installed."
    ${EndIf}
 ${EndIf}
 
 ${If} ${HasDotNet3.0}
    DetailPrint "Microsoft .NET Framework 3.0 installed."
 ${EndIf}
 
 ${If} ${HasDotNet3.5}
    DetailPrint "Microsoft .NET Framework 3.5 installed."
 ${EndIf}

 ${If} ${HasDotNet4.0}
    DetailPrint "Microsoft .NET Framework 3.5 installed."
 ${EndIf}

SectionEnd
