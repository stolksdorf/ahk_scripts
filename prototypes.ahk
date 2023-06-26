;; Additional Array, Object, and Map functions added to their prototypes
;; Beware: AHK doesn't do nested lambda functions well

sort(arr, func := (it)=>it){
	local temp := {}
	For key, item in arr {
		score := exec(func, item,key)
		if((!IsNumber(score) and score != "") or (IsNumber(score) and score > 0)){
			if(temp.HasOwnProp(score)){
				temp.%score%.Push(item)
			}else{
				temp.%score% := [item]
			}
		}
	}
	local res := []
	For _,_arr in temp.OwnProps(){
		For _,_item in _arr{
			res.Push(_item)
		}
	}
	return res
}

each(arr,func){
	local res:=[]
	For idx,val in arr{
		res.Push(exec(func, val, idx))
	}
	return res
}

reduce(arr,func,init?){
	local acc:=init
	For idx,val in arr{
		acc := exec(func, acc, val, idx)
	}
	return acc
}

filter(arr,func){
	local res:=[]
	For idx,val in arr{
		if(exec(func, val, idx)){
			res.Push(val)
		}
	}
	return res
}

join(arr,sep:=","){
	local res:=""
	For idx,val in arr{
		res .= val . sep
	}
	return SubStr(res,1,-1*StrLen(sep))
}

exec(func, args*){
	if(Type(func)=="Func"){
		args.Capacity := func.MaxParams
		return func(args*)
	}
	return func
}

iter(obj){
	if(Type(obj)=="Map")
		return obj
	if(Type(obj)=="Array")
		return obj

	; Add string and number?

	return obj.OwnProps()
}

keys(obj){
	res := []
	For key,val in iter(obj){
		res.push(key)
	}
	return res
}
values(obj){
	res := []
	For key,val in iter(obj){
		res.push(val)
	}
	return res
}
entries(obj){
	res := []
	For key,val in iter(obj){
		res.push([key,val])
	}
	return res
}
keymap(obj, func){
	res := Map()
	For key,val in iter(obj){
		res[key] := exec(func, val, key)
	}
	return res
}


setPrototypes(obj, methods){
	For _,mthd in methods{
		obj.Prototype.DefineProp(mthd.Name, { call: mthd })
	}
}


setPrototypes(Object, [keymap,keys,values,entries])
setPrototypes(Array,  [each,reduce,join,sort,filter])
