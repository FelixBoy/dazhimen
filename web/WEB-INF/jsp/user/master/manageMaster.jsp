<%@ page import="util.Constant" %>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script type="text/javascript">
    function forwardMasterAddPage(){
        $('#masterAddDialog').dialog({
            title: '新增掌门',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdMasterAddPage.do?random_id=" + Math.random(),
            modal: true
        });
        $('#masterAddDialog').dialog("open");
    }
    function fwdViewMasterPage(index){
        $('#masterList').datagrid('selectRow',index);// 关键在这里
        var row = $('#masterList').datagrid('getSelected');
        if (row) {
            $('#viewMasterDialog').dialog({
                title: '查看掌门详情',
                width: 580,
                height: 500,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdViewMasterPage.do?uid=" + row.uid + "&random_id=" + Math.random(),
                modal: true
            });
            $('#viewMasterDialog').dialog("open");
        }
    }
    function fwdMasterEditPage(index){
        $('#masterList').datagrid('selectRow',index);
        var row = $('#masterList').datagrid('getSelected');
        if (row){
            $('#masterModifyDialog').dialog({
                title: '修改掌门信息',
                width: 580,
                height: 600,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdMasterModifyPage.do?uid=" + row.uid + "&random_id=" + Math.random(),
                modal: true
            });
            $('#masterModifyDialog').dialog("open");
        }
    }
    function saveMasterDel(index){
        $('#masterList').datagrid('selectRow',index);
        var row = $('#masterList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除掌门【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveMasterDel.do?uid=" + row.uid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#masterList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    $(function () {
        $("#masterList").datagrid({
            title:"掌门列表",
            url:"<%=request.getContextPath()%>/user/queryAllMasters.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载掌门数据...",
            columns: [[
                { field: 'uid', title: '掌门Id', width: '10%'},
                { field: 'name', title: '姓名', width: '10%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '5%'},
                { field: 'introduction', title: '介绍', width: '20%' },
                { field: 'createDatestr', title: '创建时间',width: '15%' },
                {
                    field: "operateID", title: '操作',width:'20%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        <%if(userBean.getLoginname().equals(Constant.defaultAdministrator)){%>
                            return '<a href="javascript:void(0)" onclick="saveResetMasterPassword('+rowIndex+')">重置密码</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdViewMasterPage('+rowIndex+')">查看</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdMasterEditPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveMasterDel('+rowIndex+')">删除</a>';
                        <%}else{%>
                        return '<a href="javascript:void(0)" onclick="fwdViewMasterPage('+rowIndex+')">查看</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdMasterEditPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveMasterDel('+rowIndex+')">删除</a>';
                        <%}%>
                    }
                }
            ]],
            pagination: true
        });
        $('#masterList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchMasterByParams() {
        var uidCondition = $("#uidCondition").val();
        var mphoneCondition = $("#mphoneCondition").val();
        var nameCondition = $("#nameCondition").val();
        var loginnameCondition = $("#loginnameCondition").val();
        var genderCondition = $("#genderCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $('#endtimeCondition').datetimebox('getValue');
        if(starttimeCondition && endtimeCondition){
            if(starttimeCondition > endtimeCondition){
                MsgBox.show("起始时间大于结束时间，无法检索");
                return;
            }
        }
        if(!uidCondition && !mphoneCondition && !nameCondition && !loginnameCondition
            && genderCondition == '0' && !starttimeCondition && !endtimeCondition){
            clearMasterSearchParams();
            return;
        }

        var queryParameter = $('#masterList').datagrid("options").queryParams;
        queryParameter.uidCondition = uidCondition;
        queryParameter.mphoneCondition = mphoneCondition;
        queryParameter.nameCondition = nameCondition;
        queryParameter.loginnameCondition = loginnameCondition;
        queryParameter.genderCondition = genderCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#masterList").datagrid("reload");
    }
    function clearMasterSearchParams(){
        var queryParameter = $('#masterList').datagrid("options").queryParams;
        queryParameter.uidCondition = null;
        queryParameter.mphoneCondition = null;
        queryParameter.nameCondition = null;
        queryParameter.loginnameCondition = null;
        queryParameter.genderCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.queryByParamFlag = Math.random();
        $("#queryMasterParamsForm").form('clear');
        $("#genderCondition").combobox('setValue','0');
        $("#masterList").datagrid("reload");
    }
    function saveResetMasterPassword(index){
        $('#masterList').datagrid('selectRow',index);
        var row = $('#masterList').datagrid('getSelected');
        if(row){
            $.messager.confirm('提示信息', '确定要重置[' + row.name +']密码为123456', function(r){
                if (r){
                    var md5Pw = $.md5(row.loginname + '123456');
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveResetUserPassword.do?uid=" + row.uid + "&password=" + md5Pw + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                        }
                    });
                }
            });


        }
    }
</script>
<div style="padding:2px 0;">
    <div id="viewMasterDialog" style="text-align: center;"></div>
    <div id="masterAddDialog" style="text-align: center;"></div>
    <div id="masterModifyDialog" style="text-align: center;"></div>
    <div style="margin:0px auto;width: 950px;">
        <form id="queryMasterParamsForm">
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
                    <td nowrap="nowrap">掌门Id:</td>
                    <td><input class="easyui-textbox"  id="uidCondition" data-options="prompt:'掌门Id'" name="uidCondition"/></td>
                    <td nowrap="nowrap">姓名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'掌门姓名'" id="nameCondition" name="nameCondition"/></td>
                    <td nowrap="nowrap">手机号码:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'掌门手机号码'" id="mphoneCondition" name="mphoneCondition"/></td>
                    <td nowrap="nowrap">登录名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'登录名'" id="loginnameCondition" name="loginnameCondition"/></td>
                </tr>
                <tr>
                    <td nowrap="nowrap">性别:</td>
                    <td>
                        <select name="genderCondition" id="genderCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </td>
                    <td nowrap="nowrap">创建时间:</td>
                    <td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td nowrap="nowrap">至</td>
                    <td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>
                    <td align="right" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchMasterByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearMasterSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="masterList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardMasterAddPage()">新增掌门</a>
</div>
