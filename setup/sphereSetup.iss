;  Sphere: JavaScript game platform
;  Copyright (c) 2015-2021, Fat Cerberus
;  All rights reserved.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions are met:
;
;  * Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
;
;  * Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
;  * Neither the name of Sphere nor the names of its contributors may be
;    used to endorse or promote products derived from this software without
;    specific prior written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;  POSSIBILITY OF SUCH DAMAGE.

; before building the installer, you should build the complete Sphere GDK using
; Visual Studio.  in other words, the entire "GDK" and "Redist" solution
; configurations.
#define AppName "Sphere"
#define AppPublisher "Fat Cerberus"
#define AppVersion3 "5.6.1"
#define AppVersion4 "5.6.1.3378"

; to create a bundle with Sphere Studio, copy the Sphere Studio binaries
; into msw/ide/ before building the installer.
#ifexist "../msw/ide/Sphere Studio.exe"
#define INCLUDE_SPHERE_STUDIO
#endif

[Setup]
OutputBaseFilename=sphereSetup-{#AppVersion3}-msw
OutputDir=.
AppId={{10C19C9F-1E29-45D8-A534-8FEF98C7C2FF}
AppName={#AppName}
AppVerName={#AppName} {#AppVersion3}
AppVersion={#AppVersion4}
AppPublisher=Fat Cerberus
AppUpdatesURL=http://forums.spheredev.org/index.php/topic,1215.0.html
AppCopyright=� 2015-2021 Fat Cerberus
AlwaysShowDirOnReadyPage=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
ChangesAssociations=yes
ChangesEnvironment=yes
Compression=lzma
DefaultDirName={autopf}\{#AppName}
DefaultGroupName=Sphere Game Development
DisableProgramGroupPage=yes
DisableWelcomePage=no
LicenseFile=../LICENSE.txt
SetupIconFile=..\msvs\spherical.ico
SolidCompression=yes
UninstallDisplayName={#AppName} {#AppVersion3}
UninstallDisplayIcon={app}\neoSphere.exe,0
VersionInfoDescription={#AppName} {#AppVersion3} Setup for Windows
VersionInfoVersion={#AppVersion4}
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "assoc"; Description: "&Associate these file extensions with neoSphere:"; GroupDescription: "Automatically open Sphere file types:"
Name: "assoc/sgm"; Description: ".sgm - Sphere &legacy manifest (game.sgm)"; GroupDescription: "Automatically open Sphere file types:"
Name: "assoc/s2gm"; Description: ".s2gm - Sphere game &manifest (game.s2gm)"; GroupDescription: "Automatically open Sphere file types:"
Name: "assoc/spk"; Description: ".spk - Sphere &SPK game package"; GroupDescription: "Automatically open Sphere file types:"
#ifdef INCLUDE_SPHERE_STUDIO
Name: "assoc_ss"; Description: "&Associate these file extensions with Sphere Studio:"; GroupDescription: "Automatically open Sphere file types:"
Name: "assoc_ss/ssproj"; Description: ".ssproj - Sphere Studio project file"; GroupDescription: "Automatically open Sphere file types:"
#endif
Name: "path"; Description: "Add the GDK tools to the system %&PATH%"; GroupDescription: "Develop on the command line:"; Flags: checkedonce unchecked

[Files]
; 64-bit (x64) binaries
Source: "..\msw\neoSphere.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\msw\spherun.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\msw\cell.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\msw\ssj.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\msw\ChakraCore.dll"; DestDir: "{app}"; Flags: ignoreversion
; everything else
Source: "..\msw\gdk-cp.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\msw\documentation\sphere2-core-api.txt"; DestDir: "{app}\documentation"; Flags: ignoreversion
Source: "..\msw\documentation\sphere2-hl-api.txt"; DestDir: "{app}\documentation"; Flags: ignoreversion
Source: "..\msw\documentation\cellscript-api.txt"; DestDir: "{app}\documentation"; Flags: ignoreversion
Source: "..\msw\system\*"; DestDir: "{app}\system"; Flags: ignoreversion recursesubdirs createallsubdirs
#ifdef INCLUDE_SPHERE_STUDIO
Source: "..\msw\ide\*"; DestDir: "{app}\ide"; Flags: ignoreversion recursesubdirs
#endif

[Registry]
; neoSphere associations
Root: HKCR; Subkey: ".spk"; ValueType: string; ValueName: ""; ValueData: "neoSphere.SPK"; Flags: uninsdeletevalue; Tasks: assoc/spk
Root: HKCR; Subkey: "neoSphere.SPK"; ValueType: string; ValueName: ""; ValueData: "Sphere Game Package"; Flags: uninsdeletekey; Tasks: assoc/spk
Root: HKCR; Subkey: "neoSphere.SPK\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\neoSphere.exe,0"; Tasks: assoc/spk
Root: HKCR; Subkey: "neoSphere.SPK\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\neoSphere.exe"" ""%1"""; Tasks: assoc/spk
Root: HKCR; Subkey: ".sgm"; ValueType: string; ValueName: ""; ValueData: "neoSphere.SGM"; Flags: uninsdeletevalue; Tasks: assoc/sgm
Root: HKCR; Subkey: "neoSphere.SGM"; ValueType: string; ValueName: ""; ValueData: "Sphere Game Manifest"; Flags: uninsdeletekey; Tasks: assoc/sgm
Root: HKCR; Subkey: "neoSphere.SGM\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\neoSphere.exe,0"; Tasks: assoc/sgm
Root: HKCR; Subkey: "neoSphere.SGM\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\neoSphere.exe"" ""%1"""; Tasks: assoc/sgm
; Sphere Studio associations
#ifdef INCLUDE_SPHERE_STUDIO
Root: HKCR; Subkey: ".ssproj"; ValueType: string; ValueName: ""; ValueData: "neoSphere.SSPROJ"; Flags: uninsdeletevalue; Tasks: assoc_ss/ssproj
Root: HKCR; Subkey: "neoSphere.SSPROJ"; ValueType: string; ValueName: ""; ValueData: "Sphere Studio Project"; Flags: uninsdeletekey; Tasks: assoc_ss/ssproj
Root: HKCR; Subkey: "neoSphere.SSPROJ\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\ide\Sphere Studio.exe,0"; Tasks: assoc_ss/ssproj
Root: HKCR; Subkey: "neoSphere.SSPROJ\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\ide\Sphere Studio.exe"" ""%1"""; Tasks: assoc_ss/ssproj
#endif
; PATH
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{app};{olddata}"; Tasks: path

[Icons]
Name: "{autoprograms}\neoSphere"; Filename: "{app}\neoSphere.exe"
#ifdef INCLUDE_SPHERE_STUDIO
Name: "{autoprograms}\Sphere Studio"; Filename: "{app}\ide\Sphere Studio.exe"
#endif
Name: "{group}\Sphere GDK Command Prompt"; Filename: "%comspec%"; Parameters: "/k ""{app}\gdk-cp.bat"""
Name: "{group}\Cellscript API Reference"; Filename: "{app}\documentation\cellscript-api.txt"
Name: "{group}\Core API Reference"; Filename: "{app}\documentation\sphere2-core-api.txt"
Name: "{group}\Sphere Runtime API Reference"; Filename: "{app}\documentation\sphere2-hl-api.txt"

[Run]
#ifdef INCLUDE_SPHERE_STUDIO
Filename: "{app}\ide\Sphere Studio.exe"; Description: "Start using Sphere Studio"; Flags: postinstall nowait skipifsilent
#endif

[Code]
procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;
