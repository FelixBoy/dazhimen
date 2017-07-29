<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %><%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
    function returnManageProductInManageCourse(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage.do?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
    function fwdEditCoursePage(index){
        $("#courseList").datagrid("selectRow", index);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $("#modifyCourseDialog").dialog({
                title:'修改课程信息',
                width: 580,
                height: 380,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyCourseDialog").dialog({
                onClose:function(){
                    $("#modifyCourseDialog").empty();
                }
            });
            $("#modifyCourseDialog").dialog("open");
            $("#modifyCourseDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyCoursePage.do?courseid=" + row.courseid + "&random_id=" + Math.random());
        }
    }
    function saveCourseDel(index){
        $("#courseList").datagrid("selectRow",index);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $.messager.confirm('确认','您确认删除课程【'+ row.coursename + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/product/saveCourseDel.do?courseid=" + row.courseid
                        + "&pid=" + $("#pidInManageCourse").val() + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#courseList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
    function forwardAddCoursePage(){
        $('#addCourseDialog').dialog({
            title: '新增课程',
            href:"<%=request.getContextPath()%>/product/fwdAddCoursePage.do?random_id=" + Math.random(),
            width: 950,
            height: 570,
            closed: true,
            cache: false,
            modal: true
        });
        $("#addCourseDialog").dialog({
            onClose:function(){
                $("#addCourseDialog").empty();
            }
        });
        $('#addCourseDialog').dialog("open");
    }
    function fwdEditCourseIntroductionPage(rowIndex){
        $("#courseList").datagrid("selectRow", rowIndex);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $("#modifyCourseIntroductionDialog").dialog({
                title:'修改课程介绍',
                width: 950,
                height: 570,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyCourseIntroductionDialog").dialog({
                onClose:function(){
                    $("#modifyCourseIntroductionDialog").empty();
                }
            });
            $("#modifyCourseIntroductionDialog").dialog("open");
            $("#modifyCourseIntroductionDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyCourseIntroductionPage.do?courseid=" + row.courseid + "&random_id=" + Math.random());
        }
    }
    function fwdViewCoursePage(rowIndex){
        $("#courseList").datagrid("selectRow", rowIndex);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $("#viewCourseDialog").dialog({
                title:'查看课程信息',
                width: 950,
                height: 570,
                closed: true,
                cache: false,
                modal: true
            });
            $("#viewCourseDialog").dialog({
                onClose:function(){
                    $("#viewCourseDialog").empty();
                }
            });
            $("#viewCourseDialog").dialog("open");
            $("#viewCourseDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdViewCoursePage.do?courseid=" + row.courseid + "&random_id=" + Math.random());
        }
    }
    $(function(){
        $("#viewProductFormInCoursePage").form("load", "<%=request.getContextPath()%>/product/getProductInforById.do" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
        $("#courseList").datagrid({
            title:"课程列表",
            url:"<%=request.getContextPath()%>/product/queryAllCourseByPid.do?pid=<%=request.getAttribute("pid").toString()%>&random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载课程数据...",
            columns: [[
                { field: 'courseid', title: '课程Id', width: '10%'},
                { field: 'coursename', title: '名称', width: '15%'},
                { field: 'sortstr', title: '排序', width: '5%'},
                { field: 'istry', title: '是否试学', width: '10%'},
                { field: 'viewcount', title: '已读人数', width: '10%'},
                { field: 'filename', title: '音频文件名称', width: '15%'},
                { field: 'filesize', title: '大小', width: '10%'},
                {
                    field: "operateID", title: '操作',width:'25%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        <%if(userBean.getLoginname().equals(Constant.defaultAdministrator)){%>
                        return '<a href="javascript:void(0)" onclick="fwdViewCoursePage('+rowIndex+')">查看</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdEditViewCountPage('+rowIndex+')">已读</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdEditCoursePage('+rowIndex+')">修改基本信息</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdEditCourseIntroductionPage('+rowIndex+')">修改介绍</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveCourseDel('+rowIndex+')">删除</a>';
                        <%}else{%>
                        return '<a href="javascript:void(0)" onclick="fwdViewCoursePage('+rowIndex+')">查看</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdEditCoursePage('+rowIndex+')">修改基本信息</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdEditCourseIntroductionPage('+rowIndex+')">修改介绍</a>&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveCourseDel('+rowIndex+')">删除</a>';
                        <%}%>

                    }
                }
            ]],
            pagination: true
        });
        $('#courseList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function fwdEditViewCountPage(index){
        $('#courseList').datagrid('selectRow',index);
        var row = $('#courseList').datagrid('getSelected');
        if (row){
            $('#modifyViewCountDialog').dialog({
                width: 330,
                height: 200,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyViewCountDialog").dialog({
                onClose:function(){
                    $("#modifyViewCountDialog").empty();
                }
            });
            $('#modifyViewCountDialog').dialog("open");
            $("#modifyViewCountDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyViewCountPage.do?random_id=" + Math.random()
                + "&courseid="+row.courseid);
            $("#modifyViewCountDialog").dialog("setTitle", '修改课程【' + row.coursename + '】的已读人数');
        }
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageProductInManageCourse()">返回</a>
</div>
<div style="margin:0px auto;width: 950px">
    <form id="viewProductFormInCoursePage" >
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="8" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">所属产品信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">产品ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="pidInManageCourse" name="pid"></td>
                <td nowrap="nowrap">名称:</td>
                <td><input class="dzm-noBorder-text" readonly id="pname" name="pname"></td>
                <td nowrap="nowrap">类型:</td>
                <td><input class="dzm-noBorder-text" readonly id="type" name="type"></td>
                <td nowrap="nowrap">价格:</td>
                <td><input class="dzm-noBorder-text" readonly id="price" name="price"></td>
            </tr>
        </table>
        </form>
        <br/>
</div>
<div style="padding:5px 0;">
    <div id="modifyCourseDialog" style="text-align: center"></div>
    <div id="addCourseDialog" style="text-align: center"></div>
    <div id="viewCourseDialog" style="text-align: center"></div>
    <div id="modifyCourseIntroductionDialog" style="text-align: center"></div>
    <div id="modifyViewCountDialog"></div>
    <table id="courseList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddCoursePage()">新增课程</a>
</div>