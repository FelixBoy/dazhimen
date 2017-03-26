<script type="text/javascript">
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdViewCustomerPage('+index+')">查看</a>&nbsp&nbsp'+
            '<a href="javascript:void(0)" onclick="fwdModifyCustomerPage('+index+')">修改</a>&nbsp&nbsp' +
            '<a href="javascript:void(0)" onclick="saveCustomerDel('+index+')">删除</a>';
    }
    function fwdViewCustomerPage(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function fwdModifyCustomerPage(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function saveCustomerDel(index){
        MsgBox.show("功能正在开发，敬请期待");
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
            <th data-options="field:'cid'" width="15%">会员ID</th>
            <th data-options="field:'nickname'" width="8%">昵称</th>
            <th data-options="field:'mphone'" width="10%">手机号码</th>
            <th data-options="field:'name'" width="10%">姓名</th>
            <th data-options="field:'gender'"  width="7%">性别</th>
            <th data-options="field:'email'" width="15%">Email</th>
            <th data-options="field:'education'" width="15%">学历</th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="20%">操作</th>
        </tr>
        </thead>
    </table>
</div>
