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








!d::windowSelector("ahk_exe powershell.exe")
^+d::Run("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe", getExplorerPath())



!s::{
	windowSelector("ahk_exe Ssms.exe")
	Send("{Esc}")
}
#HotIf WinActive("ahk_exe Ssms.exe")
	^Up::Send("^o")
	^Right::Send("^+{F6}")
	^Left::Send("^{F6}")
	^Down::Send("^{F4}")
	^r::Send("^s{F5}")
#HotIf


!e::windowSelector("ahk_class CabinetWClass")



!q::windowSelector("ahk_exe chrome.exe")
#HotIf WinActive("ahk_exe chrome.exe")
	^Up::Send("^t")
	^Right::Send("^{PgDn}")
	^Left::Send("^{PgUp}")
	^Down::Send("^w")
#HotIf


!w::{
	windowSelector("ahk_exe sublime_text.exe")
	Send("{Esc}")
}
^+w::Run("C:\Program Files\Sublime Text\sublime_text.exe `"" . getExplorerPath() . "`"")
#HotIf WinActive("ahk_exe sublime_text.exe")
	CapsLock::Send("!l")
	^Capslock::Send("^!l")
#HotIf
#HotIf !WinActive("ahk_exe sublime_text.exe")
	CapsLock::Send("^{Left}^+{Right}")
#HotIf




!r::windowSelector("ahk_exe Teams.exe")
#HotIf WinActive("ahk_exe ahk_exe Teams.exe")
	^p::Send("^e")
#HotIf

