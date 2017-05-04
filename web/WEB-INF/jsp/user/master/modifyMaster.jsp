<script type="text/javascript">
    var checkCountInMasterModify = 10;
    function cbInModifyMaster(){
        var f = $('#MasterAddForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInMasterModify){
                setTimeout(cbInModifyMaster, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function actionAfterSubmit(jsonObj) {
        LoadingMaskLayer.hide();
        var resultObj = JSON.parse(jsonObj);
        if (!resultObj) {
            return;
        }
        var code = resultObj.code;
        if (code == '200') {
            var msg = resultObj.msg;
            MsgBox.show(msg);
            $('#masterModifyDialog').dialog('close');
            $('#masterList').datagrid('reload');
        } else {
            MsgBox.show(resultObj.msg);
        }
    }
    function dealmasterModifyFormBeforeSubmit(){
        var frameId = "MasterModifyForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyMaster);
        $("#masterModifyForm").attr('target', frameId);
    }
    function submitModifyMasterForm(){
        if(!checkMoidfyMasterFormBeforeSubmit()){
            return;
        }
        dealmasterModifyFormBeforeSubmit();
        $("#masterModifyForm").submit();
        LoadingMaskLayer.show();
    }
    $(function(){
        $('#masterModifyForm').form({onLoadSuccess:function(){
            $("#headImgRealInModifyMaster").attr("src",$("#headerimgInModifyMaster").val()+"?random_id="+Math.random());
        }});
        $("#masterModifyForm").form("load", "<%=request.getContextPath()%>/user/getMasterData.do" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random());
    });
    function checkMoidfyMasterFormBeforeSubmit(){
        if($.trim($("#loginnameInModify").val()).length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#loginnameInModify").val())) > 100){
            MsgBox.show("登录名过长，无法保存");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($.trim($("#loginnameInModify").val()))){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if($.trim($("#nameInModifyMaster").val()).length == 0){
            MsgBox.show("请输入姓名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#nameInModifyMaster").val())) > 100){
            MsgBox.show("姓名过长，无法保存");
            return false;
        }
        if($.trim($("#mphoneInModifyMaseter").val()).length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($.trim($("#mphoneInModifyMaseter").val()))) {
            MsgBox.show("手机号码格式有误");
            return false;
        }
        if($.trim($("#identityInModifyMaseter").val()).length == 0){
            MsgBox.show("请输入掌门身份");
            return false;
        }
        return true;
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="masterModifyForm" action="<%=request.getContextPath()%>/user/saveMasterModify.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改掌门信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">头像:</td>
                <td><img id="headImgRealInModifyMaster" width="100px" height="100px"/>
                    <input class="dzm-noBorder-text" type="hidden" id="headerimgInModifyMaster" name="headerimg" /></td>
            </tr>
            <tr>
                <td style="text-align: right">掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uid" name="uid" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="loginnameInModify" name="loginname" style="width:300px" data-options="prompt:'请输入登录名'" /></td>
                <input type="hidden" id="lognnameOrginal" name="loginnameorginal">
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">姓名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:300px" id="nameInModifyMaster" name="name" data-options="prompt:'请输入姓名'" /></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">手机号码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:300px" id="mphoneInModifyMaseter" name="mphone" data-options="prompt:'请输入手机号码'" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">身份:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" type="text" id="identityInModifyMaseter" name="identity" style="width:300px" data-options="prompt:'请输入掌门'" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">头像文件:</td>
                <td>
                    <input class="easyui-filebox" id="headerimgInMoidfyMaster" name="headerimgInModify" style="width:300px" accept="image/jpeg,image/png"
                           data-options="prompt:'修改头像，将会覆盖原头像，支持jpg、png',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td style="text-align: right">性别:</td>
                <td>
                    <span class="radioSpan">
                        <input type="radio" name="gender" value="1" checked="checked">男</input>
                        <input type="radio" name="gender" value="2">女</input>
                    </span>
                </td>
            </tr>
            <input type="hidden" name="type" value="1"/>
            <tr>
                <td style="text-align: right">介绍:</td>
                <td><input class="easyui-textbox" name="introduction" data-options="multiline:true" style="width:300px;height:60px;"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyMasterForm()">保存</a>
    </div>
</div>