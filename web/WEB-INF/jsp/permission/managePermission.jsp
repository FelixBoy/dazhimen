<script type="text/javascript">
    $(function () {
        $("#roleList").datagrid({
            title:"角色列表",
            url:"<%=request.getContextPath()%>/permission/queryAllRole.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载角色数据...",
            columns: [[
                { field: 'rid', title: '角色Id', width: '10%'},
                { field: 'name', title: '角色名称', width: '10%'},
                { field: 'introduction', title: '介绍', width: '30%' },
                { field: 'ismastercanown', title: '是否可以分配给掌门', width: '15%' },
                {
                    field: "operateID", title: '操作',width:'35%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdViewRolePage('+rowIndex+')">查看</a>&nbsp&nbsp&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdModifyRole('+rowIndex+')">修改角色</a>&nbsp&nbsp&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdAdjustRoleUserPage('+rowIndex+')">调整拥有角色的人员</a>&nbsp&nbsp&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="saveDeleteRole('+rowIndex+')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#roleList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function fwdAdjustRoleUserPage(rowIndex){
        $('#roleList').datagrid('selectRow',rowIndex);
        var row = $('#roleList').datagrid('getSelected');
        if(row){
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/permission/fwdAdjustRoleUserPage.do?random_id="+Math.random() + "&rid=" + row.rid,
                onLoad:function(){
                }
            });
        }
    }
    function fwdModifyRole(index) {
        $('#roleList').datagrid('selectRow',index);
        var row = $('#roleList').datagrid('getSelected');
        if (row){
            $('#modifyRoleDialog').dialog({
                title: '修改角色',
                width: 500,
                height: 600,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyRoleDialog").dialog({
                onClose:function(){
                    $("#modifyRoleDialog").empty();
                }
            });
            $('#modifyRoleDialog').dialog("open");
            $("#modifyRoleDialog").dialog("refresh",
                "<%=request.getContextPath()%>/permission/fwdModifyRolePage.do?randomid="+Math.random() + "&rid=" + row.rid);
        }
    }
    function fwdViewRolePage(index){
        $('#roleList').datagrid('selectRow',index);
        var row = $('#roleList').datagrid('getSelected');
        if (row){
            $('#viewRoleDialog').dialog({
                title: '查看角色信息',
                width: 500,
                height: 610,
                closed: true,
                cache: false,
                modal: true
            });
            $("#viewRoleDialog").dialog({
                onClose:function(){
                    $("#viewRoleDialog").empty();
                }
            });
            $('#viewRoleDialog').dialog("open");
            $("#viewRoleDialog").dialog("refresh",
                "<%=request.getContextPath()%>/permission/fwdViewRolePage.do?randomid="+Math.random() + "&rid=" + row.rid);
        }
    }
    function forwardAddRolePage(){
        $('#addRoleDialog').dialog({
            title: '新增角色',
            width: 500,
            height: 550,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/permission/forwardAddRolePage.do?randomid="+Math.random(),
            modal: true
        });
        $("#addRoleDialog").dialog({
            onClose:function(){
                $("#addRoleDialog").empty();
            }
        });
        $('#addRoleDialog').dialog("open");
    }
    function saveDeleteRole(index){
        $('#roleList').datagrid('selectRow',index);
        var row = $('#roleList').datagrid('getSelected');
        if (row){
            $.messager.confirm('确认','您确认删除角色【'+ row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/permission/saveDeleteRole.do?rid=" + row.rid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#roleList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
</script>
<div style="padding:5px 0;">
    <div id="viewRoleDialog"></div>
    <div id="addRoleDialog"></div>
    <div id="modifyRoleDialog"></div>
    <table id="roleList" style="width: auto;height: auto;"></table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddRolePage()">新增角色</a>
</div>