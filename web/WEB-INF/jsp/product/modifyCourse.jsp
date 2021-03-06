<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    $(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getCourseSortDataInModify.do" +
            "?pid=" + $("#pidInManageCourse").val() + "&courseid=<%=request.getAttribute("courseid").toString()%>&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data) {
                if (!data) {
                    return;
                } else {
                    var jsonObj = JSON.parse(data);
                    if (!jsonObj) {
                        return;
                    }
                    $("#coursenameInModifyCourse").val(jsonObj.coursename);
                    $("#courseidInModifyCourse").val(jsonObj.courseid);
                    $("#pidInModifyCourse").val(jsonObj.pid);
                    if (jsonObj.istry && jsonObj.istry == '1') {
                        $("#istryInModifyCourse").prop("checked", true);
                    } else {
                        $("#istryInModifyCourse").prop("checked", false);
                    }
                    dealSortSelectInModify(jsonObj.sortsdata, jsonObj.sort);
                    $("#filename").val(jsonObj.filename);
                    $("#filesizestr").val(jsonObj.filesizestr);
                }
            }
        });
        $.extend($.fn.validatebox.defaults.rules, {
            maxLen:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber($.trim(value)) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            audiofile:{
                validator: function (value, param) {
                    var audioFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(audioFileSuffixName.toLowerCase() != ".mp3"){
                        MsgBox.show("音频格式不正确，请选择mp3格式");
                        return false;
                    }
                    return true;
                },
                message:'音频格式不正确，请选择mp3格式'
            }
        });
        $('#coursenameInModifyCourse').textbox({
            required: true,
            validType: 'maxLen[15]',
            missingMessage:'最多输入15个字符',
            prompt:'请填写课程名称'
        });
        $("#audioInModifyCourse").filebox({
            required:true,
            missingMessage:'支持mp3格式',
            prompt:'将会覆盖原有音频',
            validType:'audiofile'
        });
    });
    function dealSortSelectInModify(sortsData, sort){
        var arr_new = new Array();
        if(!sortsData){
            arr_new[0] = sort;
        }else{
            var arr = sortsData.split(",");
            arr_new = dealInsertSort(arr, sort);
        }
        var sortSelect = $("#sortSelectInmodify");
        for(var i = 0; i < arr_new.length; i++){
            if(arr_new[i] == '99'){
                continue;
            }
            if(arr_new[i] == sort){
                sortSelect.append("<option value='" + arr_new[i] + "' selected>排序"+ arr_new[i] +"</option>");
            }else{
                sortSelect.append("<option value='" + arr_new[i] + "'>排序"+ arr_new[i] +"</option>");
            }
        }
        $.parser.parse($('#sortSelectInmodify'));
    }
    function dealInsertSort(arr, sort){
        var subScript = 0;
        if(sort < arr[0])
        {
            subScript = 0;
        }else if(sort > arr[arr.length - 1])
        {
            subScript = arr.length;
        }else {
            for(var i=0; i<arr.length; i++)
            {
                if(sort == arr[i])
                {
                    subScript = i;
                }
                if(sort > arr[i] && sort < arr[i+1])
                {
                    subScript = i + 1;
                }
            }
        }
        var arr_new = new Array(arr.length + 1);
        for(var i = 0; i < arr_new.length; i++){
            if(i < subScript)
            {
                arr_new[i] = arr[i];
            }
            if(i == subScript)
            {
                arr_new[i] = sort;
            }
            if(i > subScript)
            {
                arr_new[i] = arr[i-1];
            }
        }
        return arr_new;
    }
    function checkModifyCourseForm(){
        if($.trim($("#coursenameInModifyCourse").val()).length == 0){
            MsgBox.show("请填写课程名称");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#coursenameInModifyCourse").val())) > 15){
            MsgBox.show("课程名称过长，最长15个字符");
            return false;
        }
        if($("#audioInModifyCourse").filebox("getValue")){
            var audioFileName = $("#audioInModifyCourse").filebox("getValue");
            var audioSuffixName = audioFileName.substring(audioFileName.lastIndexOf("."));
            if(audioSuffixName.toLowerCase() != ".mp3"){
                MsgBox.show("音频格式不正确，请选择mp3格式");
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
        LoadingMaskLayer.hide();
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
        LoadingMaskLayer.show();
    }
</script>
<div style="width: 500px;margin: 0 auto;">
    <form id="modifyCourseForm" action="<%=request.getContextPath()%>/product/saveModifyCourse.do"
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
                <td nowrap="nowrap">名称:<span style="color:red">*</span></td>
                <td><input id="coursenameInModifyCourse" name="coursename"
                           data-options="prompt:'请填写课程名称'" style="width:350px">
                    <input type="hidden" id="courseidInModifyCourse" name="courseid" />
                    <input type="hidden" id="pidInModifyCourse" name="pid" />
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">排序:</td>
                <td>
                    <select class="easyui-combobox" name="sort" id="sortSelectInmodify" editable="false" style="width:140px;" style="width:350px">
                        <option value="99">按上架时间排序</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">试学:</td>
                <td><input type="checkbox" id="istryInModifyCourse" name="istry" style="width:100px" value="1"/></td>
            </tr>
            <tr>
                <td nowrap="nowrap" style="text-align: right">原音频名称:</td>
                <td><input class="dzm-noBorder-text" readonly id="filename" name="filename" style="width:350px"></td>
            </tr>
            <tr>
                <td nowrap="nowrap" style="text-align: right">原音频大小:</td>
                <td><input class="dzm-noBorder-text" readonly id="filesizestr" name="filesizestr" style="width:350px"></td>
            </tr>
            <tr>
                <td nowrap="nowrap">音频文件:</td>
                <td>
                    <input id="audioInModifyCourse" name="audio" style="width:350px" accept="audio/mpeg"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyCourse()">保存</a>
    </div>
</div>