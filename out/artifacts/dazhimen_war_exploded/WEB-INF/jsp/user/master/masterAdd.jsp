<script type="text/javascript">
    function submitForm(){
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveMasterAdd",
            data:$('#masterAddForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
                $('#masterAddDialog').dialog('close');
            },
            success:function(data){
                MsgBox.show(data);
                $('#masterAddDialog').dialog('close');		// close the dialog
                $('#masterList').datagrid('reload');
            }
        });
    }
    $(function(){
        $("#loginnameInAdd").blur(function(){
            $.ajax({
                url:"<%=request.getContextPath()%>/user/checkLoginnameDuplicate?loginname="
                    + $("#loginnameInAdd").val()+"&random_id="+Math.random(),
                type:'get',
                async:true,
                error:function(data){
                    MsgBox.show(data.responseText);
                    $('#masterAddDialog').dialog('close');
                },
                success:function(data){
                    if(data == 'true'){
                        MsgBox.show("登录名" + $("#loginnameInAdd").val() + "已经存在");
                    }
                }
            });
        });
    });
</script>
<div style="padding:10px 60px 20px 60px">
    <form id="masterAddForm">
        <table cellpadding="5">
            <tr>
                <td>登录名:</td>
                <td><input class="easyui-validatebox" type="text" id="loginnameInAdd" name="loginname" data-options="required:true,missingMessage:'请输入登录名'" /></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><input class="easyui-validatebox" type="text" id="password" name="password" data-options="required:true,missingMessage:'请输入密码'" /></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input class="easyui-validatebox" type="text" id="name" name="name" data-options="required:true,missingMessage:'请输入姓名'" /></td>
            </tr>
            <tr>
                <td>手机号码:</td>
                <td><input class="easyui-validatebox" type="text" id="mphone" name="mphone" data-options="required:true,missingMessage:'请输入11位手机号码',
                validType:'length[11,11]',invalidMessage:'手机号码必须为11位'" /></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td>
                    <span class="radioSpan">
                        <input type="radio" name="gender" value="1" checked="checked">男</input>
                        <input type="radio" name="gender" value="2">女</input>
                    </span>
                </td>
            </tr>
            <input type="hidden" name="type" value="1"/>
            <tr>
                <td>备注:</td>
                <td><input class="easyui-textbox" name="remarks" data-options="multiline:true" style="height:60px"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
    </div>
</div>