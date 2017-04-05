<div style="padding:5px 0;">
    <table id="rechargeList" title="充值列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/recharge/queryAllRecharge?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'uid'" width="20%">Id</th>
            <th data-options="field:'name'" width="10%">姓名</th>
            <th data-options="field:'mphone'" width="10%">手机号码</th>
            <th data-options="field:'loginname'"  width="10%">登录名</th>
            <th data-options="field:'gender'"  width="10%">性别</th>
            <th data-options="field:'remarks'" width="20%">备注</th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="20%">操作</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddAdminPage()">新增管理员</a>
</div>