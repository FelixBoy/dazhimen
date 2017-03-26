/**
 * 消息管理工具类
 */
var MsgBox = new Object();
MsgBox.show= (function(msg){
    $.messager.show({
        title:'提示',
        msg:msg,
        showSpeed:100,
        timeout:3000,
        showType:'fade',
        style:{
            right:'',
            top:document.body.scrollTop+document.documentElement.scrollTop,
            bottom:'',
        }
    });

});