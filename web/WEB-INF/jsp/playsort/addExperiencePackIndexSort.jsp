<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $('#addExperiencePackIndexSortList').datagrid({
            onLoadSuccess: function(data){
                $('#addExperiencePackIndexSortList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
        $("#addExperiencePackIndexSortList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveAddExperiencePackIndexSort.do?pid=" + row.pid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addExperiencePackIndexSortDialog').dialog('close');
                            $('#experiencePackIndexSortList').datagrid('reload');
                        }
                    });

                }
            }
        });
    });
    function onSelectExperiencePackIndexSort(){
        var row = $('#addExperiencePackIndexSortList').datagrid('getSelected');
        if(row){
            $.ajax({
                url:"<%=request.getContextPath()%>/playsort/saveAddExperiencePackIndexSort.do?pid=" + row.pid
                + "&random_id="+Math.random(),
                type:'get',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    MsgBox.show(data);
                    $('#addExperiencePackIndexSortDialog').dialog('close');
                    $('#experiencePackIndexSortList').datagrid('reload');
                }
            });
        }
    }
</script>
<div style="padding:5px 0;">
    <table id="addExperiencePackIndexSortList" class="easyui-datagrid" style="width: auto;height: 400px;"
           url="<%=request.getContextPath()%>/playsort/getAddExperiencePackIndexSortData.do?random_id="+Math.random()
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
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectExperiencePackIndexSort()">选择</a>
</div>