<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    $(function(){
        $("#pidInAddCourse").val($("#pidInManageCourse").val());
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getCourseSortData.do" +
            "?pid=" +  $("#pidInAddCourse").val() + "&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                if(!data){
                    $("#isSortDealDone").val("1");
                }else{
                    var arr = data.split(",");
                    var sortSelect = $("#sortSelect");
                    for(var i = 0; i < arr.length; i++){
                        sortSelect.append("<option value='" + arr[i] + "'>排序"+ arr[i] +"</option>");
                    }
                    $.parser.parse($('#sortSelect'));
                    $("#isSortDealDone").val("1");
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
                    if(audioFileSuffixName != ".mp3"){
                        MsgBox.show("音频格式不正确，请选择mp3格式");
                        return false;
                    }
                    return true;
                },
                message:'音频格式不正确，请选择mp3格式'
            },
            imgfile:{
                validator: function (value, param) {
                    var imgFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            }
        });
        $('#coursenameInAddCourse').textbox({
            required: true,
            validType: 'maxLen[15]',
            missingMessage:'最多输入15个字符',
            prompt:'请填写课程名称'
        });
        $("#audioInAddCourse").filebox({
            required:true,
            missingMessage:'支持mp3格式',
            prompt:'请选音频文件',
            validType:'audiofile'
        });
        $("#newscontent1").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            validType:'imgfile',
            prompt:'新闻图片，建议大小【2M】以内'
        });
        $('#newscontent2').textbox({
            required: true,
            validType: 'maxLen[4000]',
            missingMessage:'最多输入4000个字符',
            prompt:'请输入文本'
        });
    });
    function checkCourseForm(){
        if($.trim($("#coursenameInAddCourse").val()).length == 0){
            MsgBox.show("请填写课程名称");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#coursenameInAddCourse").val())) > 15){
            MsgBox.show("课程名称过长，最长15个字符");
            return false;
        }
        if(!$("#audioInAddCourse").filebox("getValue")){
            MsgBox.show("请选择课程音频");
            return false;
        }
        var audioFileName = $("#audioInAddCourse").filebox("getValue");
        var audioSuffixName = audioFileName.substring(audioFileName.lastIndexOf("."));
        if(audioSuffixName != ".mp3"){
            MsgBox.show("音频格式不正确，请选择mp3格式");
            return false;
        }
        var newsContent = $("input[id^='newscontent']");
        var result = true;
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                var domid = domElement.id;
                var dom_type = $("#type_" + domid).val();
                if(!dom_type){
                    result = false;
                    return;
                }
                if(dom_type == '2'){
                    if(!$("#" + domid).filebox("getValue")){
                        MsgBox.show("无法保存，存在图片未选择");
                        result = false;
                        return false;
                    }
                    imgFileName = $("#" + domid).filebox("getValue");
                    imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("无法保存，图片文件，仅支持jpg、png");
                        result = false;
                        return false;
                    }
                }else if(dom_type == '3'){
                    if($.trim($("#" + domid).val()).length == 0){
                        MsgBox.show("无法保存，存在文本未填写");
                        result = false;
                        return false;
                    }
                    if(StringUtil.getCharNumber($("#" + domid).val()) > 4000){
                        MsgBox.show("文本超长，最多输入4000个字符");
                        result = false;
                        return false;
                    }
                }
            });
            return result;
        }else{
            MsgBox.show("介绍内容为空，无法保存");
            return false;
        }
        return true;
    }
    var checkCount = 10;
    function cbInAddCourse(){
        var f = $('#CourseForm_iframe'), data = "";
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
            $('#addCourseDialog').dialog('close');
            $('#courseList').datagrid('reload');
        }else{
            MsgBox.show("新增课程失败，"+resultObj.msg);
        }
    }
    function submitAddCourse(){
        if(!checkCourseForm()){
            return;
        }
        dealCourseFormBeforeSubmit();
        dealSortValue();
        $("#courseForm").submit();
        LoadingMaskLayer.show();
    }
    function dealSortValue(){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                var domid = domElement.id;
                $("#sort_" + domid).val(index + 1);
            });
        }
    }
    function getNextIndex(){
        var lastContent = $("input[id^='newscontent']:last");
        if(lastContent.length > 0){
            var nextIndex = -1;
            lastContent.each(function(index, domElement){
                var lastDomId = domElement.id;
                nextIndex = lastDomId.substring(11);
            });
            return parseInt(nextIndex) + 1;
        }else{
            return 1;
        }
    }
    function addIntroductionImage() {
        var nextIndex = getNextIndex();
        $("#IntroductionTable").append("<tr id='trcontent" + nextIndex + "'><td>图片:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " data-options=\"buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            "  accept='image/jpeg,image/png'  style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td>" +
            "<td>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteContent('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            validType:'imgfile',
            prompt:'新闻图片，建议大小【2M】以内'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addIntroductionText() {
        var nextIndex = getNextIndex();
        $("#IntroductionTable").append("<tr id='trcontent" + nextIndex + "'><td>文本:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-textbox' data-options='multiline:true'" +
            " style='width:700px;height: 120px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td>" +
            "<td>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteContent('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).textbox({
            required: true,
            validType: 'maxLen[4000]',
            missingMessage:'最多输入4000个字符',
            prompt:'请输入文本'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function deleteContent(trcontentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个介绍内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if (r){
                var trcontent = $("#" + trcontentid);
                trcontent.remove();
                dealSortValue();
            }
        });
    }
</script>
<div style="text-align: center;">
    <div style="width:850px;margin: 0 auto;">
        <form id="courseForm" action="<%=request.getContextPath()%>/product/saveAddCourse.do"
              enctype="multipart/form-data" method="post">
            <table cellpadding="5">
                <tr>
                    <td colspan="6" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon">
                            </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写课程信息</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap"  style="text-align: right;">名称:<span style="color:red">*</span></td>
                    <td><input id="coursenameInAddCourse" name="coursename" style="width: 200px;">
                        <input type="hidden" id="pidInAddCourse" name="pid"/>
                    </td>
                    <td nowrap="nowrap" style="text-align: right;">排序:</td>
                    <td>
                        <select id="sortSelect" class="easyui-combobox"  editable="false" name="sort" id="sort" style="width:200px;" style="width:350px">
                            <option value="99" selected>按上架时间排序</option>
                        </select>
                    </td>
                    <td nowrap="nowrap" style="text-align: right;">试学:</td>
                    <td style="text-align: left;"><input type="checkbox" id="istry" name="istry" style="width:200px" value="1"/></td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="text-align: right;">音频文件:<span style="color:red">*</span></td>
                    <td colspan="4">
                        <input id="audioInAddCourse" name="audio" style="width:500px" accept="audio/mpeg"
                               data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                    </td>
                </tr>
            </table>
            <table id="IntroductionTable" cellpadding="5">
                <tr>
                    <td colspan="7" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon"></div>
                            <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                                编辑课程介绍（请点击相应按钮，编辑内容）<span style="color:red">*</span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr id="trcontent1">
                    <td>图片:<span style="color:red">*</span></td>
                    <td colspan="5">
                        <input data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                               accept="image/jpeg,image/png" style="width:700px;" id="newscontent1" name="newscontent1"/>
                        <input type="hidden" id="sort_newscontent1" name="sort_newscontent1"/>
                        <input type="hidden" id="type_newscontent1" name="type_newscontent1" value='2'/>
                    </td>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteContent('trcontent1')">删除</a>
                    </td>
                </tr>
                <tr id="trcontent2">
                    <td>文本:<span style="color:red">*</span></td>
                    <td colspan="5">
                        <input data-options='multiline:true'
                               style="width:700px;height:120px;" id="newscontent2" name="newscontent2"/>
                        <input type="hidden" id="sort_newscontent2" name="sort_newscontent2"/>
                        <input type="hidden" id="type_newscontent2" name="type_newscontent2" value='3'/>
                    </td>
                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteContent('trcontent32')">删除</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style="text-align: center;margin-bottom: 15px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionImage()">新增图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionText()">新增文本</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddCourse()">保存</a>
    </div>
</div>