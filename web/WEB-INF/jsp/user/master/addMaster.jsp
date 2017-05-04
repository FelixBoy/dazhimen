<script type="text/javascript">
    $(function () {
        $.extend($.fn.validatebox.defaults.rules, {
            maxLen:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber($.trim(value)) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            maxLenWithoutTrim:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber(value) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            numberAndLetter:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9a-zA-Z]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为字母或数字组合'
            },
            imgfile:{
                validator: function (value, param) {
                    var imgFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            },
            mphone:{
                validator: function (value, param) {
                    var reg = /^1\d{10}$/;
                    return reg.test(value);
                },
                message:'格式不正确，只能为以1开头的11位数字'
            }
        });
        $('#loginnameInAdd').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入登录名'
        });
        $('#password').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入密码'
        });
        $('#nameInAddMaster').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入姓名'
        });
        $('#mphoneInAddMaseter').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[11]','mphone'] ,
            missingMessage:'以1开头的11位数字',
            prompt:'请输入手机号码'
        });
        $('#identityInAddMaseter').textbox({
            required: true,
            validType: 'maxLen[50]',
            missingMessage:'最多输入50个字符',
            prompt:'请输入身份'
        });
        $("#headerimgInAddMaster").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'请选择头像图片',
            validType:'imgfile'
        });
        $('#introduction').textbox({
            required: true,
            validType: 'maxLen[2000]',
            missingMessage:'最多输入2000个字符',
            prompt:'请输入介绍'
        });
    });
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
        LoadingMaskLayer.hide();
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
        LoadingMaskLayer.show();
    }
    function checkAddMasterFormBeforeSubmit(){
        if($("#loginnameInAdd").val().length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#loginnameInAdd").val())) > 20){
            MsgBox.show("登录名过长，最长20个字符");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($("#loginnameInAdd").val())){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if($("#password").val().length == 0){
            MsgBox.show("请输入密码");
            return false;
        }
        if(StringUtil.getCharNumber($("#password").val()) > 20){
            MsgBox.show("密码过长，最长20个字符");
            return false;
        }
        var reg_password = /^[0-9a-zA-Z]*$/g;
        if(!reg_password.test($("#password").val())){
            MsgBox.show("密码格式不正确，只能为字母或数字组合");
            return false;
        }
        if($.trim($("#nameInAddMaster").val()).length == 0){
            MsgBox.show("请输入姓名");
            return fasle;
        }
        if(StringUtil.getCharNumber($.trim($("#nameInAddMaster").val())) > 20){
            MsgBox.show("姓名过长，最长20个字符");
            return false;
        }
        if($("#mphoneInAddMaseter").val().length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($("#mphoneInAddMaseter").val())) {
            MsgBox.show("手机号码格式不正确，只能为以1开头的11位数字");
            return false;
        }
        if($.trim($("#identityInAddMaseter").val()).length == 0){
            MsgBox.show("请输入身份");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#identityInAddMaseter").val())) > 50){
            MsgBox.show("身份过长，最长50个字符");
            return false;
        }
        if(!$("#headerimgInAddMaster").filebox("getValue")){
            MsgBox.show("请选择掌门头像");
            return false;
        }
        var headerFileName = $("#headerimgInAddMaster").filebox("getValue");
        var headerSuffixName = headerFileName.substring(headerFileName.lastIndexOf("."));
        if(headerSuffixName != ".jpg" && headerSuffixName != ".png"){
            MsgBox.show("头像文件格式错误，仅支持jpg、png");
            return false;
        }
        if(StringUtil.getCharNumber($("#introduction").val()) > 2000){
            MsgBox.show("介绍超长，最多输入2000个字符");
            return false;
        }
        return true;
    }
</script>
<div style="width: 400px;margin: 0 auto;">
        <form id="masterAddForm" action="<%=request.getContextPath()%>/user/saveMasterAdd.do"
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
                    <td><input id="loginnameInAdd" name="loginname" style="width:300px"  /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">密码:<span style="color:red">*</span></td>
                    <td><input id="password" name="password" style="width:300px" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">姓名:<span style="color:red">*</span></td>
                    <td><input id="nameInAddMaster" name="name" style="width:300px" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">手机号码:<span style="color:red">*</span></td>
                    <td><input id="mphoneInAddMaseter" name="mphone" style="width:300px"/></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">身份:<span style="color:red">*</span></td>
                    <td><input id="identityInAddMaseter" name="identity" style="width:300px" /></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">头像图片:<span style="color:red">*</span></td>
                    <td>
                        <input id="headerimgInAddMaster" name="headerimg" style="width:300px" accept="image/jpeg,image/png"
                               data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
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
                    <td style="text-align: left;"><input id="introduction" name="introduction" data-options="multiline:true" style="width:300px;height:60px"/></td>
                </tr>
            </table>
        </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">保存</a>
    </div>
</div>