<script>
    $(function(){
        $("#modifyCourseForm").form("load",
            "<%=request.getContextPath()%>/product/getCourseInforByCourseid?courseid=<%=request.getAttribute("courseid").toString()%>&random_id="
            + Math.random());
    });
    function checkModifyCourseForm(){
        if($("#coursenameInModifyCourse").val().length == 0){
            MsgBox.show("请填写课程名称");
            return false;
        }
        if($("#audioInModifyCourse").filebox("getValue")){
            var audioFileName = $("#audioInModifyCourse").filebox("getValue");
            var audioSuffixName = audioFileName.substring(audioFileName.lastIndexOf("."));
            if(audioSuffixName != ".mp3"){
                MsgBox.show("音频文件格式错误，仅支持mp3");
                return false;
            }
        }

        return true;
    }
    var checkCount = 10;
    function cbInModifyCourse(){
        var f = $('#ModifyCourseForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCount){
                setTimeout(cbInModifyCourse, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealModifyCourseFormBeforeSubmit(){
        var frameId = "ModifyCourseForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyCourse);
        $("#modifyCourseForm").attr('target', frameId);
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
            $('#modifyCourseDialog').dialog('close');
            $('#courseList').datagrid('reload');
        }else{
            MsgBox.show("修改课程信息失败。"+resultObj.msg);
        }
    }
    function submitModifyCourse(){
        if(!checkModifyCourseForm()){
            return;
        }
        dealModifyCourseFormBeforeSubmit();
        $("#modifyCourseForm").submit();
    }
</script>
<div style="width: 500px;margin: 0 auto;">
    <form id="modifyCourseForm" action="<%=request.getContextPath()%>/product/saveModifyCourse"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改课程信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>名称:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox"  id="coursenameInModifyCourse" name="coursename"
                           data-options="prompt:'请填写课程名称'" style="width:350px">
                    <input type="hidden" id="courseidInModifyCourse" name="courseid" />
                    <input type="hidden" id="pidInModifyCourse" name="pid" />
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
                <td>音频文件:</td>
                <td>
                    <input class="easyui-filebox" id="audioInModifyCourse" name="audio" style="width:350px" accept="audio/mpeg"
                           data-options="prompt:'修改音频文件，将会覆盖原有音频，支持mp3',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyCourse()">保存</a>
    </div>
</div>