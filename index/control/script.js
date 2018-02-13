
function viewDidLoad() {
    try {
        //创建替换数组
        var array = new Array();
        
        //创建要修改的数据
        var tvc_ocabc = OCH5_createReplaceFunc("TestVC", "abc", "ocabc");
        
        array[0] = tvc_ocabc;
        
        OCH5_setReplaceMethodArray(array);
    } catch(exp) {
        alert(exp);
    }
}

function ocabc() {
    alert("abc");
    
//    var aView = OCH5_allocWithClass("UIView");
//    var self = OCH5_getValue_context_value(och5_JSContext, "currentController");
//    var self_view = OCH5_getValue_context_value(self, "view");
//    OCH5_runFunc_context_funcName_1arg(self_view, "addSubview:", aView);
//    var self_view_frame = OCH5_getValue_context_value(self_view, "frame");
//    OCH5_log(self_view_frame);
}
