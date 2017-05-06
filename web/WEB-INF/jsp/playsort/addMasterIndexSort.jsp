<script type="text/javascript">
    $(function(){
        $('#addMasterIndexSortList').datagrid({
            onLoadSuccess: function(data){
                $('#addMasterIndexSortList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
        $("#addMasterIndexSortList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveAddMasterIndexSort.do?uid=" + row.uid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addMasterIndexSortDialog').dialog('close');
                            $('#masterIndexSortList').datagrid('reload');
                        }
                    });

                }
            }
        });
    });
    function onSelectMasterIndexSort(){
        var row = $('#addMasterIndexSortList').datagrid('getSelected');
        if(row){
            $.ajax({
                url:"<%=request.getContextPath()%>/playsort/saveAddMasterIndexSort.do?uid=" + row.uid
                + "&random_id="+Math.random(),
                type:'get',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    MsgBox.show(data);
                    $('#addMasterIndexSortDialog').dialog('close');
                    $('#masterIndexSortList').datagrid('reload');
                }
            });
        }
    }
</script>
<div style="padding:5px 0;">
    <table id="addMasterIndexSortList" class="easyui-datagrid" style="width: auto;height: 400px;"
           url="<%=request.getContextPath()%>/playsort/getAddMasterIndexSortData.do?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'uid'" width="30%">Id</th>
            <th data-options="field:'uname'" width="40%">姓名</th>
            <th data-options="field:'mphone'" width="30%">手机号码</th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectMasterIndexSort()">选择</a>
</div>