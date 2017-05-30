<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
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
            imgfile:{
                validator: function (value, param) {
                    var imgFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            }
        });
        $("#pidInAddIntroductionForm").val($("#pidInManageCourse").val());
        refreshCourseInfor();
    });
    function refreshCourseInfor(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getModifyCIData.do" +
            "?courseid=<%=request.getAttribute("courseid").toString()%>&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                var jsonObj = JSON.parse(data);
                if(!jsonObj){
                    return;
                }
                $("#courseidInModifyCI").val(jsonObj.courseid);
                $("#coursenameInModifyCI").val(jsonObj.coursename);
                $("#sortInModifyCI").val(jsonObj.sort);
                $("#istryInModifyCI").val(jsonObj.istry);
                $("#filenameInModifyCI").val(jsonObj.filename);
                $("#filesizestrInModifyCI").val(jsonObj.filesizestr);
                $("#IntroductionTable").empty();
                $("#IntroductionTable").append("<tr><td colspan='7' >" +
                    "<div class='formTitle' style='background-color:#f2f2f2;'>" +
                    "<div class='formTitle-icon'></div>" +
                    "<div class='formTitle-text' style='font-weight:bold;text-decoration:none;font-style:normal;text-align:left;'>"+
                    "修改课程介绍（请点击相应按钮，编辑内容）<span style='color:red'>*</span>"+
                    "</div>"+
                    "</div>"+
                    "</td></tr>");
                $.parser.parse($("#IntroductionTable"));
                var newsContentArr = jsonObj.newscontent;
                if(!newsContentArr){
                    return;
                }
                for(var i = 0; i < newsContentArr.length; i++){
                    if(newsContentArr[i].contenttype == '2'){
                        $("#IntroductionTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>图片:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><img width='120px' height='60px'  id='img_newscontent" + (i+1) +"'/>" +
                            "<input type='hidden' id='newscontent" + (i+1) +"'/>"+
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"openModifyCUImgDialog('" + (i+1) +"','" + newsContentArr[i].contentid + "')\">修改图片</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteCIImg('" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#img_newscontent" + (i+1) +"").attr("src", newsContentArr[i].contentvalue + "?rondomid=" + Math.random());
                    }
                    if(newsContentArr[i].contenttype == '3'){
                        $("#IntroductionTable").append("<tr id='trcontent" + (i+1) + "'> " +
                            "<td nowrap='nowrap'>文本:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><form id='textform" + (i+1) +"' enctype='multipart/form-data' method='post'>" +
                            "<input data-options='multiline:true'" +
                            " style='width:640px;height: 120px;' id='newscontent" + (i+1) +"' name='text'/>" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "<input type='hidden' name='courseid" + "' value='" + $("#courseidInModifyCI").val() + "'/>" +
                            "<input type='hidden' name='contentid" + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "</from></td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"modifyCIText('" + (i+1) + "','" + newsContentArr[i].contentid + "')\">保存修改</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteCIText('" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#newscontent" + (i+1) +"").textbox({
                            required: true,
                            validType: 'maxLen[4000]',
                            missingMessage:'最多输入4000个字符',
                            prompt:'请输入文本',
                            value:newsContentArr[i].contentvalue
                        });
                    }
                }
                $.parser.parse($("#IntroductionTable"));
            }
        });
    }
    function openModifyCUImgDialog(index, contentid){
        $('#modifyCIImgDialog').dialog({
            title: '修改图片',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyCIImgDialog").dialog({
            onClose:function(){
                $("#modifyCIImgDialog").empty();
            }
        });
        $('#modifyCIImgDialog').dialog("open");
        $("#modifyCIImgDialog").dialog("refresh",
            "<%=request.getContextPath()%>/product/fwdModifyCIImgPage.do?courseid=" + $("#courseidInModifyCI").val()
            +"&contentid=" + contentid
            +"&pid=" + $("#pidInManageCourse").val()
            + "&random_id=" + Math.random());
    }
    function deleteCIImg(contentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if(r){
                $.ajax({
                    url: "<%=request.getContextPath()%>/product/deleteCIImg.do?courseid=" + $("#courseidInModifyCI").val()
                    +"&contentid=" + contentid
                    +"&pid=" + $("#pidInManageCourse").val()
                    + "&random_id=" + Math.random(),
                    type: 'get',
                    async: false,
                    error: function (data) {
                        MsgBox.show(data.responseText);
                    },
                    success: function (data) {
                        MsgBox.show(data);
                        refreshCourseInfor();
                    }
                });
            }
        });
    }
    function modifyCIText(index, contentid){
        if($.trim($("#newscontent" + index).val()).length == 0){
            MsgBox.show("文本不能为空");
            return;
        }
        if(StringUtil.getCharNumber($("#newscontent" + index).val()) > 4000){
            MsgBox.show("文本超长，最多输入4000个字符");
            return;
        }
        $.ajax({
            type: "POST",
            url:"<%=request.getContextPath()%>/product/modifyCIText.do",
            data:$("#textform" + index).serialize(),
            async: false,
            error: function(request) {
                MsgBox.show(request.responseText);
            },
            success: function(data) {
                MsgBox.show(data);
                refreshCourseInfor();
            }
        });
    }
    function deleteCIText(contentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if(r){
                $.ajax({
                    url: "<%=request.getContextPath()%>/product/deleteCIText.do?courseid=" + $("#courseidInModifyCI").val()
                    +"&contentid=" + contentid
                    +"&pid=" + $("#pidInManageCourse").val()
                    + "&random_id=" + Math.random(),
                    type: 'get',
                    async: false,
                    error: function (data) {
                        MsgBox.show(data.responseText);
                    },
                    success: function (data) {
                        MsgBox.show(data);
                        refreshCourseInfor();
                    }
                });
            }
        });
    }
    function getNextIndexInModify(){
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
    function dealSortValueInModify(){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                var domid = domElement.id;
                $("#sort_" + domid).val(index + 1);
            });
        }
    }
    function addIntroductionImage() {
        var nextIndex = getNextIndexInModify();
        $("#addIntroductionTable").append("<tr id='trcontent" + nextIndex + "'><td nowrap='nowrap'>图片(新增):<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " data-options=\"buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            "  accept='image/jpeg,image/png'  style='width:650px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td>" +
            "<td nowrap='nowrap'>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteCIContentInModify('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            validType:'imgfile',
            prompt:'新闻图片，建议大小【2M】以内'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValueInModify();
    }
    function addIntroductionText() {
        var nextIndex = getNextIndexInModify();
        $("#addIntroductionTable").append("<tr id='trcontent" + nextIndex + "'><td>文本(新增):<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input data-options='multiline:true'" +
            " style='width:650px;height: 120px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td>" +
            "<td>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteCIContentInModify('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).textbox({
            required: true,
            validType: 'maxLen[4000]',
            missingMessage:'最多输入4000个字符',
            prompt:'请输入文本'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValueInModify();
    }
    function deleteCIContentInModify(trcontentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个新闻内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if (r){
                var trcontent = $("#" + trcontentid);
                trcontent.remove();
                dealSortValueInModify();
            }
        });
    }
    var checkCountInModifyCI = 10;
    function cbInModifyCI(){
        var f = $('#addIntroductionFormInModify_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyCI){
                setTimeout(cbInModifyCI, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealAddIntroductionFormInModifyBeforeSubmit(){
        var frameId = "addIntroductionFormInModify_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyCI);
        $("#addIntroductionForm").attr('target', frameId);
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
            MsgBox.show(msg);
            $("#addIntroductionTable").empty();
            refreshCourseInfor();
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function checkModifyCIFormBeforeSubmit(){
        var addIntroductionTable = $("#addIntroductionTable");
        var newsContent = addIntroductionTable.find("input[id^='newscontent']");
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
                    if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
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
        }else{
            return false;
        }
        return result;
    }
    function submitAddCI(){
        if(!checkModifyCIFormBeforeSubmit()){
            return;
        }
        dealAddIntroductionFormInModifyBeforeSubmit();
        dealSortValueInModify();
        $("#addIntroductionForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div id="modifyCIImgDialog"></div>
<div style="text-align: center;">
    <div style="width:850px;margin: 0 auto;">
            <table cellpadding="5">
                <tr>
                    <td colspan="6" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon">
                            </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">课程基本信息</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap"  style="text-align: right;">名称:</td>
                    <td><input class="dzm-noBorder-text" id="coursenameInModifyCI" name="coursename" style="width: 194px;">
                        <input type="hidden" id="courseidInModifyCI" name="courseid"/>
                    </td>
                    <td nowrap="nowrap" style="text-align: right;">排序:</td>
                    <td><input class="dzm-noBorder-text" readonly  id="sortInModifyCI" name="sort" style="width:194px"/></td>
                    <td nowrap="nowrap" style="text-align: right;">试学:</td>
                    <td style="text-align: left;"><input class="dzm-noBorder-text" readonly  id="istryInModifyCI" name="istry" style="width:194px"/></td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="text-align: right">音频名称:</td>
                    <td ><input class="dzm-noBorder-text" readonly id="filenameInModifyCI" name="filename" style="width:194px"></td>
                    <td nowrap="nowrap" style="text-align: right">音频大小:</td>
                    <td ><input class="dzm-noBorder-text" readonly id="filesizestrInModifyCI" name="filesizestr" style="width:194px"></td>
                </tr>
            </table>
            <table id="IntroductionTable" cellpadding="5">
            </table>
        <form id="addIntroductionForm" action="<%=request.getContextPath()%>/product/saveAddCI.do"
              enctype="multipart/form-data" method="post">
            <input type="hidden" name="courseid" id="courseidInAddIntroductionForm" value="<%=request.getAttribute("courseid").toString()%>"/>
            <input type="hidden" name="pid" id="pidInAddIntroductionForm" />
            <table id="addIntroductionTable" cellpadding="5">
            </table>
        </form>
    </div>
    <div style="text-align: center;margin-bottom: 15px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionImage()">新增图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionText()">新增文本</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddCI()">保存</a>
    </div>
</div>
