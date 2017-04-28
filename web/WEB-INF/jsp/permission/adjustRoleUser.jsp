<script type="text/javascript">
    function returnManageRole() {
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/permission/fwdManagePermissionPage.do?random_id="+Math.random()
        });
    }
    $(function(){
        $("#adjustRoleUserForm").form("load", "<%=request.getContextPath()%>/permission/getRoleInforInAdjustUser.do" +
            "?rid=<%=request.getAttribute("rid").toString()%>&randomid=" + Math.random());
        $("#roleUserList").datagrid({
            url:"<%=request.getContextPath()%>/permission/queryIrRoleUser.do?rid=<%=request.getAttribute("rid").toString()%>&randomid=" + Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载拥有角色的人员列表...",
            columns: [[
                { field: 'uid', title: '人员Id', width: '15%'},
                { field: 'name', title: '姓名', width: '15%'},
                { field: 'mphone', title: '手机号码', width: '15%'},
                { field: 'loginname', title: '登录名', width: '15%'},
                { field: 'gender', title: '性别', width: '10%'},
                { field: 'typestr', title: '人员类型', width: '10%' },
                {
                    field: "operateID", title: '操作',width:'20%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="saveRemoveRoleUser('+rowIndex+')">移除人员</a>';
                    }
                }
            ]]
        });
    });
    function saveRemoveRoleUser(index){
        $("#roleUserList").datagrid("selectRow", index);
        var row = $('#roleUserList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认移除【'+ row.name + '】吗？',function(r) {
                if (r) {
                    $.ajax({
                        url:"<%=request.getContextPath()%>/permission/saveRemoveRoleUser.do?rid=<%=request.getAttribute("rid").toString()%>" + "&uid=" + row.uid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#roleUserList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    function forwardAddIrRoleUserPage(){
        $("#addIrRoleUserDialog").dialog({
            title:'添加拥有角色的人员',
            width: 600,
            height: 430,
            closed: true,
            cache: false,
            modal: true
        });
        $("#addIrRoleUserDialog").dialog("refresh", "<%=request.getContextPath()%>/permission/forwardAddIrRoleUserPage.do?rid=" + $("#rid").val() + "&random_id=" + Math.random());
        $("#addIrRoleUserDialog").dialog("open");
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageRole()">返回</a>
</div>
<div style="margin:0px auto;width: 800px">
    <form id="adjustRoleUserForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">角色信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="rid" name="rid"></td>
                <td>名称:</td>
                <td><input class="dzm-noBorder-text" readonly id="name" name="name"></td>
                <td>可以分配给掌门:</td>
                <td><input class="dzm-noBorder-text" readonly id="ismastercanown" name="ismastercanown"></td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="5"><textarea readonly style="width: 100%;overflow-y:auto;border: 1px solid #CCCCCC !important;" id="introduction" name="introduction" rows="5" /></td>
            </tr>
            <tr>
                <td>对应权限模块:</td>
                <td colspan="5"><textarea readonly style="width: 100%;overflow-y:auto;border: 1px solid #CCCCCC !important;" id="rolepermissionstr" name="rolepermissionstr" rows="2" /></td>
            </tr>
        </table>
    </form>
    <table cellpadding="5">
        <tr>
            <td style="width:800px">
                <div class="formTitle" style="background-color:#f2f2f2;width: 100%;">
                    <div class="formTitle-icon">
                    </div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        拥有角色的人员列表
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div id="addIrRoleUserDialog"></div>
    <table id="roleUserList" style="width: auto;height: 200px;">
    </table>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIrRoleUserPage()">添加人员</a>
</div>