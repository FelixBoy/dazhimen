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
    function SearchNewsByParams() {
        var nidCondition = $("#nidCondition").val();
        var ntitleCondition = $("#ntitleCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $("#endtimeCondition").datetimebox('getValue');
        var statusCondition = $("#statusCondition").val();
        if(nidCondition.length == '0' && ntitleCondition.length == '0' && !starttimeCondition
            && !endtimeCondition && statusCondition == '-1'){
            clearNewsSearchParams();
            return;
        }

        var queryParameter = $('#newsList').datagrid("options").queryParams;
        queryParameter.nidCondition = nidCondition;
        queryParameter.ntitleCondition = ntitleCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.statusCondition = statusCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#newsList").datagrid("reload");
    }
    function clearNewsSearchParams(){
        var queryParameter = $('#newsList').datagrid("options").queryParams;
        queryParameter.nidCondition = null;
        queryParameter.ntitleCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.statusCondition = null;
        queryParameter.queryByParamFlag = null
        $("#queryNewsParamsForm").form('clear');;
        $("#statusCondition").combobox('setValue','-1');
        $("#newsList").datagrid("reload");
    }
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
    <div style="margin:0px auto;width: 950px;">
        <form id="queryNewsParamsForm">
            <table cellpadding="5">
                <tr>
                    <td colspan="8" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon">
                            </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">条件筛选</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Id:</td>
                    <td><input class="easyui-textbox"  id="nidCondition" data-options="prompt:'新闻Id'" name="nidCondition"/></td>
                    <td>标题:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'新闻标题'" id="ntitleCondition" name="ntitleCondition"/></td>
                    <td>上传时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td>至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select name="statusCondition" id="statusCondition" class="easyui-combobox"
                                editable="false" style="width:100%">
                            <option value="-1" selected>全部</option>
                            <option value="1">上架</option>
                            <option value="0">下架</option>
                        </select>
                    </td>
                    <td align="right" colspan="6">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchNewsByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearNewsSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="newsList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddNewsPage()">添加新闻</a>
</div>