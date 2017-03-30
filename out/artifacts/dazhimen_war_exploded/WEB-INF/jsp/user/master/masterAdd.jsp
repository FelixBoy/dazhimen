<script type="text/javascript">
    function submitForm(){
        if(!checkAddMasterFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveMasterAdd",
            data:$('#masterAddForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#masterAddDialog').dialog('close');
                $('#masterList').datagrid('reload');
            }
        });
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
        return true;
    }
</script>
<div style="width: 400px;margin: 0 auto;">
        <form id="masterAddForm">
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
                    <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="loginnameInAdd" name="loginname"
                               style="width:260px" data-options="prompt:'请输入登录名'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">密码:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="password" name="password" style="width:260px" data-options="prompt:'请输入密码'" /></td>
                </tr>
                <tr>
                    <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" id="nameInAddMaster" name="name" style="width:260px" data-options="prompt:'请输入姓名'"/></td>
                </tr>
                <tr>
                    <td style="text-align: right">手机号码:<span style="color:red">*</span></td>
                    <td><input class="easyui-textbox" type="text" id="mphoneInAddMaseter" name="mphone" style="width:260px" data-options="prompt:'请输入手机号码'" /></td>
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
                <input type="hidden" name="type" value="1"/>
                <tr>
                    <td style="text-align: right">备注:</td>
                    <td style="text-align: left;"><input class="easyui-textbox" name="remarks" data-options="multiline:true" style="width:260px;height:60px"/></td>
                </tr>
            </table>
        </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">保存</a>
    </div>
</div>