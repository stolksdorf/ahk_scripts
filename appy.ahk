windowSelector(processName){
	if(WinActive(processName)){
		WinActivateBottom(processName)
		return 1
	}
	if(WinExist(processName)){
		WinActivate(processName)
		return 1
	}
	return 0
}

getExplorerPath(){
	if(WinGetClass("A") == "CabinetWClass"){
		return WinGetTitle("A")
	}
	if(WinGetClass("A") == "PX_WINDOW_CLASS"){
		SplitPath(WinGetTitle("A"),, &dir)
		return dir
	}
	return ""
}

!w::{
	windowSelector("ahk_exe sublime_text.exe")
	Send("{Esc}")
}
^+w::Run("C:\Program Files\Sublime Text\sublime_text.exe " . getExplorerPath())

!d::windowSelector("ahk_exe powershell.exe")
^+d::Run("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe", getExplorerPath())


!q::windowSelector("ahk_exe chrome.exe")
!e::windowSelector("ahk_class CabinetWClass")
!r::windowSelector("ahk_exe Teams.exe")
