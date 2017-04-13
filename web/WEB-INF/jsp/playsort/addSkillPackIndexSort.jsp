<script type="text/javascript">
    $(function(){
        $('#addSkillPackIndexSortList').datagrid({
            onLoadSuccess: function(data){
                $('#addSkillPackIndexSortList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
        $("#addSkillPackIndexSortList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveAddSkillPackIndexSort?pid=" + row.pid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addSkillPackIndexSortDialog').dialog('close');
                            $('#skillPackIndexSortList').datagrid('reload');
                        }
                    });

                }
            }
        });
    });
</script>
<div style="padding:5px 0;">
    <table id="addSkillPackIndexSortList" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/playsort/getAddSkillPackIndexSortData?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'pid'" width="30%">Id</th>
            <th data-options="field:'pname'" width="40%">名称</th>
            <th data-options="field:'type'" width="30%">类型</th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectIndexPlay()">选择</a>
</div>