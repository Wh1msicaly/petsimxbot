;Create info
versionString   := "1.4hf-5b21"
bottomTextString := by whim#2127 | [> F3 <] To activate bot | ver%versionString%
;Calucalting screen positions via dec points
SysGet, Mon, Monitor
SetFormat, Float,0
screenWidth 	:=%MonRight%
screenHeight 	:=%MonBottom%
screenResolution:=%MonRight%x%MonBottom%
; Kept for references
screenDecXLeft 		:= 0.31354166666
screenDecXRight 	:= 0.74739583333
screenDecYTop 		:= 0.0287037037
screenDecYBottom 	:= 0.44351851851
; math caluculations
Global math_x1 	:= Round(MonRight*0.31354166666)
Global math_y1 	:= Round(MonBottom*0.0287037037)
Global math_x2 	:= Round(MonRight*0.74739583333)
Global math_y2 	:= Round(MonBottom*0.44351851851)
Global x1 	:= math_x1
Global y1 	:= math_y1
Global x2 	:= math_x2
Global y2 	:= math_y2
; Color storage
barBackColor 		:= 0x113a48
barProgressColor 	:= 0x3bb1fc
; Selected Color
scanColor 	:= barProgressColor
imageSensitivity := 3
;save information
petCounts := 4
rapidTime := 300
waitTime  := 100
returnCount := 0
holdMouse  :=true 
holdLength :=1000
holdInBetweens := 50
currentMethod = clickMethod
maxReturnCounts :=500
disp1 := 0
disp2 := 0
selectDelay  := 3500
iniFileLocationDefault=%A_scriptdir%\config.ini
IniFileLocation= %IniFileLocationDefault%
ifnotexist,%IniFileLocation%
{
 msgbox, ,Opened for the first time! , Press F3 once in game! Default settings should work for most people.
 gosub, writeIni
}
disp1 := (maxReturnCounts*100)
gosub, readIni

hmConfig :=""
if (holdMouse) 
{
   hmConfig :="checked"
}

ffConfig :=""
if (holdMouse) 
{
   ffConfig :="disabled"
}
Gui, Add, Tab, x2 y-1 w350 h370 , Home|Options|Variables
Gui, Tab, 1
Gui, Add, Text, x12 y29 w330 h20 , Roblox | Pet Simulator X BOT by Whim#2127
Gui, Add, GroupBox, x12 y59 w330 h180 , Method
Gui, Add, Text, x22 y79 w170 h20 , Change Current Method
Gui, Add, DropDownList, x192 y79 w140 h20 r5 vListMethod1 gListUpdate1, clickMethod||imageMethod
Gui, Add, Text, x22 y119 w310 h50 , Image Method : The older version that most of the options are set on`, this version should only be used if the new click method doesnt work for you!
Gui, Add, Text, x22 y179 w310 h50 , Click Method :  A new version that uses a duration of clicks to make sure that the chest is always selected it requires no positioning only the mouse over the chest.
Gui, Add, GroupBox, x12 y249 w330 h110 , How to use?
Gui, Add, Text, x22 y269 w310 h30 , If you are having a problems with functionality or would like to change something got options tab.
Gui, Add, Text, x22 y309 w310 h20 , Press "F3" to start. | Press "ESC" to stop.
Gui, Add, Text, x22 y329 w310 h20 , * All methods currently still use Anti-AFK
Gui, Tab, 2
Gui, Add, Text, x12 y29 w330 h20 , Roblox | Pet Simulator X BOT by Whim#2127
Gui, Add, Text, x12 y339 w330 h20 , by whim#2127 | [> F3 <] To activate bot | ver%versionString%
Gui, Add, GroupBox, x12 y59 w330 h200 , Options
Gui, Add, Text, x22 y79 w250 h20 , Pet Count (How many pets you can equip at once )
Gui, Add, Text, x272 y79 w60 h20 vPetCountText , %petCounts% Pets
Gui, Add, Slider, x15 y92 w324 h20 Range4-15 vpetCount gpetSlider %ffConfig%, %petCounts%
Gui, Add, Text, x22 y139 w250 h20 , Selection Delay ( Ensures that all pets get selected.)
Gui, Add, Text, x272 y139 w60 h20 vselectDelayText, %selectDelay%ms
Gui, Add, Slider, x15 y152 w324 h20 Range1-8000 vdelaySld gdelaySlider, %selectDelay%
Gui, Add, Text, x22 y189 w250 h20 , Anti AFK (How long to wait)
Gui, Add, Text, x272 y189 w60 h20  vbar, %disp1%ms
Gui, Add, Slider, x15 y207 w324 h20 Range1-1000 vmoveProtect gprotectSlider, %maxReturnCounts%
Gui, Add, Text, x22 y230 w250 h20 , One long click instead of multiple
Gui, Add, CheckBox, x264 y230 w70 h20 gupdateValues vholdMouse %hmConfig% , Enabled
Gui, Add, GroupBox, x12 y269 w330 h60 , About
Gui, Add, Text, x22 y289 w310 h30 , A bot that automatically selects,the pets using image processing to understand when the chest dissapears.
Gui, Tab, 3
Gui, Add, GroupBox, x12 y29 w330 h140 , Variables
Gui, Add, Text, x22 y49 w300 h20 , UpdateRate (how many MS) saves cpu usage. : %waitTime%ms
Gui, Add, Text, x22 y69 w300 h20 , Scan area positions (AUTO) : X1:%x1%,Y1:%y1%,X2:%x2%,Y2:%y2%
Gui, Add, Text, x22 y89 w300 h20 , Hold length on click. : %holdLength%
Gui, Add, Text, x22 y139 w200 h20 , Current Scan Detection Method
Gui, Add, DropDownList, x222 y139 w100 h20 r5 vListMethod gListUpdate, Config-Loaded||BarProgress|BarBackground

Gui, Add, GroupBox, x12 y179 w330 h90 , Config

Gui, Add, Text, x22 y199 w70 h20 , Load Config
Gui, Add, Edit, x102 y199 w160 h20 vConfigLoad Disabled, ~\config.ini
Gui, Add, Button, x262 y199 w70 h20 gloadexternalIniBrowse, Browse

Gui, Add, Text, x22 y229 w70 h20 , Export Config
Gui, Add, Edit, x102 y229 w160 h20 Disabled vConfigExport, ~\myconfig.ini
Gui, Add, Button, x262 y229 w70 h20 gexportexternalIniBrowse, Browse

Gui, Add, GroupBox, x12 y279 w330 h50 , About
Gui, Add, Text, x22 y299 w310 h20 , View current variables that can be modifed with config.ini
Gui, Add, Text, x12 y339 w330 h20 , by whim#2127 | [> F3 <] To activate bot | ver%versionString%



Gui, Show, x422 y183 w350 h370, PetSimulatorX Bot By Whim %versionString%
Menu, Tray, DeleteAll
Menu, Tray, Icon, % (FileExist(IconEmpty) ? IconEmpty : dIconEmpty)
Menu, Tray, Tip, Pet Simulator X Bot
Menu, Tray, NoStandard
Menu, Tray, Add, Exit, HideApp  ; Creates a new menu item.
Menu, Tray, Add, Show, showApp  ; Creates a new menu item.
Return

GuiClose:
Gui, Hide
MsgBox, 0,, Press ESC to end bot! Bot has moved to task icons.
return

HideApp:
ExitApp
return 
showApp:
Gui, Show, x422 y183 w350 h370, PetSimulatorX Bot By Whim 1.0
return 

Esc::
MsgBox, 0,, ESC has been pressed! Bot will now close.
ExitApp
return 
ListUpdate1:
GuiControlGet , ListMethod1
currentMethod := ListMethod1
gosub,writeIni
return 
ListUpdate:
GuiControlGet , ListMethod
if (ListMethod="BarProgress")
{
	scanColor 	:= barProgressColor	
} 
if (ListMethod="BarBackground")
{
	scanColor 	:= barBackColor
} 
gosub,writeIni
return 
updateValues:
GuiControlGet, holdMouse
if (holdMouse) {
   GuiControl, Disable, petCount
}else{
   GuiControl, Enable, petCount
}
gosub,writeIni
Return
protectSlider:
GuiControlGet, moveProtect
maxReturnCounts := moveProtect
disp1 := (moveProtect*100)
GuiControl, , bar , %disp1%ms
gosub, writeIni
Return
petSlider:
GuiControlGet, petCount
petCounts := petCount
GuiControl, , PetCountText , %petCounts% Pets
gosub, writeIni
Return
delaySlider:
GuiControlGet, delaySld
selectDelay := delaySld
GuiControl, , selectDelayText , %selectDelay%ms
gosub, writeIni
Return
updateLabels:
GuiControl, , PetCountText , %petCounts% Pets
GuiControl, , selectDelayText , %selectDelay%ms
GuiControl, , bar , %disp1%ms
return
exportexternalIniBrowse:
FileSelectFile, SelectedFile, S, myconfig.ini , Save your configuration within an (.INI) File , *.ini
msgbox , %SelectedFile%
iniFileLocation=%SelectedFile%
gosub,writeIni
iniFileLocation=%iniFileLocationDefault%
gosub,updateLabels
GuiControl, , ConfigExport , %SelectedFile%
return 
loadexternalIniBrowse:
FileSelectFile, SelectedFile, 1, config.ini , Locate your configuration to load within petsimxbot, *.ini
iniFileLocation=%SelectedFile%
gosub,readIni
iniFileLocation=%iniFileLocationDefault%
gosub,updateLabels
GuiControl, , ConfigLoad , %SelectedFile%
Return
featurenothere:
msgbox, Feature not avialable yet. 
return
writeIni:
    IniWrite,%petCounts%  	, %IniFileLocation%     ,settings , petCounts 
    IniWrite,%rapidTime% 	, %IniFileLocation% 	,settings , rapidTime 
    IniWrite,%waitTime%        	, %IniFileLocation% 	,settings , waitTime
    IniWrite,%maxReturnCounts% 	, %IniFileLocation% 	,settings , maxReturnCounts
    IniWrite,%selectDelay% 	, %IniFileLocation% 	,settings , selectDelay 
    IniWrite,%holdMouse% 	, %IniFileLocation% 	,settings , holdMouse 
    IniWrite,%imageSensitivity% 	, %IniFileLocation% 	,settings , imageSensitivity
return 
readIni:
    IniRead,petCounts  		, %IniFileLocation% ,settings  , petCounts 		, %AwpMode%
    IniRead,rapidTime  		, %IniFileLocation% ,settings  , rapidTime 		, %rapidTime%
    IniRead,waitTime 		, %IniFileLocation% ,settings  , waitTime 		, %waitTime%
    IniRead,maxReturnCounts 	, %IniFileLocation% ,settings  , maxReturnCounts 	, %maxReturnCounts%
    IniRead,selectDelay 	, %IniFileLocation% ,settings  , selectDelay 		, %selectDelay%
    IniRead,holdMouse	 	, %IniFileLocation% ,settings  , holdMouse 		, %holdMouse%
    IniRead,imageSensitivity	, %IniFileLocation% ,settings  , imageSensitivity 	, %imageSensitivity%
return 

~F3::
loop{
  sleep, %waitTime%
  if (currentMethod = "clickMethod")
  { 
    returnCount := (returnCount + Round(holdLength/waitTime))
    if returnCount >= %maxReturnCounts%   
    { 	
	returnCount := 1
	send, {a down}
        Sleep, 20
        send, {a up}
        Sleep, 20
	send, {d down}
        Sleep, 20
        send, {d up}
    }
    disp1 := (maxReturnCounts*100)
    disp2 := (returnCount*100)
    GuiControl, , bar , %disp2% / %disp1%
    send {Lbutton down}
    sleep, %holdLength%
    send {Lbutton up}
    sleep, %holdInBetweens%
  }
  if (currentMethod = "imageMethod")
  {
    returnCount := (returnCount + 1)
    if returnCount >= %maxReturnCounts%   
    { 	
	returnCount := 1
	send, {a down}
        Sleep, 20
        send, {a up}
        Sleep, 20
	send, {d down}
        Sleep, 20
        send, {d up}
    }
    disp1 := (maxReturnCounts*100)
    disp2 := (returnCount*100)
    GuiControl, , bar , %disp2% / %disp1%
    CoordMode, Pixel, Screen  
    PixelSearch, FoundX, FoundY, x1, y1, x2, y2, Format("0x{:X}", scanColor), 3, Fast RGB
    If (ErrorLevel = 0){

    } else {
    if (holdMouse = 0){
      sleep, %selectDelay%
      Loop, %petCounts%
      {      
   	  Click 
    	  sleep, %rapidTime%
        }
     } else {
        sleep, %selectDelay%
        send {Lbutton down}
        sleep, %holdLength%
        send {Lbutton up}
        sleep, %rapidTime%
      }
    }
  }
}
return
