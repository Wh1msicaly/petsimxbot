petCounts := 4
rapidTime := 300
waitTime  := 100
returnCount := 0
maxReturnCounts :=500
disp1 := 0
disp2 := 0
selectDelay  := 3500
Gui, Add, Text,, whim#2127 | [> F3 <] To activate bot.
Gui, Add, Text,, Roblox | Pet Simulator X BOT by Whim 
Gui, Add, Text ,vPetCountText, Pet Count : 4.0000 < DEFAULT
Gui, Add, Slider , Range0-15 vpetCount gpetSlider, 4
Gui, Add, Text ,vselectDelayText, Select Delay : 3500 < DEFAULT
Gui, Add, Slider , Range0-8000 vdelaySld gdelaySlider, 3000
Gui, Add, Text ,vbar, AntiAFKDelay : 50000MS < DEFAULT
Gui, Add, Slider , Range0-1000 vmoveProtect gprotectSlider, 500
Gui, Show

Esc::ExitApp
protectSlider:
GuiControlGet, moveProtect
maxReturnCounts := moveProtect
disp1 := (moveProtect*100)
GuiControl, , bar , AntiAFKDelay : %disp1%
Return
petSlider:
GuiControlGet, petCount
petCounts := petCount
GuiControl, , PetCountText , Pet Count : %petCounts%
Return
delaySlider:
GuiControlGet, delaySld
selectDelay := delaySld
GuiControl, , selectDelayText , Select Delay : %selectDelay%
Return


~F3::
loop{
  sleep, %waitTime%
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
  PixelSearch, FoundX, FoundY, 602, 31, 1435, 479, 0x3bb1fc, 3, Fast RGB
  If (ErrorLevel = 0){

  } else {
     sleep, %selectDelay%
    Loop, %petCounts%
    { 
        
   	 Click 
    	sleep, %rapidTime%
    }
  }
}
return
