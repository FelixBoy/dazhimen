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
            mphone:{
                validator: function (value, param) {
                    var reg = /^1\d{10}$/;
                    return reg.test(value);
                },
                message:'格式不正确，只能为以1开头的11位数字'
            }
        });
        $('#loginnameInAddAdmin').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入登录名'
        });
        $('#passwordInAddAdmin').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入密码'
        });
        $('#nameInAddAdmin').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入姓名'
        });
        $('#mphoneInAddAdmin').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[11]','mphone'] ,
            missingMessage:'以1开头的11位数字',
            prompt:'请输入手机号码'
        });
        $('#remarksInAddAdmin').textbox({
            required: true,
            validType: 'maxLen[300]',
            missingMessage:'最多输入300个字符',
            prompt:'请输入备注'
        });
    });
    function checkAddAdminFormBeforeSubmit(){
        if($("#loginnameInAddAdmin").val().length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($("#loginnameInAddAdmin").val())){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if(StringUtil.getCharNumber($("#loginnameInAddAdmin").val()) > 20){
            MsgBox.show("登录名过长，最长20个字符");
            return false;
        }
        if($("#passwordInAddAdmin").val().length == 0){
            MsgBox.show("请输入密码");
            return false;
        }
        var reg_password = /^[0-9a-zA-Z]*$/g;
        if(!reg_password.test($("#passwordInAddAdmin").val())){
            MsgBox.show("密码格式不正确，只能为字母或数字组合");
            return false;
        }
        if(StringUtil.getCharNumber($("#passwordInAddAdmin").val()) > 20){
            MsgBox.show("密码过长，最长20个字符");
            return false;
        }
        if($.trim(($("#nameInAddAdmin").val())).length == 0){
            MsgBox.show("请输入姓名");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#nameInAddAdmin").val())) > 20){
            MsgBox.show("姓名过长，最长20个字符");
            return false;
        }
        if($("#mphoneInAddAdmin").val().length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg_mphone = /^1\d{10}$/;
        if (!reg_mphone.test($("#mphoneInAddAdmin").val())) {
            MsgBox.show("手机号码格式不正确，只能为以1开头的11位数字");
            return false;
        }
        if(StringUtil.getCharNumber($("#remarksInAddAdmin").val()) > 300){
            MsgBox.show("备注超长，最多输入300个字符");
            return false;
        }
        return true;
    }
    function submitAddAdminForm(){
        if(!checkAddAdminFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveAddAdmin.do",
            data:$('#addAdminForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#addAdminDialog').dialog('close');
                $('#adminList').datagrid('reload');
            }
        });
    }
</script>
<div style="width: 400px;margin: 0 auto;">
    <form id="addAdminForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写管理员信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                <td><input id="loginnameInAddAdmin" name="loginname"
                           style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">密码:<span style="color:red">*</span></td>
                <td><input id="passwordInAddAdmin" name="password" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><input id="nameInAddAdmin" name="name" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号码:<span style="color:red">*</span></td>
                <td><input type="text" id="mphoneInAddAdmin" name="mphone" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right;">性别:</td>
                <td style="text-align: left;">
                        <span class="radioSpan">
                            <input type="radio" name="gender" value="1" checked="checked">男</input>
                            <input type="radio" name="gender" value="2">女</input>
                        </span>
                </td>
            </tr>
            <input type="hidden" name="type" value="2"/>
            <tr>
                <td style="text-align: right">备注:</td>
                <td style="text-align: left;"><input class="easyui-textbox" id="remarksInAddAdmin" name="remarks" data-options="multiline:true" style="width:260px;height:60px"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddAdminForm()">保存</a>
    </div>
</div>