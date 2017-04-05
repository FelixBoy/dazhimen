<script type="text/javascript">
    function forwardMasterAddPage(){
        $('#masterAddDialog').dialog({
            title: '新增掌门',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdMasterAddPage?random_id=" + Math.random(),
            modal: true
        });
        $('#masterAddDialog').dialog("open");
    }
    function fwdViewMasterPage(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if (row) {
            $('#viewMasterDialog').dialog({
                title: '查看掌门详情',
                width: 580,
                height: 500,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdViewMasterPage?uid=" + row.uid + "&random_id=" + Math.random(),
                modal: true
            });
            $('#viewMasterDialog').dialog("open");
        }
    }
    function fwdMasterEditPage(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if (row){
            $('#masterModifyDialog').dialog({
                title: '修改掌门信息',
                width: 580,
                height: 600,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdMasterModifyPage?uid=" + row.uid + "&random_id=" + Math.random(),
                modal: true
            });
            $('#masterModifyDialog').dialog("open");
        }
    }
    function saveMasterDel(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除掌门【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveMasterDel?uid=" + row.uid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#masterList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    $(function () {
        $("#masterList").datagrid({
            title:"掌门列表",
            url:"<%=request.getContextPath()%>/user/queryAllMasters?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载掌门数据...",
            columns: [[
                { field: 'uid', title: '掌门Id', width: '10%'},
                { field: 'name', title: '姓名', width: '15%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '5%'},
                { field: 'introduction', title: '介绍', width: '20%' },
                { field: 'createDatestr', title: '状态',width: '15%' },
                {
                    field: "operateID", title: '操作',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdViewMasterPage('+rowIndex+')">查看</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdMasterEditPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveMasterDel('+rowIndex+')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#masterList').datagrid('getPager').pagination({
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
    <div id="viewMasterDialog" style="text-align: center;"></div>
    <div id="masterAddDialog" style="text-align: center;"></div>
    <div id="masterModifyDialog" style="text-align: center;"></div>
    <table id="masterList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardMasterAddPage()">新增掌门</a>
</div>
