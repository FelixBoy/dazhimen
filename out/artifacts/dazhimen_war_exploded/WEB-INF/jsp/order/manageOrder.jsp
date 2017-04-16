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
    function SearchOrderByParams() {
        var cidCondition = $("#cidCondition").val();
        var mphoneCondition = $("#mphoneCondition").val();
        var producttypeCondition = $("#producttypeCondition").val();
        var paymenttypeCondition = $("#paymenttypeCondition").val();
        var startAmountCondition = $("#startAmountCondition").val();
        var endAmountCondition = $("#endAmountCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $('#endtimeCondition').datetimebox('getValue');
        if(!cidCondition && !mphoneCondition && producttypeCondition == '0' && paymenttypeCondition == '0'
            && !starttimeCondition && !endtimeCondition && !startAmountCondition && !endAmountCondition){
            clearOrderSearchParams();
            return;
        }

        var queryParameter = $('#orderList').datagrid("options").queryParams;
        queryParameter.cidCondition = cidCondition;
        queryParameter.mphoneCondition = mphoneCondition;
        queryParameter.producttypeCondition = producttypeCondition;
        queryParameter.paymenttypeCondition = paymenttypeCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.startAmountCondition = startAmountCondition;
        queryParameter.endAmountCondition = endAmountCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#orderList").datagrid("reload");
    }
    function clearOrderSearchParams(){
        var queryParameter = $('#orderList').datagrid("options").queryParams;
        queryParameter.cidCondition = null;
        queryParameter.mphoneCondition = null;
        queryParameter.producttypeCondition = null;
        queryParameter.paymenttypeCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.startAmountCondition = null;
        queryParameter.endAmountCondition = null;
        queryParameter.queryByParamFlag = null;
        $("#queryOrderParamsForm").form('clear');
        $("#paymenttypeCondition").combobox('setValue','0');
        $("#producttypeCondition").combobox('setValue','0');
        $("#orderList").datagrid("reload");
    }
</script>
<div style="padding:5px 0;">
    <div style="margin:0px auto;width: 950px;">
        <form id="queryOrderParamsForm">
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
                    <td>会员Id:</td>
                    <td><input class="easyui-textbox"  id="cidCondition" data-options="prompt:'会员Id'" name="cidCondition"/></td>
                    <td nowrap="nowrap">手机号码:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'会员手机号码'" id="mphoneCondition" name="mphoneCondition"/></td>
                    <td>支付类型:</td>
                    <td>
                        <select name="paymenttypeCondition" id="paymenttypeCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">余额支付</option>
                            <option value="2">微信支付</option>
                            <option value="3">支付宝支付</option>
                        </select>
                    </td>
                    <td>产品类型:</td>
                    <td>
                        <select name="producttypeCondition" id="producttypeCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">技能包</option>
                            <option value="2">经验包</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>下单时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td>至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                    <td>订单金额:</td>
                    <td>
                        <input class="easyui-textbox"  id="startAmountCondition" data-options="prompt:'金额下限'" name="startAmountCondition"/>
                    </td>
                    <td>至</td>
                    <td>
                        <input class="easyui-textbox"  id="endAmountCondition" data-options="prompt:'金额上限'" name="endAmountCondition"/>
                    </td>
                </tr>
                <tr align="right">
                    <td colspan="8">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchOrderByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearOrderSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="orderList" style="width: auto;height: auto;">
    </table>
</div>