<script>
    function checkCourseForm(){
        if($("#coursename").val().length == 0){
            MsgBox.show("请填写课程名称");
            return false;
        }
        if(!$("#audio").filebox("getValue")){
            MsgBox.show("请选择课程音频");
            return false;
        }
        return true;
    }
    var checkCount = 10;
    function cbInAddCourse(){
        var f = $('#ProductForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCount){
                setTimeout(cbInAddCourse, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealCourseFormBeforeSubmit(){
        var frameId = "CourseForm_iframe", $frame = null;
        var testFrameId = $('#'+frameId);
        if(testFrameId.length>0){
            testFrameId.unbind();
            testFrameId.remove();
        }
        $frame = $('<iframe id='+frameId+' name='+frameId+'></iframe>').appendTo('body');
        $frame.attr('src', window.ActiveXObject ? 'javascript:false' : 'about:blank');
        $frame.css({
            display:"none"
        });
        $frame.bind('load', cbInAddCourse);
        $("#courseForm").attr('target', frameId);
    }
    function actionAfterSubmit(jsonObj){
        var resultObj = JSON.parse(jsonObj);
        if(!resultObj){
            return;
        }
        var code = resultObj.code;
        if(code == '200'){
            var msg = resultObj.msg;
            var pid = resultObj.pid;
            MsgBox.show(msg);
            $('#addCourseDialog').dialog('close');		// close the dialog
            $('#courseList').datagrid('reload');
        }else{
            MsgBox.show("新增课程失败。"+resultObj.msg);
        }
    }
    function submitAddCourse(){
        if(!checkCourseForm()){
            return;
        }
        dealCourseFormBeforeSubmit();
        $("#courseForm").submit();
    }
</script>
<div style="width: 500px;margin: 0 auto;">
<form id="courseForm" action="<%=request.getContextPath()%>/product/saveAddCourse"
      enctype="multipart/form-data" method="post">
    <br/>
    <table cellpadding="5">
        <tr>
            <td colspan="2" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写课程信息</div>
                </div>
            </td>
        </tr>
        <tr>
            <td>名称:<span style="color:red">*</span></td>
            <td><input class="easyui-textbox"  id="coursename" name="coursename"
                       data-options="prompt:'请填写课程名称'" style="width:350px">
                <input type="hidden" id="pidInAddCourse" name="pid" value="<%=request.getAttribute("pid").toString()%>"/>
            </td>
        </tr>
        <tr>
            <td>排序:</td>
            <td>
                <select class="easyui-combobox" name="sort" id="sort" style="width:140px;" style="width:350px">
                    <option value="999">按上架时间排序</option>
                    <option value="1">排序1</option>
                    <option value="2">排序2</option>
                    <option value="3">排序3</option>
                    <option value="4">排序4</option>
                    <option value="5">排序5</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>试学:</td>
            <td><input type="checkbox" id="istry" name="istry" style="width:100px" value="1"/></td>
        </tr>
        <tr>
            <td>音频文件:<span style="color:red">*</span></td>
            <td>
                <input class="easyui-filebox" id="audio" name="audio" style="width:350px" accept="audio/mpeg"
                       data-options="prompt:'请选课程音频文件，支持mp3',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
            </td>
        </tr>
    </table>
</form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddCourse()">保存</a>
    </div>
</div>