//oc全局变量====================
//JSContext
function OCH5_JSContextFunc() {
    return och5_JSContext;
}

//JSContext
function OCH5_HomeDirFunc() {
    return och5_HomeDir;
}

//LoginObject
function OCH5_LoginObjectFunc() {
    return och5_LoginObject;
}

//类与变量====================
//创建oc类
function OCH5_allocWithClass(className) {
    return och5_JSContext.allocWithClass(className);
}

//获取oc对象变量
function OCH5_getValue_context_value(context, valueName) {
    return och5_JSContext.getObjWithKeyPathObj(valueName, context);
}

//给oc对象变量赋值
function OCH5_setValue_context_valueName_value(context, valueName, aValue) {
    och5_JSContext.setObjWithKeyPathValueObj(valueName, aValue, context);
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
