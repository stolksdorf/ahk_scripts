
#HotIf !WinExist("Launchy ahk_exe AutoHotkey64.exe")
	!Space::runLaunchy()
#HotIf

QuickLinks := Map()
Loop read ("launchy.conf"){
	temp := StrSplit(A_LoopReadLine, ":"," `t", 2)
	if(temp.Length == 2){
		QuickLinks[temp[1]] := StrSplit(temp[2], ","," `t")
	}
}

AllOptions := QuickLinks.keys()
currOpts := []

closeLaunchy(*){
	global LaunchyGui
	LaunchyGui.Destroy()
}

handleChange(*){
	global LaunchyGui
	global combo
	global currOpts

	if(combo.Value != 0){
		return
	}
	For idx,val in AllOptions {
		combo.Delete(1)
	}
	
	if(combo.Text != ""){
		currOpts := AllOptions.sort(opt=>InStr(opt, combo.Text))
	}else{
		currOpts := AllOptions.Clone()
	}
	combo.Opt("-Redraw")
	combo.Add(currOpts)
	combo.Opt("+Redraw")
}

#HotIf WinActive("Launchy ahk_exe AutoHotkey64.exe")
	Enter::{
		if(combo.Value != 0){
			execute(currOpts[combo.Value])
		}else if(currOpts.Length >= 1){
			execute(currOpts[1])
		}
	}
	Esc::closeLaunchy()
	!Space::closeLaunchy()
#HotIf


execute(key){
	if(QuickLinks.Has(key)){
		Run(QuickLinks[key]*)
		closeLaunchy()
	}
}

runLaunchy(){
	global LaunchyGui
	global combo
	global currOpts

	currOpts := AllOptions.Clone()
	LaunchyGui := Gui("+AlwaysOnTop +ToolWindow -Caption", "Launchy")

	combo := LaunchyGui.Add("ComboBox", "Simple w250 R15", currOpts)
	combo.OnEvent("LoseFocus", closeLaunchy)
	combo.OnEvent("Change", handleChange)
	combo.SetFont("s15")

	LaunchyGui.BackColor := "EEAA99"
	WinSetTransColor("EEAA99", LaunchyGui)
	;LaunchyGui.Show("w500 Y150")
	LaunchyGui.Show()
}
