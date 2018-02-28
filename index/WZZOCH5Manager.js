//oc全局变量====================
//JSContext
function OCH5_JSContextFunc() {
	return och5_JSContext;
}

//JSContext
function OCH5_HomeDirFunc() {
	return och5_HomeDir;
}

function OCH5_log(str) {
    och5_JSContext.makeLog(str);
}

//类与变量====================
//创建oc类
function OCH5_allocWithClass(className) {
	return och5_JSContext.allocWithClass(className);
}

function abc(abcc) {
    och5_JSContext.handleBlock(abcc);
}

//获取oc对象变量
function OCH5_getValue_context_value(context, valueName) {
	return och5_JSContext.getObjWithKeyPathObj(valueName, context);
}

//给oc对象变量赋值
function OCH5_setValue_context_valueName_value(context, valueName, aValue) {
	och5_JSContext.setObjWithKeyPathValueObj(valueName, aValue, context);
}

//调用oc类方法====================
//调用oc方法，无参
function OCH5_runClassFunc_context_funcName(context, funcName) {
    return och5_JSContext.runFuncWithClassFuncName(context, funcName);
}

//调用oc方法，1参
function OCH5_runClassFunc_context_funcName_1arg(context, funcName, arg1) {
    return och5_JSContext.runFuncWithClassFuncNameArg1(context, funcName, arg1);
}

//调用oc方法，2参
function OCH5_runClassFunc_context_funcName_2arg(context, funcName, arg1, arg2) {
    return och5_JSContext.runFuncWithClassFuncNameArg1Arg2(context, funcName, arg1, arg2);
}

//空返回
function OCH5_voidrunClassFunc_context_funcName(context, funcName) {
    och5_JSContext.voidrunFuncWithClassFuncName(context, funcName);
}
function OCH5_voidrunClassFunc_context_funcName_1arg(context, funcName, arg1) {
    och5_JSContext.voidrunFuncWithClassFuncNameArg1(context, funcName, arg1);
}
function OCH5_voidrunClassFunc_context_funcName_2arg(context, funcName, arg1, arg2) {
    och5_JSContext.voidrunFuncWithClassFuncNameArg1Arg2(context, funcName, arg1, arg2);
}

//调用oc对象方法====================
//调用oc方法，无参
function OCH5_runFunc_context_funcName(context, funcName) {
	return och5_JSContext.runFuncWithObjFuncName(context, funcName);
}

//调用oc方法，1参
function OCH5_runFunc_context_funcName_1arg(context, funcName, arg1) {
	return och5_JSContext.runFuncWithObjFuncNameArg1(context, funcName, arg1);
}

//调用oc方法，2参
function OCH5_runFunc_context_funcName_2arg(context, funcName, arg1, arg2) {
	return och5_JSContext.runFuncWithObjFuncNameArg1Arg2(context, funcName, arg1, arg2);
}

//空返回
function OCH5_voidrunFunc_context_funcName(context, funcName) {
    och5_JSContext.voidrunFuncWithObjFuncName(context, funcName);
}
function OCH5_voidrunFunc_context_funcName_1arg(context, funcName, arg1) {
    och5_JSContext.voidrunFuncWithObjFuncNameArg1(context, funcName, arg1);
}
function OCH5_voidrunFunc_context_funcName_2arg(context, funcName, arg1, arg2) {
    och5_JSContext.voidrunFuncWithObjFuncNameArg1Arg2(context, funcName, arg1, arg2);
}

/**
 设置替换方法数组
 
 @param array 方法数组
 每个元素:@{
 @"classname":@"WZZOCH5VC",
 @"objmethod":@"getObjWithKeyPath:Obj:",
 @"objmethodblock":block
 }
 */
function OCH5_setReplaceMethodArray(array) {
    och5_JSContext.setReplaceMethodArray(array);
}

//界面跳转=================
//push到H5页面
function OCH5_pushVCWithUrl(aUrl) {
    var aVC = OCH5_allocWithClass("WZZOCH5VC");
 	OCH5_setValue_context_valueName_value(aVC, "url", aUrl);
 	OCH5_pushViewController(aVC);
}

//present到H5界面
function OCH5_presentVCWithUrl(aUrl) {
 	var aVC = OCH5_allocWithClass("WZZOCH5VC");
 	OCH5_setValue_context_valueName_value(aVC, "url", aUrl);
 	OCH5_presentViewController(aVC);
}

//push界面
function OCH5_pushViewController(aVC) {
	och5_JSContext.pushVC(aVC);
}

//pop界面
function OCH5_popViewController() {
	och5_JSContext.popVC();
}

//present界面
function OCH5_presentViewController(aVC) {
	och5_JSContext.presentVC(aVC);
}

//dismiss界面
function OCH5_dismissViewController() {
	och5_JSContext.dismissVC();
}

//回调======================
//返回json字符串给oc
function OCH5_returnJsonStr(aString) {
	return och5_JSContext.returnJsonStr(aString);
}

//返回对象给oc
function OCH5_returnObject(aObject) {
	return och5_JSContext.returnJsonStr(aString);
}

//辅助方法==================
//快速创建替换方法
function OCH5_createReplaceFunc(className, funcName, replaceName) {
    //创建要修改的数据
    var replaceFuncModel = OCH5_allocWithClass("WZZOCH5CommanderReplaceMethonModel");
    
    //设置类名
    OCH5_setValue_context_valueName_value(replaceFuncModel, "classname", className);
    
    //设置方法名
    OCH5_setValue_context_valueName_value(replaceFuncModel, "objmethod", funcName);
    
    //设置要替换成的方法名
    OCH5_setValue_context_valueName_value(replaceFuncModel, "objchangemethod", replaceName);
    
    return replaceFuncModel;
}
