<script type="text/javascript">
    $(function () {
        $("#rechargeList").datagrid({
            title:"充值列表",
            url:"<%=request.getContextPath()%>/recharge/queryAllRecharge?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载充值数据...",
            columns: [[
                { field: 'recid', title: '充值Id', width: '10%'},
                { field: 'recamount', title: '充值金额', width: '5%'},
                { field: 'recdatetime', title: '充值时间', width: '15%'},
                { field: 'paymenttype', title: '支付类型', width: '10%'},
                { field: 'transaction_id', title: '支付订单号', width: '20%'},
                { field: 'cid', title: '会员ID', width: '10%'},
                { field: 'cname', title: '会员姓名', width: '10%' },
                { field: 'cnickname', title: '会员昵称', width: '10%' },
                { field: 'mphone', title: '会员手机号码', width: '10%' }
            ]],
            pagination: true
        });
        $('#rechargeList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
</script>
<div style="padding:5px 0;">
    <table id="rechargeList" style="width: auto;height: auto;">
    </table>
</div>