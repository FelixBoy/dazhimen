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
                { field: 'weixinuid', title: '微信Uid', width: '10%' },
                { field: 'createdate', title: '首次登录时间', width: '15%' }
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
    function SearchCustomerByParams() {
        var cidCondition = $("#cidCondition").val();
        var nicknameCondition = $("#nicknameCondition").val();
        var nameCondition = $("#nameCondition").val();
        var weixinCondition = $("#weixinCondition").val();
        var startBalanceCondition = $("#startBalanceCondition").val();
        var endBalanceCondition = $("#endBalanceCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $('#endtimeCondition').datetimebox('getValue');
        if(cidCondition.length == '0' && nicknameCondition.length == '0' && nameCondition.length == '0' && weixinCondition == '0'
            && !starttimeCondition && !endtimeCondition && startBalanceCondition.length == '0' && endBalanceCondition.length == '0'){
            clearSearchParams();
            return;
        }

        var queryParameter = $('#customerList').datagrid("options").queryParams;
        queryParameter.cidCondition = cidCondition;
        queryParameter.nicknameCondition = nicknameCondition;
        queryParameter.nameCondition = nameCondition;
        queryParameter.weixinCondition = weixinCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.startBalanceCondition = startBalanceCondition;
        queryParameter.endBalanceCondition = endBalanceCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#customerList").datagrid("reload");
    }
    function clearSearchParams(){
        var queryParameter = $('#customerList').datagrid("options").queryParams;
        queryParameter.cidCondition = null;
        queryParameter.nicknameCondition = null;
        queryParameter.nameCondition = null;
        queryParameter.weixinCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.startBalanceCondition = null;
        queryParameter.endBalanceCondition = null;
        queryParameter.queryByParamFlag = null
        $("#queryCustomerParamsForm").form('clear');;
        $("#weixinCondition").combobox('setValue','0');
        $("#customerList").datagrid("reload");
    }
</script>
<div style="padding:5px 0;">
    <div style="margin:0px auto;width: 950px;">
        <form id="queryCustomerParamsForm">
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
                    <td><input class="easyui-textbox"  id="cidCondition" data-options="prompt:'会员Id'" name="cidCondition"/></td>
                    <td nowrap="nowrap">昵称:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'会员昵称'" id="nicknameCondition" name="nicknameCondition"/></td>
                    <td>姓名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'会员姓名'" id="nameCondition" name="nameCondition"/></td>
                    <td>是否微信用户:</td>
                    <td>
                        <select name="weixinCondition" id="weixinCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">微信用户</option>
                            <option value="2">非微信用户</option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td>首次登录时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td>至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                    <td>余额范围:</td>
                    <td>
                        <input class="easyui-textbox"  id="startBalanceCondition" data-options="prompt:'余额下限'" name="startBalanceCondition"/>
                    </td>
                    <td>至</td>
                    <td>
                        <input class="easyui-textbox"  id="endBalanceCondition" data-options="prompt:'余额上限'" name="endBalanceCondition"/>
                    </td>
                </tr>
                <tr align="right">
                    <td colspan="8">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchCustomerByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="customerList" style="width: auto;height: auto;">
    </table>
</div>
