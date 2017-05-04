<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %><%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script type="text/javascript">
    function forwardAddAdminPage(){
        $('#addAdminDialog').dialog({
            title: '新增管理员',
            width: 500,
            height: 420,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdAddAdminPage.do",
            modal: true
        });
        $("#addAdminDialog").dialog({
            onClose:function(){
                $("#addAdminDialog").empty();
            }
        });
        $('#addAdminDialog').dialog("open");
    }
    function fwdModifyAdminPage(index){
        $('#adminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#adminList').datagrid('getSelected');
        if (row){
            $('#modifyAdminDialog').dialog({
                title: '修改管理员信息',
                width: 500,
                height: 420,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyAdminDialog").dialog({
                onClose:function(){
                    $("#modifyAdminDialog").empty();
                }
            });
            $('#modifyAdminDialog').dialog("open");
            $("#modifyAdminDialog").dialog("refresh", "<%=request.getContextPath()%>/user/fwdModifyAdminPage.do?uid="+row.uid);
        }
    }
    function saveDeleteAdmin(index){
        $('#adminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#adminList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除管理员【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveDeleteAdmin.do?uid=" + row.uid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#adminList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    function formatOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="fwdModifyAdminPage('+index+')">修改</a>&nbsp&nbsp' +
            '<a href="javascript:void(0)" onclick="saveDeleteAdmin('+index+')">删除</a>';
    }
    $(function () {
        $("#adminList").datagrid({
            title:"管理员列表",
            url:"<%=request.getContextPath()%>/user/queryAllAdmin.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载管理员数据...",
            columns: [[
                { field: 'uid', title: '管理员Id', width: '10%'},
                { field: 'name', title: '姓名', width: '10%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'loginname', title: '登录名', width: '10%'},
                { field: 'gender', title: '性别', width: '5%'},
                { field: 'remarks', title: '介绍', width: '20%' },
                { field: 'createDatestr', title: '创建时间', width: '15%' },
                {
                    field: "operateID", title: '操作',width:'20%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {

                        <%if(userBean.getLoginname().equals(Constant.defaultAdministrator)){%>
                        return '<a href="javascript:void(0)" onclick="saveResetAdminPassword('+rowIndex+')">重置密码</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdModifyAdminPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveDeleteAdmin('+rowIndex+')">删除</a>';
                        <%}else{%>
                        return '<a href="javascript:void(0)" onclick="fwdModifyAdminPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveDeleteAdmin('+rowIndex+')">删除</a>';
                        <%}%>
                    }
                }
            ]],
            pagination: true
        });
        $('#adminList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchAdminByParams() {
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
            clearAdminSearchParams();
            return;
        }

        var queryParameter = $('#adminList').datagrid("options").queryParams;
        queryParameter.uidCondition = uidCondition;
        queryParameter.mphoneCondition = mphoneCondition;
        queryParameter.nameCondition = nameCondition;
        queryParameter.loginnameCondition = loginnameCondition;
        queryParameter.genderCondition = genderCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.queryByParamFlag = Math.random();
        $("#adminList").datagrid("reload");
    }
    function clearAdminSearchParams(){
        var queryParameter = $('#adminList').datagrid("options").queryParams;
        queryParameter.uidCondition = null;
        queryParameter.mphoneCondition = null;
        queryParameter.nameCondition = null;
        queryParameter.loginnameCondition = null;
        queryParameter.genderCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.queryByParamFlag = Math.random();
        $("#queryAdminParamsForm").form('clear');
        $("#genderCondition").combobox('setValue','0');
        $("#adminList").datagrid("reload");
    }
    function saveResetAdminPassword(index){
        $('#adminList').datagrid('selectRow',index);
        var row = $('#adminList').datagrid('getSelected');
        if(row){
            $.messager.confirm('提示信息', '确定要重置[' + row.name +']密码为123456', function(r){
                if (r){
                    var md5Pw = $.md5("123456");
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
<div style="padding:5px 0;">
    <div id="addAdminDialog" style="text-align: center;"></div>
    <div id="modifyAdminDialog" style="text-align: center;"></div>
    <div style="margin:0px auto;width: 950px;">
        <form id="queryAdminParamsForm">
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
                    <td  nowrap="nowrap">管理员Id:</td>
                    <td><input class="easyui-textbox"  id="uidCondition" data-options="prompt:'管理员Id'" name="uidCondition"/></td>
                    <td nowrap="nowrap">姓名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'管理员姓名'" id="nameCondition" name="nameCondition"/></td>
                    <td nowrap="nowrap">手机号码:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'管理员手机号码'" id="mphoneCondition" name="mphoneCondition"/></td>
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
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="adminList" style="width: auto;height: auto;"></table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddAdminPage()">新增管理员</a>
</div>