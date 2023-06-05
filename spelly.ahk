; https://www.autohotkey.com/download/AutoCorrect.ahk



!^+s::launchSpelly()


;------------------------------------------------------------------------------
; Fix for -ign instead of -ing.
;------------------------------------------------------------------------------
#Hotstring B0  ; Turns off automatic backspacing for the following hotstrings.
::align::align
::assign::assign
::benign::benign
::campaign::campaign
::champaign::champaign
::cosign::cosign
::design::design
::ensign::ensign
::feign::feign
::foreign::foreign
::misalign::misalign
::outdesign::outdesign
::overdesign::overdesign
::preassign::preassign
::realign::realign
::reassign::reassign
::redesign::redesign
::reign::reign
::resign::resign
::sign::sign
::sovereign::sovereign
::unbenign::unbenign
 ; This makes the above hotstrings do nothing so that they override the ign->ing rule below.

#Hotstring B  ; Turn back on automatic backspacing for all subsequent hotstrings.
:?:ign::ing


;------------------------------------------
; Word endings
;------------------------------------------
:?:bilites::bilities
:?:bilties::bilities
:?:blities::bilities
:?:bilty::bility
:?:blity::bility
:?:, btu::, but ; Not just replacing "btu", as that is a unit of heat.
:?:; btu::; but
:?:n;t::n't
:?:;ll::'ll
:?:;re::'re
:?:;ve::'ve
::sice::since  ; Must precede the following line!
:?:sice::sive
:?:t eh:: the
:?:t hem:: them
:?:emnt::ment



;------------------------------------------
; GUI
;------------------------------------------
addFix(*){
	global SpellyGui

	vals := SpellyGui.Submit(1)

	if(vals.Bad != "Incorrect"){
		trigger := vals.Instant ? ":*:" : "::"
		entry := trigger . vals.Bad . "::" . vals.Fix . "`n"
		FileAppend(entry, "spellbank.ahk")
	}
	SpellyGui.Destroy()
	Reload()
}

launchSpelly(){
	global SpellyGui
	SpellyGui := Gui("", "Spelly")
	
	SpellyGui.Add("Edit", "w200 vBad", "Incorrect")
	SpellyGui.Add("Edit", "w200 vFix", "Correct")
	SpellyGui.Add("Checkbox", "vInstant Checked", "Instant Replace")

	btnOk := SpellyGui.AddButton("Default w80", "OK")
	btnOk.OnEvent("Click", addFix)

	SpellyGui.show()
}
