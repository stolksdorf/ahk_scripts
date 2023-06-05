ToString(arg){
	str := ""
	if(Type(arg) == "Array"){
		For idx,val in arg{
			str .= ToString(val) . ", "
		}
		return "[" . SubStr(str, 1, -2) . "]"
	}else if(Type(arg) == "Map"){
		For key, val in arg{
			str .= key . ": " . ToString(val) . ", "
		}
		return "{" . SubStr(str, 1, -2) . "}"
	}else if(IsObject(arg)){
		For key, val in arg.OwnProps(){
			str .= key . ": " . ToString(val) . ", "
		}
		return "{" . SubStr(str, 1, -2) . "}"
	}else if(IsNumber(arg)){
		return arg
	}
	return  "'" . arg . "'"
}


;; Logger
try{
	FileDelete("logs.txt")
}
log(args*){
	FileAppend( args.each(it=>ToString(it)).join(" ") . "`n", "logs.txt")
	return args[1]
}
msg(args*){
	MsgBox(args.each(it=>ToString(it)).join(" "))
	return args[1]
}


Object.Prototype.DefineProp("log", { call: log })
Object.Prototype.DefineProp("msg", { call: msg })

log("[Ready!]")
