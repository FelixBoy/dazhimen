<script type="text/javascript">
    function formatOperInAddIndexPlay(val,row,index) {
        return '<a href="javascript:void(0)" onclick="viewProductInfoInAddIndexPlay('+index+')">查看详情</a>';
    }
    function viewProductInfoInAddIndexPlay(index) {
        MsgBox.show("功能正在开发，敬请期待");
    }
    $(function(){
        $('#addIndexPlayList').datagrid({
            onLoadSuccess: function(data){
                $('#addIndexPlayList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
        $("#addIndexPlayList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveAddIndexPlay?pid=" + row.pid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addIndexPlayDialog').dialog('close');
                            $('#indexPlayList').datagrid('reload');
                        }
                    });

                }
            }
        });
    });
    function onSelectIndexPlay(){
        var row = $('#addIndexPlayList').datagrid('getSelected');
        if(row){
            $.ajax({
                url:"<%=request.getContextPath()%>/playsort/saveAddIndexPlay?pid=" + row.pid
                + "&random_id="+Math.random(),
                type:'get',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    MsgBox.show(data);
                    $('#addIndexPlayDialog').dialog('close');
                    $('#indexPlayList').datagrid('reload');
                }
            });

        }
    }
</script>
<div style="padding:5px 0;">
    <table id="addIndexPlayList" title="选择要首页轮播的产品或者新闻" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/playsort/getAddIndexPlayData?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'pid'" width="20%">Id</th>
            <th data-options="field:'pname'" width="30%">名称</th>
            <th data-options="field:'type'" width="20%">类型</th>
            <th data-options="field:'operate',align:'center',formatter:formatOperInAddIndexPlay" width="30%">操作</th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectIndexPlay()">选择</a>
</div>