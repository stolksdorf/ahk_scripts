;; Adds hold-button scrolling for Marble Mouse

Check:
	CoordMode, Mouse, Screen
	MouseGetPos, nX, nY
	multiplier := Min(Floor(Abs(nY-oY) / 25), 32)
	if(multiplier > 0){
		if(nY > oY){
			Send {WheelDown %multiplier%}
		}
		if(nY < oY){
			Send {WheelUp %multiplier%}
		}
		DllCall("SetCursorPos", "int", oX, "int", oY)
	}
return

oY := -1
XButton1::
	CoordMode, Mouse, Screen
	SetTimer, Check, 10
	MouseGetPos, oX, oY
return

XButton1 Up::
	SetTimer, Check, Off
	oY := -1
return

