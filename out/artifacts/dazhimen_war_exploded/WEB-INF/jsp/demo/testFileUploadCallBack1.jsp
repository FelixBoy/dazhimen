<script type="text/javascript">
    var checkCount = 10;
    function cb(){
        var f = $('#masterInfoForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCount){
                setTimeout(cb, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealFormBeforeSubmit(){
        var frameId = "masterInfoForm_iframe", $frame = null;
        var testFrameId = $('#'+frameId);
        if(testFrameId.length>0){
            testFrameId.unbind();
            testFrameId.remove();
        }
        $frame = $('<iframe id='+frameId+' name='+frameId+'></iframe>').appendTo('body');
        $frame.attr('src', window.ActiveXObject ? 'javascript:false' : 'about:blank');
        $frame.css({
            display:"none"
        });
        $frame.bind('load', cb);
        $("#masterInfoForm1").attr('target', frameId);
    }
    function submitAddProduct(){
        dealFormBeforeSubmit();
        $("#masterInfoForm1").submit();
    }
    function actionAfterSubmit(jsonObj){
        alert(" action after ");
        alert(jsonObj);
    }
    function clearForm(){
        MsgBox.show("哈哈哈");
    }
</script>
<div style="margin:0px auto;width: 650px;">
    <br/>
    <form id="masterInfoForm1" action="<%=request.getContextPath()%>/demo/saveFileUpload"
          enctype="multipart/form-data" method="post">
        <table cellpadding="5">
            <tr>
                <td>产品类型:</td>
                <td><input class="easyui-textbox"  id="type" name="type"></td>
                <td>产品名称:</td>
                <td><input class="easyui-textbox"  id="pname" name="pname"></td>
            </tr>
            <tr>
                <td>列表图片:</td>
                <td colspan="3"><input class="easyui-filebox" id="listimg" name="listimg" style="width:85%" data-options="prompt:'请选择列表图片'"></td>
            </tr>
        </table>
    </form>
    <div style="text-align: right;margin-right: 80px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddProduct()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
    </div>
</div>