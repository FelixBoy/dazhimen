<script>
    function returnManageProductInManageCourse(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage?random_id="+Math.random(),
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
                height: 310,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyCourseDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyCoursePage?courseid=" + row.courseid + "&random_id=" + Math.random());
            $("#modifyCourseDialog").dialog("open");
        }
    }
    function saveCourseDel(index){
        $("#courseList").datagrid("selectRow",index);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $.messager.confirm('确认','您确认删除课程【'+ row.coursename + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/product/saveCourseDel?courseid=" + row.courseid
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
    function downloadCourseAudio(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function forwardAddCoursePage(){
        $('#addCourseDialog').dialog({
            title: '新增课程',
            width: 580,
            height: 310,
            closed: true,
            cache: false,
            modal: true
        });
        $("#addCourseDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdAddCoursePage?random_id=" + Math.random());
        $('#addCourseDialog').dialog("open");
    }
    $(function(){
        $("#viewProductFormInCoursePage").form("load", "<%=request.getContextPath()%>/product/getProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
        $("#courseList").datagrid({
            title:"课程列表",
            url:"<%=request.getContextPath()%>/product/queryAllCourseByPid?pid=<%=request.getAttribute("pid").toString()%>&random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载课程数据...",
            columns: [[
                { field: 'courseid', title: '课程Id', width: '15%'},
                { field: 'coursename', title: '名称', width: '15%'},
                { field: 'sort', title: '首页排名', width: '15%'},
                { field: 'istry', title: '是否试学', width: '15%'},
                { field: 'audiourl',hidden:'true', title: '音频url'},
                {
                    field: "downloadaudio", title: '音频',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="#" class="easyui-linkbutton" onclick="downloadCourseAudio('+rowIndex+')">下载音频</a>';
                    }
                },
                {
                    field: "operateID", title: '操作',width:'25%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return  '<a href="javascript:void(0)" onclick="fwdEditCoursePage('+rowIndex+')">修改信息</a>&nbsp&nbsp&nbsp&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveCourseDel('+rowIndex+')">删除</a>';
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
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageProductInManageCourse()">返回</a>
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
                <td>产品ID:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="pidInManageCourse" name="pid"></td>
                <td>名称:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="pname" name="pname"></td>
                <td>类型:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="type" name="type"></td>
                <td width="50px">价格:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="price" name="price"></td>
            </tr>
        </table>
        </form>
        <br/>
</div>
<div style="padding:5px 0;">
    <div id="modifyCourseDialog" style="text-align: center"></div>
    <div id="addCourseDialog" style="text-align: center"></div>
    <table id="courseList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddCoursePage()">新增课程</a>
</div>