;; UI for easily adding new spellchecking hotstrings to the spellbank.ahk

!^+s::launchSpelly()

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
