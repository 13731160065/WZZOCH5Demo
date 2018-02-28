
function viewDidLoad() {
    try {
        //创建替换数组
        var array = new Array();
        
        //创建要修改的数据
        var tvc_ocabc = OCH5_createReplaceFunc("TestVC", "abc:b:c:d:e:f:", "ocabc");
        
        array[0] = tvc_ocabc;
        
        OCH5_setReplaceMethodArray(array);
    } catch(exp) {
        alert("异常:"+exp);
    }
}

function ocbbc() {
    try {
        var self = OCH5_getValue_context_value(och5_JSContext, "currentController");
        alert(self);
    } catch(exp) {
        alert("异常:"+exp);
    }
}

function ocabc() {
    try {
        //self
        var self = OCH5_getValue_context_value(och5_JSContext, "currentController");
        
        //self.view
        var self_view = OCH5_getValue_context_value(self, "view");
        
        //aView = [[UIView alloc] init];
        var aView = OCH5_allocWithClass("UIView");
        //aView.frame;
        var self_view_frame = OCH5_getValue_context_value(self_view, "frame");
        OCH5_log(self_view_frame);
        //[self.view addSubview:aView];
        OCH5_runFunc_context_funcName_1arg(self_view, "addSubview:", aView);
        //aView.frame = CGRectMake(0, 0, 100, 100);
        //    OCH5_setValue_context_valueName_value(aView, "", "")
    } catch (exp) {
        alert(exp);
    }
}
