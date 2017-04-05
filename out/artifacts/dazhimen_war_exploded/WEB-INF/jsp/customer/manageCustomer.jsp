<script type="text/javascript">
    <%--function saveCustomerDel(index){--%>
        <%--$("#customerList").datagrid("selectRow", index);--%>
        <%--var row = $("#customerList").datagrid("getSelected");--%>
        <%--if(row){--%>
            <%--$.messager.confirm('确认','您确认删除用户【'+ row.cid + '】吗？',function(r){--%>
                <%--if(r){--%>
                    <%--$.ajax({--%>
                        <%--url:"<%=request.getContextPath()%>/customer/saveCustomerDel?cid=" + row.cid + "&random_id=" + Math.random(),--%>
                        <%--type:"get",--%>
                        <%--async:false,--%>
                        <%--error:function(data){--%>
                            <%--MsgBox.show(data.responseText);--%>
                        <%--},--%>
                        <%--success:function(data){--%>
                            <%--MsgBox.show(data);--%>
                            <%--$("#customerList").datagrid("reload");--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    <%--}--%>
    $(function () {
        $("#customerList").datagrid({
            title:"客户列表",
            url:"<%=request.getContextPath()%>/customer/queryAllCustomers?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载会员数据...",
            columns: [[
                { field: 'cid', title: '会员Id', width: '10%'},
                { field: 'nickname', title: '昵称', width: '8%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'name', title: '姓名', width: '7%'},
                { field: 'gender', title: '性别', width: '5%'},
                { field: 'email', title: 'Email', width: '10%' },
                { field: 'education', title: '学历', width: '10%' },
                { field: 'accoutbalance', title: '余额', width: '5%' },
                { field: 'qquid', title: 'QQUid', width: '10%' },
                { field: 'weixinuid', title: '余额', width: '10%' },
                { field: 'createdate', title: '创建时间', width: '15%' }
            ]],
            pagination: true
        });
        $('#customerList').datagrid('getPager').pagination({
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
    <table id="customerList" style="width: auto;height: auto;">
    </table>
</div>
