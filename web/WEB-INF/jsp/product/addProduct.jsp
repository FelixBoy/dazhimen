<script type="text/javascript">
    function selectMaster(){
        $('#selectMasterDialog').dialog({
            title: '选择掌门',
            width: 600,
            height: 400,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/product/fwdSelectMasterPage?random_id=" + Math.random(),
            modal: true
        });
        $('#selectMasterDialog').dialog("open");
    }
</script>
<div style="text-align:center;margin:0px auto;">
    <form id="masterInfoForm" >
        <table cellpadding="5">
            <tr>
                <td>掌门ID:</td>
                <td><input class="easyui-textbox" readonly="true" id="uid" name="uid"></td>
                <td>登录名:</td>
                <td><input class="easyui-textbox" readonly="true" id="loginname" name="loginname"></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input class="easyui-textbox" readonly="true" id="name" name="name" /></td>
                <td>手机号码:</td>
                <td><input class="easyui-textbox" readonly="true" id="mphone" name="mphone"/></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td><input class="easyui-textbox" readonly="true" id="gender" name="gender" /></td>
                <td>备注:</td>
                <td><input class="easyui-textbox" readonly="true" name="remarks" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
        <div style="text-align:right;padding-right:50px;padding-top:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="selectMaster()">选择掌门</a>
            <div id="selectMasterDialog"></div>
        </div>

        <table cellpadding="5">
            <tr>
                <td>产品类型:</td>
                <td><input class="easyui-textbox"  id="type" name="type"></td>
                <td>产品名称:</td>
                <td><input class="easyui-textbox"  id="pname" name="pname"></td>
            </tr>
            <tr>
                <td>价格:</td>
                <td><input class="easyui-textbox" id="price" name="price" /></td>
                <td>:</td>
                <td><input class="easyui-textbox" readonly="true" id="mphone" name="mphone"/></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td><input class="easyui-textbox" readonly="true" id="gender" name="gender" /></td>
                <td>备注:</td>
                <td><input class="easyui-textbox" readonly="true" name="remarks" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
    </form>
</div>
