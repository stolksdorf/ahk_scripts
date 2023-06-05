
;; Logger
try{
	FileDelete("ahk_logs.txt")
}
log(params*){
	local str := ""
	for index,param in params
		str .= " " . tostring(param)
	local temp:= SubStr(str,2)
	FileAppend(temp . "`n", "ahk_logs.txt")
}
log(">>Ready!")


tostring(obj){
	if(Type(obj) == "Array"){
		res := ""
		For idx,val in obj{
			res .= tostring(val) . ", "
		}
		return "[" . SubStr(res, 1, -2) . "]"
	}
	if(IsObject(obj)){
		res := ""
		For key, val in obj.OwnProps(){
			res .= key . ": " . tostring(val) . ", "
		}
		return "{" . SubStr(res, 1, -2) . "}"
	}
	return obj
}
