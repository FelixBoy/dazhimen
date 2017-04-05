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
    $(function () {
        $("#adminList").datagrid({
            title:"管理员列表",
            url:"<%=request.getContextPath()%>/user/queryAllAdmin?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载管理员数据...",
            columns: [[
                { field: 'uid', title: '管理员Id', width: '20%'},
                { field: 'name', title: '姓名', width: '10%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '10%'},
                { field: 'remarks', title: '介绍', width: '20%' },
                {
                    field: "operateID", title: '操作',width:'20%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdModifyAdminPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveDeleteAdmin('+rowIndex+')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#adminList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
</script>
<div style="padding:5px 0;">
    <div id="addAdminDialog" style="text-align: center;"></div>
    <div id="modifyAdminDialog" style="text-align: center;"></div>
    <table id="adminList" style="width: auto;height: auto;"></table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddAdminPage()">新增管理员</a>
</div>