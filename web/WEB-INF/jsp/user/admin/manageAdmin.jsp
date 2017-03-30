<script type="text/javascript">
    function forwardAddAdminPage(){
        $('#addAdminDialog').dialog({
            title: '新增管理员',
            width: 500,
            height: 420,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdAddAdminPage",
            modal: true
        });
        $('#addAdminDialog').dialog("open");
    }
    function fwdModifyAdminPage(index){
        $('#adminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#adminList').datagrid('getSelected');
        if (row){
            $('#modifyAdminDialog').dialog({
                title: '修改管理员信息',
                width: 500,
                height: 420,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdModifyAdminPage?uid="+row.uid,
                modal: true
            });
            $('#modifyAdminDialog').dialog("open");
        }
    }
    function saveDeleteAdmin(index){
        $('#adminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#adminList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除管理员【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveDeleteAdmin?uid=" + row.uid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#adminList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdModifyAdminPage('+index+')">修改</a>&nbsp&nbsp' +
            '<a href="javascript:void(0)" onclick="saveDeleteAdmin('+index+')">删除</a>';
    }
</script>
<div style="padding:5px 0;">
    <div id="addAdminDialog" style="text-align: center;"></div>
    <div id="modifyAdminDialog" style="text-align: center;"></div>
    <table id="adminList" title="管理员列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/user/queryAllAdmin?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'uid'" width="20%">Id</th>
            <th data-options="field:'name'" width="10%">姓名</th>
            <th data-options="field:'mphone'" width="10%">手机号码</th>
            <th data-options="field:'loginname'"  width="10%">登录名</th>
            <th data-options="field:'gender'"  width="10%">性别</th>
            <th data-options="field:'remarks'" width="20%">备注</th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="20%">操作</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddAdminPage()">新增管理员</a>
</div>