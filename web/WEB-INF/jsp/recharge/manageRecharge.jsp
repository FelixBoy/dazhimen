<script type="text/javascript">
    $(function () {
        $("#rechargeList").datagrid({
            title:"充值列表",
            url:"<%=request.getContextPath()%>/recharge/queryAllRecharge.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载充值数据...",
            columns: [[
                { field: 'recid', title: '充值Id', width: '10%'},
                { field: 'recamount', title: '充值金额', width: '5%'},
                { field: 'recdatetime', title: '充值时间', width: '15%'},
                { field: 'paymenttype', title: '支付类型', width: '10%'},
                { field: 'transaction_id', title: '支付订单号', width: '20%'},
                { field: 'cid', title: '会员ID', width: '10%'},
                { field: 'cname', title: '会员姓名', width: '10%' },
                { field: 'cnickname', title: '会员昵称', width: '10%' },
                { field: 'mphone', title: '会员手机号码', width: '10%' }
            ]],
            pagination: true
        });
        $('#rechargeList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchRechargeByParams() {
        var cidCondition = $("#cidCondition").val();
        var nicknameCondition = $("#nicknameCondition").val();
        var nameCondition = $("#nameCondition").val();
        var paymenttypeCondition = $("#paymenttypeCondition").val();
        var startAmountCondition = $("#startAmountCondition").val();
        var endAmountCondition = $("#endAmountCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $('#endtimeCondition').datetimebox('getValue');
        if(starttimeCondition && endtimeCondition){
            if(starttimeCondition > endtimeCondition){
                MsgBox.show("起始时间大于结束时间，无法检索");
                return;
            }
        }
        if(startAmountCondition && endAmountCondition){
            if(startAmountCondition > endAmountCondition){
                MsgBox.show("金额下限大于金额上限，无法检索");
                return;
            }
        }
        if(!cidCondition && !nicknameCondition && !nameCondition && paymenttypeCondition == '0'
            && !starttimeCondition && !endtimeCondition && !startAmountCondition && !endAmountCondition){
            clearRechargeSearchParams();
            return;
        }

        var queryParameter = $('#rechargeList').datagrid("options").queryParams;
        queryParameter.cidCondition = cidCondition;
        queryParameter.nicknameCondition = nicknameCondition;
        queryParameter.nameCondition = nameCondition;
        queryParameter.paymenttypeCondition = paymenttypeCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.startAmountCondition = startAmountCondition;
        queryParameter.endAmountCondition = endAmountCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#rechargeList").datagrid("reload");
    }
    function clearRechargeSearchParams(){
        var queryParameter = $('#rechargeList').datagrid("options").queryParams;
        queryParameter.cidCondition = null;
        queryParameter.nicknameCondition = null;
        queryParameter.nameCondition = null;
        queryParameter.paymenttypeCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.startAmountCondition = null;
        queryParameter.endAmountCondition = null;
        queryParameter.queryByParamFlag = null;
        $("#queryRechargeParamsForm").form('clear');
        $("#paymenttypeCondition").combobox('setValue','0');
        $("#rechargeList").datagrid("reload");
    }
</script>
<div style="padding:5px 0;">
    <div style="margin:0px auto;width: 950px;">
        <form id="queryRechargeParamsForm">
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
                    <td nowrap="nowrap">会员Id:</td>
                    <td><input class="easyui-textbox"  id="cidCondition" data-options="prompt:'会员Id'" name="cidCondition"/></td>
                    <td nowrap="nowrap">会员姓名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'会员姓名'" id="nameCondition" name="nameCondition"/></td>
                    <td nowrap="nowrap">会员昵称:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'会员昵称'" id="nicknameCondition" name="nicknameCondition"/></td>
                    <td nowrap="nowrap">支付类型:</td>
                    <td>
                        <select name="paymenttypeCondition" id="paymenttypeCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="2">微信支付</option>
                            <option value="3">支付宝支付</option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td nowrap="nowrap">充值时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td nowrap="nowrap">至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                    <td nowrap="nowrap">充值金额:</td>
                    <td>
                        <input class="easyui-textbox"  id="startAmountCondition" data-options="prompt:'金额下限'" name="startAmountCondition"/>
                    </td>
                    <td nowrap="nowrap">至</td>
                    <td>
                        <input class="easyui-textbox"  id="endAmountCondition" data-options="prompt:'金额上限'" name="endAmountCondition"/>
                    </td>
                </tr>
                <tr align="right">
                    <td colspan="8">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchRechargeByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearRechargeSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="rechargeList" style="width: auto;height: auto;">
    </table>
</div>