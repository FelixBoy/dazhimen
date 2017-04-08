<script type="text/javascript">
    $(function () {
        $("#orderList").datagrid({
            title:"订单列表",
            url:"<%=request.getContextPath()%>/order/queryAllOrder?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载订单数据...",
            columns: [[
                { field: 'orid', title: '订单Id', width: '10%'},
                { field: 'ordersum', title: '金额', width: '5%'},
                { field: 'ordatetime', title: '下单时间', width: '15%'},
                { field: 'paymenttype', title: '支付类型', width: '7%'},
                { field: 'transaction_id', title: '支付订单号', width: '18%'},
                { field: 'cid', title: '会员Id', width: '10%'},
                { field: 'cname', title: '会员姓名', width: '10%' },
                { field: 'pid', title: '产品Id', width: '10%' },
                { field: 'pname', title: '产品名称', width: '10%' },
                { field: 'ptype', title: '产品类型', width: '5%' }
            ]],
            pagination: true
        });
        $('#orderList').datagrid('getPager').pagination({
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
    <table id="orderList" style="width: auto;height: auto;">
    </table>
</div>