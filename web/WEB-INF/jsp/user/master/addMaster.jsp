<script type="text/javascript">
    var checkCountInMasterAdd = 10;
    function cbInAddMaster(){
        var f = $('#MasterAddForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInMasterAdd){
                setTimeout(cbInAddMaster, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealmasterAddFormBeforeSubmit(){
        var frameId = "MasterAddForm_iframe", $frame = null;
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
        $frame.bind('load', cbInAddMaster);
        $("#masterAddForm").attr('target', frameId);
    }
    function actionAfterSubmit(jsonObj) {
        var resultObj = JSON.parse(jsonObj);
        if (!resultObj) {
            return;
        }
        var code = resultObj.code;
        if (code == '200') {
            var msg = resultObj.msg;
            MsgBox.show(msg);
            $('#masterAddDialog').dialog('close');
            $('#masterList').datagrid('reload');
        } else {
            MsgBox.show(resultObj.msg);
        }
    }
    function submitForm(){
        if(!checkAddMasterFormBeforeSubmit()){
            return;
        }
        dealmasterAddFormBeforeSubmit();
        $("#masterAddForm").submit();
    }
    function checkAddMasterFormBeforeSubmit(){
        if($("#loginnameInAdd").val().length == 0){
            MsgBox.show("请输入登录名");
            return fasle;
        }
        if($("#password").val().length == 0){
            MsgBox.show("请输入密码");
            return fasle;
        }
        if($("#nameInAddMaster").val().length == 0){
            MsgBox.show("请输入姓名");
            return fasle;
        }
        if($("#mphoneInAddMaseter").val().length == 0){
            MsgBox.show("请输入手机号码");
            return fasle;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($("#mphoneInAddMaseter").val())) {
            MsgBox.show("手机号码格式有误");
            return false;
        }
        if($("#identityInAddMaseter").val().length == 0){
            MsgBox.show("请输入掌门身份");
            return fasle;
        }
        if(!$("#headerimgInAddMaster").filebox("getValue")){
            MsgBox.show("请选择掌门头像");
            return fasle;
        }
        var headerFileName = $("#headerimgInAddMaster").filebox("getValue");
        var headerSuffixName = headerFileName.substring(headerFileName.lastIndexOf("."));
        if(headerSuffixName != ".jpg" && headerSuffixName != ".png"){
            MsgBox.show("头像文件格式错误，仅支持jpg、png");
            return false;
        }
        return true;
    }
</script>
<div style="width: 400px;margin: 0 auto;">
        <form id="masterAddForm" action="<%=request.getContextPath()%>/user/saveMasterAdd"
              enctype="multipart/form-data" method="post">
            <br/>
            <table cellpadding="5">
                <tr>
                    <td colspan="2" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon">
                            </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写掌门信息</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">登录名:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="loginnameInAdd" name="loginname"
                               style="width:300px" data-options="prompt:'请输入登录名'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">密码:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="password" name="password" style="width:300px" data-options="prompt:'请输入密码'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">姓名:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="nameInAddMaster" name="name" style="width:300px" data-options="prompt:'请输入姓名'"/></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">手机号码:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" type="text" id="mphoneInAddMaseter" name="mphone" style="width:300px" data-options="prompt:'请输入手机号码'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">身份:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" type="text" id="identityInAddMaseter" name="identity" style="width:300px" data-options="prompt:'请输入掌门'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">头像文件:<span style="color:red">*</span></td>
                    <td>
                        <input class="easyui-filebox" id="headerimgInAddMaster" name="headerimg" style="width:300px" accept="image/jpeg,image/png"
                               data-options="prompt:'请选掌门头像，支持jpg、png',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;" nowrap="nowrap">性别:</td>
                    <td style="text-align: left;">
                        <span class="radioSpan">
                            <input type="radio" name="gender" value="1" checked="checked">男</input>
                            <input type="radio" name="gender" value="2">女</input>
                        </span>
                    </td>
                </tr>
                <input type="hidden" name="type" value="1"/>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">介绍:</td>
                    <td style="text-align: left;"><input class="easyui-textbox" name="introduction" data-options="multiline:true" style="width:300px;height:60px"/></td>
                </tr>
            </table>
        </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">保存</a>
    </div>
</div>