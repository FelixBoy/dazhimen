<script>
    function fwdViewProductPage(index){
        $('#productList').datagrid('selectRow',index);
        var row = $('#productList').datagrid('getSelected');
        if (row){
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdProductInfoPage?random_id=" + Math.random()+"&pid=" + row.pid,
                onLoad:function(){
                }
            });
        }
    }
    function fwdModifyProductStatusPage(index){
        $('#productList').datagrid('selectRow',index);
        var row = $('#productList').datagrid('getSelected');
        if (row){
            $('#modifyProductStatusDialog').dialog({
                title: '修改产品【' + row.pname + '】的状态',
                width: 330,
                height: 150,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/product/fwdModifyProductStatusPage?random_id=" + Math.random()
                        + "&pid="+row.pid + "&status=" + row.statusnum,
                modal: true
            });
            $('#modifyProductStatusDialog').dialog("open");
        }

    }
    function fwdManageCoursePage(index){
        $('#productList').datagrid('selectRow',index);
        var row = $('#productList').datagrid('getSelected');
        if (row){
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdManageCoursePage?random_id=" + Math.random()+"&pid=" + row.pid,
                onLoad:function(){
                }
            });
        }
    }
    function fwdEditProductPage(index){
        $('#productList').datagrid('selectRow',index);
        var row = $('#productList').datagrid('getSelected');
        if (row){
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdModifyProductPage?random_id=" + Math.random()+"&pid=" + row.pid,
                onLoad:function(){
                }
            });
        }
    }
    function saveProductDel(index){
        MsgBox.show("功能正在开发，敬请期待");
        <%--$('#productList').datagrid('selectRow',index);--%>
        <%--var row = $('#productList').datagrid('getSelected');--%>
        <%--if (row){--%>
            <%--$.messager.confirm('确认','您确认删除产品【'+ row.pname + '】吗？',function(r){--%>
                <%--if (r){--%>
                    <%--$.ajax({--%>
                        <%--url:"<%=request.getContextPath()%>/product/saveProductDel?pid=" + row.pid+"&random_id="+Math.random(),--%>
                        <%--type:'get',--%>
                        <%--async:false,--%>
                        <%--error:function(data){--%>
                            <%--MsgBox.show(data.responseText);--%>
                        <%--},--%>
                        <%--success:function(data){--%>
                            <%--MsgBox.show(data);--%>
                            <%--$('#productList').datagrid('reload');--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    }
    $(function () {
        $("#productList").datagrid({
            title:"产品列表",
            url:"<%=request.getContextPath()%>/product/queryAllProducts?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载产品数据...",
            columns: [[
                { field: 'pid', title: '产品Id', width: '10%'},
                { field: 'pname', title: '名称', width: '15%'},
                { field: 'type', title: '类型', width: '10%'},
                { field: 'createtime', title: '上传时间', width: '15%'},
                { field: 'uname', title: '掌门', width: '10%'},
                { field: 'status', title: '状态', width: '10%' },
                { field: 'statusnum', hidden:'true',title: '状态' },
                {
                    field: "operateID", title: '操作',width:'30%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdViewProductPage('+rowIndex+')">查看</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdManageCoursePage('+rowIndex+')">管理课程</a>&nbsp&nbsp&nbsp'+
                            '<a href="javascript:void(0)" onclick="fwdModifyProductStatusPage('+rowIndex+')">修改状态</a>&nbsp&nbsp&nbsp'+
                            '<a href="javascript:void(0)" onclick="fwdEditProductPage('+rowIndex+')">编辑信息</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveProductDel('+rowIndex+')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#productList').datagrid('getPager').pagination({
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
    <div id="modifyProductStatusDialog"></div>
    <table id="productList" style="width: auto;height: auto;">
    </table>
</div>