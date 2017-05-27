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
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            }
        });
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
</script>
<div id="modifyCIImgDialog"></div>
<div style="text-align: center;">
    <div style="width:850px;margin: 0 auto;">
        <form id="courseForm" action="<%=request.getContextPath()%>/product/saveAddCourse.do"
              enctype="multipart/form-data" method="post">
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
        </form>
    </div>
    <div style="text-align: center;margin-bottom: 15px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionImage()">新增图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addIntroductionText()">新增文本</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddCourse()">保存</a>
    </div>
</div>
