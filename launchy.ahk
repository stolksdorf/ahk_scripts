;; Recreation of the app Launchy. Create text searchable application shortcuts


#HotIf !WinExist("Launchy ahk_exe AutoHotkey64.exe")
	!Space::runLaunchy()
#HotIf

QuickLinks := Map()
; [term] : [Run Cmd], [Args]
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
	global dropdown
	global currOpts

	if(dropdown.Value != 0){
		return
	}
	For idx,val in AllOptions {
		dropdown.Delete(1)
	}
	
	if(dropdown.Text != ""){
		currOpts := AllOptions.sort(opt=>InStr(opt, dropdown.Text))
	}else{
		currOpts := AllOptions.Clone()
	}
	dropdown.Opt("-Redraw")
	dropdown.Add(currOpts)
	dropdown.Opt("+Redraw")
}

#HotIf WinActive("Launchy ahk_exe AutoHotkey64.exe")
	Enter::{
		if(dropdown.Value != 0){
			execute(currOpts[dropdown.Value])
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
	global dropdown
	global currOpts

	currOpts := AllOptions.Clone()
	LaunchyGui := Gui("+AlwaysOnTop +ToolWindow -Caption", "Launchy")

	dropdown := LaunchyGui.Add("ComboBox", "Simple w250 R15", currOpts)
	dropdown.OnEvent("LoseFocus", closeLaunchy)
	dropdown.OnEvent("Change", handleChange)
	dropdown.SetFont("s15")

	LaunchyGui.BackColor := "EEAA99"
	WinSetTransColor("EEAA99", LaunchyGui)
	;LaunchyGui.Show("w500 Y150")
	LaunchyGui.Show()
}
