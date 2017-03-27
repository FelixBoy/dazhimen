<script>
    $(function(){
        $("#viewProductFormInCoursePage").form("load", "<%=request.getContextPath()%>/product/getProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function courseListFormatOper(val,row,index){
        return  '<a href="javascript:void(0)" onclick="fwdEditCoursePage('+index+')">修改信息</a>&nbsp&nbsp&nbsp&nbsp&nbsp' +
                '<a href="javascript:void(0)" onclick="saveCourseDel('+index+')">删除</a>';
    }
    function returnManageProduct(){
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
                href: "<%=request.getContextPath()%>/product/fwdModifyCoursePage?courseid=" + row.courseid +
                        "&pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random(),
                modal: true
            });
            $("#modifyCourseDialog").dialog("open");
        }
    }
    function saveCourseDel(index){
        $("#courseList").datagrid("selectRow",index);
        var row = $("#courseList").datagrid("getSelected");
        if(row){
            $.messager.confirm('确认','您确认删除课程【'+ row.coursename + '】吗？',function(r){
                if (r){
                    $.get("<%=request.getContextPath()%>/product/saveCourseDel?courseid=" + row.courseid
                        + "&pid=<%=request.getAttribute("pid").toString()%>&random_id="+Math.random(),
                        function(data){
                            MsgBox.show(data);
                            $('#courseList').datagrid('reload');
                        }
                    );
                }
            });
        }
    }
    function downloadCourseAudio(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function downloadAudioFormatOper(val,row,index){
        return '<a href="#" class="easyui-linkbutton" onclick="downloadCourseAudio('+index+')">下载音频</a>';
    }
    function forwardAddCoursePage(){
        $('#addCourseDialog').dialog({
            title: '新增课程',
            width: 580,
            height: 310,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/product/fwdAddCoursePage?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random(),
            modal: true
        });
        $('#addCourseDialog').dialog("open");
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageProduct()">返回</a>
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
                <td><input class="dzm-noBorder-text" readonly="true" id="pid" name="pid"></td>
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
    <table id="courseList" title="课程列表" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/product/queryAllCourseByPid?pid=<%=request.getAttribute("pid").toString()%>&
           random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'courseid'" width="15%">ID</th>
            <th data-options="field:'coursename'" width="15%">名称</th>
            <th data-options="field:'sort'"  width="15%">首页排名</th>
            <th data-options="field:'istry'"  width="15%">是否试学</th>
            <th data-options="field:'audiourl',hidden:'true'" width="20%">音频url</th>
            <th data-options="field:'downloadaudio',align:'center',formatter:downloadAudioFormatOper" width="15%">音频</th>
            <th data-options="field:'operate',align:'center',formatter:courseListFormatOper" width="25%">操作</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddCoursePage()">新增课程</a>
</div>