<script type="text/javascript">
    $(function(){
        $('#selectMasterList').datagrid({
            onLoadSuccess: function(data){
                $('#selectMasterList').datagrid('selectRow',0);
            }
        });
    });
    $(function(){
       $("#selectMasterList").datagrid({
           onDblClickRow:function(index, row){
               if(row){
                   $("#selectMasterForm").form("load",row);
                   $('#selectMasterDialog').dialog('close');
               }
           }
       });
    });
    function onSelectMaster(){
        var row = $('#selectMasterList').datagrid('getSelected');
        if(row){
            $("#selectMasterForm").form("load",row);
            $('#selectMasterDialog').dialog('close');
        }
    }
    $(function () {
        $("#selectMasterList").datagrid({
            title:"掌门列表",
            url:"<%=request.getContextPath()%>/product/getSelectMasterData.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载掌门数据...",
            columns: [[
                { field: 'uid', title: '掌门Id', width: '20%'},
                { field: 'name', title: '姓名', width: '20%'},
                { field: 'mphone', title: '手机号码', width: '20%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '10%'},
                { field: 'introduction', title: '介绍', width: '20%' }
            ]],
            pagination: true
        });
        $('#selectMasterList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchMasterByParams() {
        var searchCondition = $("#searchCondition").val();
        if(!searchCondition){
            clearSearchMasterParams();
            return;
        }

        var queryParameter = $('#selectMasterList').datagrid("options").queryParams;
        queryParameter.searchCondition = searchCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#selectMasterList").datagrid("reload");
    }
    function clearSearchMasterParams(){
        var queryParameter = $('#selectMasterList').datagrid("options").queryParams;
        queryParameter.searchCondition = null;
        queryParameter.queryByParamFlag = null;
        $("#searchCondition").textbox("setValue","");
        $("#selectMasterList").datagrid("reload");
    }
</script>
<div style="padding:5px 0;">
    <div style="margin:0px auto;width: 650px;">
        <form id="queryAdminParamsForm">
            <table cellpadding="5">
                <tr>
                    <td  nowrap="nowrap">查询条件:</td>
                    <td><input class="easyui-textbox"  id="searchCondition" style="width: 400px;" data-options="prompt:'可以按姓名、登录名、手机号码模糊查询'" name="searchCondition"/></td>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchMasterByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearSearchMasterParams()">清空条件</a></td>
            </table>
        </form>
    </div>
    <table id="selectMasterList">
    </table>
</div>
<div style="text-align:right;padding-right:50px;padding-top:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onSelectMaster()">选择</a>
</div>