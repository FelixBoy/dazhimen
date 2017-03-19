<script type="text/javascript">
    $(function(){
        $('#selectMasterList').datagrid({
            onLoadSuccess: function(data){
                $('#selectMasterList').datagrid('selectRow',0);
            }
        });

    });
    $(function(){
       $("#selectMasterList").datagrid({
           onDblClickRow:function(index, row){
               if(row){
                   $("#masterInfoForm").form("load",row);
                   $('#selectMasterDialog').dialog('close');
               }
           }
       });
    });
    function onSelectMaster(){
        var row = $('#selectMasterList').datagrid('getSelected');
        if(row){
            $("#masterInfoForm").form("load",row);
            $('#selectMasterDialog').dialog('close');
        }
    }
</script>
<div style="padding:5px 0;">
    <table id="selectMasterList" title="掌门列表" class="easyui-datagrid"
           url="<%=request.getContextPath()%>/product/getSelectMasterData?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
        <tr>
            <th data-options="field:'uid',width:100">Id</th>
            <th data-options="field:'name',width:60">姓名</th>
            <th data-options="field:'mphone',width:100">手机号码</th>
            <th data-options="field:'loginname',width:60">登录名</th>
            <th data-options="field:'gender',width:20">性别</th>
            <th data-options="field:'remarks',width:20">备注</th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectMaster()">选择</a>
</div>