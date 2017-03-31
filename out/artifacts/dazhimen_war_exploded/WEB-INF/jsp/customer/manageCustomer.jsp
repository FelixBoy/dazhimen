<script type="text/javascript">
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdModifyCustomerPage('+index+')">修改</a>&nbsp&nbsp' +
            '<a href="javascript:void(0)" onclick="saveCustomerDel('+index+')">删除</a>';
    }
    function fwdModifyCustomerPage(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function saveCustomerDel(index){
        $("#customerList").datagrid("selectRow", index);
        var row = $("#customerList").datagrid("getSelected");
        if(row){
            $.messager.confirm('确认','您确认删除用户【'+ row.cid + '】吗？',function(r){
                if(r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/customer/saveCustomerDel?cid=" + row.cid + "&random_id=" + Math.random(),
                        type:"get",
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $("#customerList").datagrid("reload");
                        }
                    });
                }
            });
        }
    }
</script>
<div style="padding:5px 0;">
    <div id="addCustomerDialog"></div>
    <div id="modifyCustomerDialog"></div>
    <table id="customerList" title="客户列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/customer/queryAllCustomers?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'cid'" width="10%">会员ID</th>
            <th data-options="field:'nickname'" width="10%">昵称</th>
            <th data-options="field:'mphone'" width="10%">手机号码</th>
            <th data-options="field:'name'" width="10%">姓名</th>
            <th data-options="field:'gender'"  width="10%">性别</th>
            <th data-options="field:'email'" width="10%">Email</th>
            <th data-options="field:'education'" width="10%">学历</th>
            <th data-options="field:'qquid'" width="15%">QQUid</th>
            <th data-options="field:'weixinuid'" width="15%">微信Uid</th>
        </tr>
        </thead>
    </table>
</div>
