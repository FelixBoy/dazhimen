<script>
    function MoveUp() {
        var row = $("#Student_Table").datagrid('getSelected');
        var index = $("#Student_Table").datagrid('getRowIndex', row);
        mysort(index, 'up', 'Student_Table');

    }
    //下移
    function MoveDown() {
        var row = $("#Student_Table").datagrid('getSelected');
        var index = $("#Student_Table").datagrid('getRowIndex', row);
        mysort(index, 'down', 'Student_Table');

    }

    function mysort(index, type, gridname) {
        if ("up" == type) {
            if (index != 0) {
                var toup = $('#' + gridname).datagrid('getData').rows[index];
                var todown = $('#' + gridname).datagrid('getData').rows[index - 1];
                $('#' + gridname).datagrid('getData').rows[index] = todown;
                $('#' + gridname).datagrid('getData').rows[index - 1] = toup;
                $('#' + gridname).datagrid('refreshRow', index);
                $('#' + gridname).datagrid('refreshRow', index - 1);
                $('#' + gridname).datagrid('selectRow', index - 1);
            }
        } else if ("down" == type) {
            var rows = $('#' + gridname).datagrid('getRows').length;
            if (index != rows - 1) {
                var todown = $('#' + gridname).datagrid('getData').rows[index];
                var toup = $('#' + gridname).datagrid('getData').rows[index + 1];
                $('#' + gridname).datagrid('getData').rows[index + 1] = todown;
                $('#' + gridname).datagrid('getData').rows[index] = toup;
                $('#' + gridname).datagrid('refreshRow', index);
                $('#' + gridname).datagrid('refreshRow', index + 1);
                $('#' + gridname).datagrid('selectRow', index + 1);
            }
        }

    }
</script>
<div style="padding:5px 0;">
    <div id="addIndexPlayDialog" style="text-align: center;"></div>
    <table id="indexPlayList" title="首页排序列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/playsort/queryAllIndexPlay?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'pid'" width="20%">Id</th>
            <th data-options="field:'pname'" width="30%">名称</th>
            <th data-options="field:'type'" width="20%">类型</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">新增</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">上移</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">下移</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">删除</a>
</div>