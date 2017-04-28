<script type="text/javascript">
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
                        url:"<%=request.getContextPath()%>/playsort/saveAddIndexPlay.do?id=" + row.id + "&type=" + row.typenum
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
                url:"<%=request.getContextPath()%>/playsort/saveAddIndexPlay.do?id=" + row.id + "&type=" + row.typenum
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
           url="<%=request.getContextPath()%>/playsort/getAddIndexPlayData.do?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'id'" width="30%">Id</th>
            <th data-options="field:'name'" width="40%">名称</th>
            <th data-options="field:'type'" width="30%">类型</th>
            <th data-options="field:'typenum',hidden:true"></th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectIndexPlay()">选择</a>
</div>