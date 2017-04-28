<script type="text/javascript">
    function submitModifyAdminForm() {
        if(!checkMoidfyAdminFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveModifyAdmin.do",
            data:$('#modifyAdminForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyAdminDialog').dialog('close');
                $('#adminList').datagrid('reload');
            }
        });
    }
    $(function(){
        $("#modifyAdminForm").form("load", "<%=request.getContextPath()%>/user/getAdminData.do" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random());
    });
    function checkMoidfyAdminFormBeforeSubmit(){
        if($.trim($("#loginnameInModifyAdmin").val()).length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#loginnameInModifyAdmin").val())) > 100){
            MsgBox.show("登录名过长，无法保存");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($.trim($("#loginnameInModifyAdmin").val()))){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if($.trim($("#nameInModifyAdmin").val()).length == 0){
            MsgBox.show("请输入姓名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#nameInModifyAdmin").val())) > 100){
            MsgBox.show("姓名过长，无法保存");
            return false;
        }
        if($.trim($("#mphoneInModifyAdmin").val()).length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($.trim($("#mphoneInModifyAdmin").val()))) {
            MsgBox.show("手机号码格式有误");
            return false;
        }
        return true;
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="modifyAdminForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改管理员信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">管理员ID:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="uid" name="uid" style="width:260px"></td>
            </tr>
            <tr>
                <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="loginnameInModifyAdmin" name="loginname" style="width:260px" data-options="prompt:'请输入登录名'" /></td>
                <input type="hidden" id="lognnameOrginalInModifyAdmin" name="loginnameorginal">
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:260px" id="nameInModifyAdmin" name="name" data-options="prompt:'请输入姓名'" /></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:260px" id="mphoneInModifyAdmin" name="mphone" data-options="prompt:'请输入手机号码'" /></td>
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
                <td style="text-align: right">备注:</td>
                <td><input class="easyui-textbox" name="remarks" data-options="multiline:true" style="width:260px;height:60px;"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyAdminForm()">保存</a>
    </div>
</div>