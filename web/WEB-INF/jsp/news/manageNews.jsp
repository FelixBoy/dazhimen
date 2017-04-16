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
    function fwdEditNewsPage(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function fwdViewNewsPage(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function saveNewsDel(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function fwdModifyNewsStatusPage(index){
        $('#newsList').datagrid('selectRow',index);
        var row = $('#newsList').datagrid('getSelected');
        if (row){
            $('#modifyNewsStatusDialog').dialog({
                title: '修改新闻【' + row.title + '】的状态',
                width: 330,
                height: 150,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/news/fwdModifyNewsStatusPage?random_id=" + Math.random()+"&nid=" + row.nid
                + "&status=" + row.statusnum,
                modal: true
            });
            $('#modifyNewsStatusDialog').dialog("open");
        }
    }
</script>
<div id="modifyNewsStatusDialog"></div>
<div style="padding:5px 0;">
    <div style="height:30px;font-size: 20px;line-height: 30px;color:red;font-weight:bold;">新闻模块，正在使用富文本编辑器重写，暂时仅提供【添加新闻，修改状态】</div>
    <table id="newsList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddNewsPage()">添加新闻</a>
</div>