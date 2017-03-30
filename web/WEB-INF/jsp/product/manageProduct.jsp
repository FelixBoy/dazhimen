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
    function fwdEditProductPage(inedx){
        MsgBox.show("功能正在开发，敬请期待");
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
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdViewProductPage('+index+')">查看</a>&nbsp&nbsp&nbsp' +
                '<a href="javascript:void(0)" onclick="fwdManageCoursePage('+index+')">管理课程</a>&nbsp&nbsp&nbsp'+
                '<a href="javascript:void(0)" onclick="fwdModifyProductStatusPage('+index+')">修改状态</a>&nbsp&nbsp&nbsp'+
                '<a href="javascript:void(0)" onclick="fwdEditProductPage('+index+')">编辑信息</a>&nbsp&nbsp&nbsp' +
                '<a href="javascript:void(0)" onclick="saveProductDel('+index+')">删除</a>';
    }
</script>
<div style="padding:5px 0;">
    <div id="modifyProductStatusDialog"></div>
    <table id="productList" title="产品列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/product/queryAllProducts?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'pid'" width="10%">Id</th>
            <th data-options="field:'pname'" width="15%">名称</th>
            <th data-options="field:'type'" width="10%">类型</th>
            <th data-options="field:'createtime'"  width="15%">上传时间</th>
            <th data-options="field:'uname'"  width="10%">掌门</th>
            <th data-options="field:'status'" width="10%">状态</th>
            <th data-options="field:'statusnum',hidden:'true'">状态</th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="30%">操作</th>
        </tr>
        </thead>
    </table>
</div>