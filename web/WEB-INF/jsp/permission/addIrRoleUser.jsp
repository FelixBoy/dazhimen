<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function () {
        $("#addIrRoleUserList").datagrid({
            title:"人员列表",
            url:"<%=request.getContextPath()%>/permission/getAddIrRoleUserData.do?random_id="+Math.random() + "&rid=<%=request.getAttribute("rid").toString()%>",
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载人员列表数据...",
            columns: [[
                { field: 'uid', title: '人员Id', width: '20%'},
                { field: 'name', title: '姓名', width: '20%'},
                { field: 'mphone', title: '手机号码', width: '20%'},
                { field: 'loginname', title: '登录名', width: '15%'},
                { field: 'gender', title: '性别', width: '10%'},
                { field: 'typestr', title: '人员类型', width: '15%' }
            ]]
        });
        $("#addIrRoleUserList").datagrid({
            onDblClickRow:function(index, row){
                if(row){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/permission/saveAddIrRoleUser.do?uid=" + row.uid + "&rid=<%=request.getAttribute("rid").toString()%>"
                        + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#addIrRoleUserDialog').dialog('close');
                            $('#roleUserList').datagrid('reload');
                        }
                    });

                }
            },
            onLoadSuccess: function(data){
                $('#addIrRoleUserList').datagrid('selectRow',0);
            }
        });
    });
    function onSelectRoleUser(){
        var row = $('#addIrRoleUserList').datagrid('getSelected');
        if(row){
            $.ajax({
                url:"<%=request.getContextPath()%>/permission/saveAddIrRoleUser.do?uid=" + row.uid + "&rid=<%=request.getAttribute("rid").toString()%>"
                + "&random_id="+Math.random(),
                type:'get',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    MsgBox.show(data);
                    $('#addIrRoleUserDialog').dialog('close');
                    $('#roleUserList').datagrid('reload');
                }
            });

        }
    }
    function SearchMasterByParams() {
        var searchCondition = $("#searchCondition").val();
        if(!searchCondition){
            clearSearchMasterParams();
            return;
        }

        var queryParameter = $('#addIrRoleUserList').datagrid("options").queryParams;
        queryParameter.searchCondition = searchCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#addIrRoleUserList").datagrid("reload");
    }
    function clearSearchMasterParams(){
        var queryParameter = $('#addIrRoleUserList').datagrid("options").queryParams;
        queryParameter.searchCondition = null;
        queryParameter.queryByParamFlag = null;
        $("#searchCondition").textbox("setValue","");
        $("#addIrRoleUserList").datagrid("reload");
    }
</script>
<div style="padding:5px 0;">
    <div style="margin:0px auto;width: 650px;">
        <form id="queryAdminParamsForm">
            <table cellpadding="5">
                <tr>
                    <td  nowrap="nowrap">查询条件:</td>
                    <td><input class="easyui-textbox"  id="searchCondition" style="width: 300px;" data-options="prompt:'可以按姓名、登录名、手机号码模糊查询'" name="searchCondition"/></td>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchMasterByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearSearchMasterParams()">清空条件</a></td>
            </table>
        </form>
    </div>
    <table id="addIrRoleUserList" style="width: auto;height: 310px;">
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectRoleUser()">选择</a>
</div>