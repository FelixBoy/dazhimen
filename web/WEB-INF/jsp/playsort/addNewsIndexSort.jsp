<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $('#addNewsIndexSortList').datagrid({
            onLoadSuccess: function(data){
                $('#addNewsIndexSortList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
        $("#addNewsIndexSortList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveAddNewsIndexSort.do?nid=" + row.nid
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addNewsIndexSortDialog').dialog('close');
                            $('#newsIndexSortList').datagrid('reload');
                        }
                    });

                }
            }
        });
    });
    function onSelectNewsIndexSort(){
        var row = $('#addNewsIndexSortList').datagrid('getSelected');
        if(row){
            $.ajax({
                url:"<%=request.getContextPath()%>/playsort/saveAddNewsIndexSort.do?nid=" + row.nid
                + "&random_id="+Math.random(),
                type:'get',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    MsgBox.show(data);
                    $('#addNewsIndexSortDialog').dialog('close');
                    $('#newsIndexSortList').datagrid('reload');
                }
            });
        }
    }
</script>
<div style="padding:5px 0;">
    <table id="addNewsIndexSortList" class="easyui-datagrid" style="width: auto;height: 400px;"
           url="<%=request.getContextPath()%>/playsort/getAddNewsIndexSortData.do?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'nid'" width="30%">Id</th>
            <th data-options="field:'title'" width="70%">标题</th>
        </tr>
        </thead>
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectNewsIndexSort()">选择</a>
</div>