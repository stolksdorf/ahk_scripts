#SingleInstance force
SetWorkingDir A_ScriptDir
SendMode "Input"

#Include prototypes.ahk
#Include dev.ahk

#Include shortcuts.ahk
#Include appy.ahk
#Include spelly.ahk
#Include spellbank.ahk

#Include shimmy.ahk
#Include divvy.ahk
#Include launchy.ahk

#Include pulse_connect.ahk



^F12::{
	MsgBox("Scripts are Off")
	ExitApp
}
^esc::{
	result := MsgBox("Shut Down Everything?",,1)
	if(result == "OK"){
		Shutdown(5)
	}
}


!^r::Reload()
