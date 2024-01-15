# Alt Tab

Extension for Fantasy Grounds that allows users to switch between open windows.

## Server/Host Installation Instructions

 - cd ...\Data\extentensions
 - git clone https://github.com/mlheur/alt-tab
 - enable extension "AltTab" when creating or loading a campaign

### Check Installation

#### Confirm Data directory
```
C:\>reg query "HKCU\SOFTWARE\SmiteWorks\Fantasy Grounds" /v DataDir
HKEY_CURRENT_USER\SOFTWARE\SmiteWorks\Fantasy Grounds
    DataDir    REG_SZ    C:\Games\FGU\Data
```

#### Change to the extensions directory
```
C:\>cd /d "C:\Games\FGU\Data"\extensions
```

#### Make sure the XML and LUA file exist
```
C:\Games\FGU\Data\extensions>dir /s /b alt-tab | findstr /v ".git"
C:\Games\FGU\Data\extensions\alt-tab\extension.xml
C:\Games\FGU\Data\extensions\alt-tab\README.md
C:\Games\FGU\Data\extensions\alt-tab\scripts
C:\Games\FGU\Data\extensions\alt-tab\scripts\AltTab.lua
```


## Usage Instructions
### Chat Commands:
 - "/alttab" will flip back & forth the two MRU windows.
 - "/alttab 1" will cycle through all windows starting with LRU.
 - "/alttab 0" will list all open windows in the chat log.
 - "/alttab #" will bring window # to the top.

### Create hotkeys for chat commands by:
 - type the command in the chat window without hitting enter
 - drag the command text to a hotkey