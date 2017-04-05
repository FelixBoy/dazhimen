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
                   $("#productForm").form("load",row);
                   $('#selectMasterDialog').dialog('close');
               }
           }
       });
    });
    function onSelectMaster(){
        var row = $('#selectMasterList').datagrid('getSelected');
        if(row){
            $("#productForm").form("load",row);
            $('#selectMasterDialog').dialog('close');
        }
    }
    $(function () {
        $("#selectMasterList").datagrid({
            title:"掌门列表",
            url:"<%=request.getContextPath()%>/product/getSelectMasterData?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载掌门数据...",
            columns: [[
                { field: 'uid', title: '掌门Id', width: '20%'},
                { field: 'name', title: '姓名', width: '10%'},
                { field: 'mphone', title: '手机号码', width: '20%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '10%'},
                { field: 'introduction', title: '介绍', width: '30%' }
            ]],
            pagination: true
        });
        $('#selectMasterList').datagrid('getPager').pagination({
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
    <table id="selectMasterList">
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectMaster()">选择</a>
</div>