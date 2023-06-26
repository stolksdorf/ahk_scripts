#SingleInstance force
SetWorkingDir A_ScriptDir
SendMode "Input"
FileEncoding("UTF-8")

#Include prototypes.ahk
#Include dev.ahk

#Include shortcuts.ahk
#Include appy.ahk
#Include spelly.ahk
#Include spellbank.ahk

#Include shimmy.ahk
#Include divvy.ahk
#Include launchy.ahk
#Include cappy.ahk

#Include pulse_connect.ahk

^F12::{
	TrayTip("Scripts Disabled","", "Iconi Mute")
	Sleep 1500
	ExitApp
}
^esc::{
	result := MsgBox("Shut Down Everything?",,1)
	if(result == "OK"){
		Shutdown(5)
	}
}

!^r::Reload()


showReloadedTrayTip(){
	TrayTip("Scripts Reloaded","", "Iconi Mute")
	Sleep 1500
	TrayTip()
}
showReloadedTrayTip()
