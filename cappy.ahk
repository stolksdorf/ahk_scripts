;; Automatically corrects DOubled CApitalized WOrds

prefixes := "AB|BO"
letters := StrSplit("qwertyuiopasdfghjklzxcvbnm","")
For _,pre in StrSplit(prefixes, "|") {
	fixed := StrTitle(pre)
	For _,letter in letters {
		Hotstring(":*C:" . pre . letter, fixed . letter)
	}
}
