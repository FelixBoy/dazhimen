<script type="text/javascript">
    $(function () {
        $("#newsList").datagrid({
            title:"新闻列表",
            url:"<%=request.getContextPath()%>/news/queryAllNews?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载新闻数据...",
            columns: [[
                { field: 'nid', title: '新闻Id', width: '15%'},
                { field: 'title', title: '新闻标题', width: '25%'},
                { field: 'createdatetime', title: '创建时间', width: '15%'},
                { field: 'status', title: '状态', width: '10%' },
                { field: 'statusnum', hidden:'true',title: '状态'},
                {
                    field: "operateID", title: '操作',width:'35%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdViewNewsPage('+rowIndex+')">查看</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdModifyNewsStatusPage('+rowIndex+')">修改状态</a>&nbsp&nbsp&nbsp'+
                            '<a href="javascript:void(0)" onclick="fwdEditNewsPage('+rowIndex+')">编辑信息</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveNewsDel('+rowIndex+')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#newsList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function forwardAddNewsPage(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdAddNewsPage?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
</script>
<div style="padding:5px 0;">
    <table id="newsList" style="width: auto;height: auto;">
    </table>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddNewsPage()">添加新闻</a>
</div>