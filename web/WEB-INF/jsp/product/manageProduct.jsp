<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %>
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
            if(row.buycount > '0'){
                $.messager.alert('提示信息','产品已经有人购买，无法修改状态！','warning');
                return;
            }
            $('#modifyProductStatusDialog').dialog({
                title: '修改产品【' + row.pname + '】的状态',
                width: 330,
                height: 150,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/product/fwdModifyProductStatusPage?random_id=" + Math.random()+"&pid=" + row.pid
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
            if(row.statusnum == '1'){
                $.messager.confirm('确认','产品【'+ row.pname + '】处于上架状态，修改【价格】等关键信息，可能造成异常，确定修改吗？',function(r){
                    if (r){
                        $('#content_panel').panel({
                            href:"<%=request.getContextPath() %>/product/fwdModifyProductPage?random_id=" + Math.random()+"&pid=" + row.pid,
                            onLoad:function(){
                            }
                        });
                    }
                });
            }else{
                $('#content_panel').panel({
                    href:"<%=request.getContextPath() %>/product/fwdModifyProductPage?random_id=" + Math.random()+"&pid=" + row.pid,
                    onLoad:function(){
                    }
                });
            }

        }
    }
    function forwardAddProductPage(){
        <%
             HttpSession sessionObj = request.getSession(false);
            LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
            if(userBean.getUtype().equals(Constant.userType_Master)){
        %>
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdAddProductByMasterPage?random_id="+Math.random(),
            onLoad:function(){
            }
        });
        <%}else{%>
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdAddProductPage?random_id="+Math.random(),
                onLoad:function(){
                }
            });
        <%}%>
    }
    function saveProductDel(index){
        $('#productList').datagrid('selectRow',index);
        var row = $('#productList').datagrid('getSelected');
        if (row){
            if(row.buycount > '0'){
                $.messager.alert('提示信息','产品已经有人购买，无法删除！','warning');
                return;
            }
            if(row.statusnum == '1'){
                $.messager.alert('提示信息','产品处于上架状态，无法删除！','warning');
                return;
            }
            if(row.statusnum == '2'){
                $.messager.alert('提示信息','产品处于预告状态，无法删除！','warning');
                return;
            }
            $.messager.confirm('确认','您确认删除产品【'+ row.pname + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/product/saveProductDel?pid=" + row.pid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#productList').datagrid('reload');
                        }
                    });
                }
            });
        }
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
                { field: 'type', title: '类型', width: '5%'},
                { field: 'price', title: '价格', width: '5%'},
                { field: 'buycount', title: '已购人数', width: '5%'},
                { field: 'createtime', title: '上传时间', width: '15%'},
                { field: 'uname', title: '掌门', width: '10%'},
                { field: 'status', title: '状态', width: '5%' },
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

    function SearchProductByParams() {
        var pidCondition = $("#pidCondition").val();
        var pnameCondition = $("#pnameCondition").val();
        var typeCondition = $("#typeCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $("#endtimeCondition").datetimebox('getValue');
        var statusCondition = $("#statusCondition").val();
        if(pidCondition.length == '0' && pnameCondition.length == '0' && typeCondition == '0'
            && !starttimeCondition && !endtimeCondition && statusCondition == '0'){
            clearProductSearchParams();
            return;
        }

        var queryParameter = $('#productList').datagrid("options").queryParams;
        queryParameter.pidCondition = pidCondition;
        queryParameter.pnameCondition = pnameCondition;
        queryParameter.typeCondition = typeCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.statusCondition = statusCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#productList").datagrid("reload");
    }
    function clearProductSearchParams(){
        var queryParameter = $('#productList').datagrid("options").queryParams;
        queryParameter.pidCondition = null;
        queryParameter.pnameCondition = null;
        queryParameter.typeCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.statusCondition = null;
        queryParameter.queryByParamFlag = null;
        $("#queryProductParamsForm").form('clear');
        $("#typeCondition").combobox('setValue','0');
        $("#statusCondition").combobox('setValue','0');
        $("#productList").datagrid("reload");
    }
</script>
<div style="padding:2px 0;">
    <div id="modifyProductStatusDialog"></div>
    <div style="margin:0px auto;width: 950px;">
        <form id="queryProductParamsForm">
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
                    <td nowrap="nowrap">Id:</td>
                    <td><input class="easyui-textbox"  id="pidCondition" data-options="prompt:'产品Id'" name="pidCondition"/></td>
                    <td nowrap="nowrap">名称:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'产品名称'" id="pnameCondition" name="pnameCondition"/></td>
                    <td nowrap="nowrap">类型:</td>
                    <td>
                        <select name="typeCondition" id="typeCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">技能包</option>
                            <option value="2">经验包</option>
                        </select>
                    </td>
                    <td nowrap="nowrap">状态:</td>
                    <td>
                        <select name="statusCondition" id="statusCondition" class="easyui-combobox"
                                editable="false" style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">上架</option>
                            <option value="2">预告</option>
                            <option value="3">下架</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">上传时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td nowrap="nowrap">至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                    <td align="right" colspan="4">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchProductByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearProductSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="productList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddProductPage()">上传产品</a>
</div>