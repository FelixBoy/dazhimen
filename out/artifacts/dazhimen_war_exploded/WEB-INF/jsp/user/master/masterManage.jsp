<script type="text/javascript">
    function forwardMasterAddPage(){
        $('#masterAddDialog').dialog({
            title: '填写掌门信息',
            width: 600,
            height: 400,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdMasterAddPage",
            modal: true
        });
        $('#masterAddDialog').dialog("open");
    }
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdMasterEditPage('+index+')">修改</a>&nbsp&nbsp' +
            '<a href="javascript:void(0)" onclick="saveMasterDel('+index+')">删除</a>';
    }
    function fwdMasterEditPage(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if (row){
            $('#masterModifyDialog').dialog({
                title: '修改掌门信息',
                width: 600,
                height: 400,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdMasterModifyPage?uid="+row.uid,
                modal: true
            });
            $('#masterModifyDialog').dialog("open").dialog('setTitle','修改掌门信息');
        }
    }
    function saveMasterDel(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除记录吗？',function(r){
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
</script>


<div style="padding:5px 0;">
    <div id="masterAddDialog"></div>
    <div id="masterModifyDialog"></div>
    <table id="masterList" title="掌门列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/user/queryAllMasters?random_id="+Math.random()
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
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardMasterAddPage()">新增掌门</a>
</div>
