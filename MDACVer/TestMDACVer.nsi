!define PRODUCT_NAME "Test MDACVer"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Veraida Pty Ltd"
!define PRODUCT_WEB_SITE "http://www.veraida.com"

SetCompressor lzma

!include "LogicLib.nsh"
!include "MDACVer.nsh"

Page instfiles


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Test MDACVer"
ShowInstDetails show



Section "MainSection" SEC01

    ${IfNot} ${IsMDAC2.8}
        DetailPrint "MDAC 2.8 not installed"
    ${EndIf}
    
    ${If} ${AtLeastMDAC2.8}
        DetailPrint "MDAC 2.8 or greater already installed"
    ${EndIf}

SectionEnd
