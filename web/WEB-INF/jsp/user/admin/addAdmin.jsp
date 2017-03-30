<script type="text/javascript">
    function checkAddAdminFormBeforeSubmit(){
        if($("#loginnameInAddAdmin").val().length == 0){
            MsgBox.show("请输入登录名");
            return fasle;
        }
        if($("#passwordInAddAdmin").val().length == 0){
            MsgBox.show("请输入密码");
            return fasle;
        }
        if($("#nameInAddAdmin").val().length == 0){
            MsgBox.show("请输入姓名");
            return fasle;
        }
        if($("#mphoneInAddAdmin").val().length == 0){
            MsgBox.show("请输入手机号码");
            return fasle;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($("#mphoneInAddAdmin").val())) {
            MsgBox.show("手机号码格式有误");
            return false;
        }
        return true;
    }
    function submitAddAdminForm(){
        if(!checkAddAdminFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveAddAdmin",
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
                <td><input class="easyui-textbox" id="loginnameInAddAdmin" name="loginname"
                           style="width:260px" data-options="prompt:'请输入登录名'" /></td>
            </tr>
            <tr>
                <td style="text-align: right">密码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="passwordInAddAdmin" name="password" style="width:260px" data-options="prompt:'请输入密码'" /></td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="nameInAddAdmin" name="name" style="width:260px" data-options="prompt:'请输入姓名'"/></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" type="text" id="mphoneInAddAdmin" name="mphone" style="width:260px" data-options="prompt:'请输入手机号码'" /></td>
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
                <td style="text-align: left;"><input class="easyui-textbox" name="remarks" data-options="multiline:true" style="width:260px;height:60px"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddAdminForm()">保存</a>
    </div>
</div>