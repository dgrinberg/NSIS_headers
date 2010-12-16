# DotNetVer.nsh

LogicLib extensions for checking Microsoft .NET Framework versions and service packs.

Modification by http://www.remotehams.com
Dec 07, 2010 - .NET Framework 4.0 detection added by Brandon Hansen (KG6YPI)
Dec 07, 2010 - .NET Framework 4.0 Profile Detection added (HasDotNetClientProfile or HasDotNetFullProfile) by Brandon Hansen (KG6YPI)

### Functions
"HasDotNet<version>" checks if the specific version of .NET framework is installed.

<version> can be replaced with the following values:

  - 1.0
  - 1.1
  - 2.0
  - 3.0
  - 3.5
  - 4.0

*AtLeastDotNetServicePack* checks if the .NET framework has a service pack version at least as specified.
*IsDotNetServicePack* checks if the .NET framework has a service pack version exactly as specified.
*HasDotNetClientProfile* checks if the .NET framework is a client profiled install.
*HasDotNetFullProfile* checks if the .NET framework is a full install.

*AtMostDotNetServicePack* doesn't do its job correctly, depecrated (dont use)...

### Usage examples:

    ${If} ${HasDotNet4.0}
        DetailPrint "Microsoft .NET Framework 4.0 installed."
        ${If} ${DOTNETVER_4_0} AtLeastDotNetServicePack 1
            DetailPrint "Microsoft .NET Framework 4.0 is at least SP1."
        ${Else}
            DetailPrint "Microsoft .NET Framework 4.0 SP1 not installed."
        ${EndIf}
        ${If} ${DOTNETVER_4_0} HasDotNetClientProfile 1
            DetailPrint "Microsoft .NET Framework 4.0 (Client Profile) available."
        ${EndIf}
        ${If} ${DOTNETVER_4_0} HasDotNetFullProfile 1
            DetailPrint "Microsoft .NET Framework 4.0 (Full Profile) available."
        ${EndIf}
        ${If} ${DOTNETVER_4_0} HasDotNetFullProfile 0
            DetailPrint "Microsoft .NET Framework 4.0 (Full Profile) not available."
        ${EndIf}
    ${EndIf}