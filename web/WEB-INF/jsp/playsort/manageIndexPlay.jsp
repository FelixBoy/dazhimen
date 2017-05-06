<script type="text/javascript">
    function formatOper(val,row,index) {
        return '<a href="javascript:void(0)" onclick="saveDeleteIndexPlay('+index+')">取消轮播</a>';
    }
    function saveDeleteIndexPlay(index){
        $("#indexPlayList").datagrid("selectRow", index);
        var row = $('#indexPlayList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认取消【'+ row.name + '】的首页轮播吗？',function(r) {
                if (r) {
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveDeleteIndexPlay.do?id=" + row.id + "&type="+row.typenum
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#indexPlayList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    function forwardAddIndexPlayPage(){
        var rows = $("#indexPlayList").datagrid("getRows");
        if(rows.length >= 6){
            MsgBox.show("最多允许有6个首页轮播");
            return;
        }
        $('#addIndexPlayDialog').dialog({
            title: '新增轮播',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            modal: true
        });
        $("#addIndexPlayDialog").dialog({
            onClose:function(){
                $("#addIndexPlayDialog").empty();
            }
        });
        $('#addIndexPlayDialog').dialog("open");
        $("#addIndexPlayDialog").dialog("refresh",
            "<%=request.getContextPath()%>/playsort/fwdAddIndexPlayPage.do?random_id=" + Math.random());
    }
</script>
<div style="padding:5px 0;">
    <div id="addIndexPlayDialog" style="text-align: center;"></div>
    <table id="indexPlayList" title="首页轮播列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/playsort/queryAllIndexPlay.do?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'id'" width="20%">Id</th>
            <th data-options="field:'name'" width="30%">名称</th>
            <th data-options="field:'type'" width="20%">类型</th>
            <th data-options="field:'typenum',hidden:true"></th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="30%">操作</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">新增轮播</a>
</div>