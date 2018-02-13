function back() {
    OCH5_popViewController();
}

function btn() {
    var str = "wzzoch5://test1/test.html";
    var testModel = OCH5_allocWithClass("WZZTestModel");
    OCH5_setValue_context_valueName_value("name", "小明", testModel);
    OCH5_setValue_context_valueName_value("age", "10", testModel);
    OCH5_setValue_context_valueName_value("height", "170.5", testModel);
    OCH5_setValue_context_valueName_value("isMan", "YES", testModel);
    var argsDic = new Map();
    argsDic["model"] = testModel;
    var name = OCH5_getValue_context_value("name", och5CallBack_model);
    var age = OCH5_getValue_context_value("age", och5CallBack_model);
    var height = OCH5_getValue_context_value("height", och5CallBack_model);
    var isMan = OCH5_getValue_context_value("isMan", och5CallBack_model);
    
}

function changeInfo(name, age, height, isMan) {
    document.getElementById('contentDiv').innerHTML = "name:"+name+"\nage:"+age+"\nheight:"+height+"\nisMan:"+isMan;
}
