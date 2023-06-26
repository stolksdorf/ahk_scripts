;; Recreation of the Divvy window management app. Use numpad to arrange windows in grids

populateMonitors(){
	Offset := 7
	Monitors := []
	MonitorCount := MonitorGetCount()
	DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
	Loop MonitorCount {
		MonitorGetWorkArea(A_Index, &X1, &Y1, &X2, &Y2)
		Monitors.Push({ x: X1-Offset, y: Y1, w: X2-X1+2*Offset, h: Y2-Y1+Offset, idx: A_Index })
	}
	return Monitors
}
Monitors := populateMonitors()

getMonitor(x, y){
	res := 0
	For idx,mon in Monitors {
		if(mon.x <= x and mon.y <= y){
			if((mon.x + mon.w) >= x and (mon.y + mon.h) >= y){
				res := mon
				break
			}
		}
	}
	return res
}

getWinMonitor(x,y,w,h){
	return getMonitor(x+20,y+20) or getMonitor(x+w/2, y+h/2)
}

moveWindow(vert, hori, targetMonitor:=false){
	WinGetPos(&currX,&currY,&currW,&currH, "A")
	isMax := WinGetMinMax("A")

	if(!targetMonitor){
		mon := getWinMonitor(currX, currY, currW, currH)
	} else{
		mon := targetMonitor
	}
	nextMon := Monitors[Mod(mon.idx, Monitors.length)+1]
	if(isMax and !targetMonitor and vert == "tall" and hori == "wide"){
		return moveWindow("tall", "wide", nextMon)
	}

	newY := Floor(mon.y   + (mon.h/2*(vert=="lower")))
	newH := Floor(mon.h/2 + (mon.h/2*(vert=="tall")))
	newX := Floor(mon.x   + (mon.w/2*(hori=="right")))
	newW := Floor(mon.w/2 + (mon.w/2*(hori=="wide")))

	if(!targetMonitor and currX==newX and currY==newY and currH==newH and currW==newW){
		return moveWindow(vert, hori, nextMon)
	}
	if(isMax){
		WinRestore("A")
	}
	WinMove(newX,newY,newW,newH, "A")
	WinGetPos(&newX,&newY,&newW,&newH, "A")
	if(!targetMonitor and currX==newX and currY==newY and currH==newH and currW==newW){
		return moveWindow(vert, hori, nextMon)
	}
	if(vert=="tall" and hori=="wide"){
		WinMaximize("A")
	}
}


NumpadEnd::
Numpad1::
!^#1::moveWindow("lower", "left")

NumpadDown::
Numpad2::
!^#2::moveWindow("lower", "wide")

NumpadPgDn::
Numpad3::
!^#3::moveWindow("lower", "right")

NumpadLeft::
Numpad4::
!^#4::moveWindow("tall", "left")

NumpadClear::
Numpad5::
!^#5::moveWindow("tall", "wide")

NumpadRight::
Numpad6::
!^#6::moveWindow("tall", "right")

NumpadHome::
Numpad7::
!^#7::moveWindow("upper", "left")

NumpadUp::
Numpad8::
!^#8::moveWindow("upper", "wide")

NumpadPgUp::
Numpad9::
!^#9::moveWindow("upper", "right")
