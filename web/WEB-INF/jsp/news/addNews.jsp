<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
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
        $('#newstitle').textbox({
            required: true,
            validType: 'maxLen[80]',
            missingMessage:'最多输入80个字符',
            prompt:'请输入新闻标题'
        });
        $("#newslistimg").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'用于新闻列表展示，建议大小【2M】以内',
            validType:'imgfile'
        });
        $("#newsmainimg").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'用于首页轮播，建议大小【2M】以内',
            validType:'imgfile'
        });
        $('#newscontent1').textbox({
            required: true,
            validType: 'maxLen[80]',
            missingMessage:'最多输入80个字符',
            prompt:'请输入副标题'
        });
        $("#newscontent2").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            validType:'imgfile',
            prompt:'新闻图片，建议大小【2M】以内'
        });
        $('#newscontent3').textbox({
            required: true,
            validType: 'maxLen[4000]',
            missingMessage:'最多输入4000个字符',
            prompt:'请输入文本'
        });
    });
    var checkCount = 10;
    function cbInAddNews(){
        var f = $('#addNewsForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCount){
                setTimeout(cbInAddNews, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
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
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
            });
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealAddNewsFormBeforeSubmit(){
        var frameId = "addNewsForm_iframe", $frame = null;
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
        $frame.bind('load', cbInAddNews);
        $("#addNewsForm").attr('target', frameId);
    }
    function checkAddNewsFormBeforeSubmit(){
        if($.trim($("#newstitle").val()).length == 0){
            MsgBox.show("请填写新闻标题");
            return false;
        }
        if(StringUtil.getCharNumber($("#newstitle").val()) > 80){
            MsgBox.show("新闻标题过长，最长80个字符");
            return false;
        }
        if(!$("#newslistimg").filebox("getValue")){
            MsgBox.show("请选择列表图片");
            return false;
        }
        var imgFileName = $("#newslistimg").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
            MsgBox.show("列表图片文件，仅支持jpg、png");
            return false;
        }
        if(!$("#newsmainimg").filebox("getValue")){
            MsgBox.show("请选择新闻主图");
            return false;
        }
        imgFileName = $("#newsmainimg").filebox("getValue");
        imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
            MsgBox.show("新闻主图文件，仅支持jpg、png");
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
                    if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
                        MsgBox.show("无法保存，图片文件，仅支持jpg、png");
                        result = false;
                        return false;
                    }
                }else if(dom_type == '1'){
                    if($.trim($("#" + domid).val()).length == 0){
                        MsgBox.show("无法保存，存在副标题未填写");
                        result = false;
                        return false;
                    }
                    if(StringUtil.getCharNumber($("#" + domid).val()) > 80){
                        MsgBox.show("副标题超长，最多输入80个字符");
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
            MsgBox.show("新闻内容为空，无法保存");
            return false;
        }
        return true;
    }
    function submitAddNewsForm(){
        if(!checkAddNewsFormBeforeSubmit()){
            return;
        }
        dealAddNewsFormBeforeSubmit();
        dealSortValue();
        $("#addNewsForm").submit();
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
    function addNewsSubtitle(){
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>副标题:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='1'>" +
            "</td>" +
            "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).textbox({
            required: true,
            validType: 'maxLen[80]',
            missingMessage:'最多输入80个字符',
            prompt:'请输入副标题'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addNewsImage() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>图片:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " data-options=\"buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            "  accept='image/jpeg,image/png'  style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td>" +
            "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
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
    function addNewsText() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>文本:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-textbox' data-options='multiline:true'" +
            " style='width:700px;height: 120px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td>" +
             "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
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
    function returnManageNewsInAddNews(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
        });
    }
    function deleteNewsContent(trcontentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个新闻内容");
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
    function testText(){
        alert($("#newscontent3").val());
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInAddNews()">返回</a>
</div>
<div style="margin:0px auto;width: 900px;text-align: center;">
<form id="addNewsForm" action="<%=request.getContextPath()%>/news/saveAddNews.do"
      enctype="multipart/form-data" method="post">
    <table id="newsTitleTable" cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        请填写新闻标题
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>新闻标题:<span style="color:red">*</span></td>
            <td colspan="5">
                <input style="width:750px" id="newstitle" name="newstitle"/>
            </td>
        </tr>
        <tr>
            <td>列表图片:<span style="color:red">*</span></td>
            <td colspan="5">
                <input data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                       accept="image/jpeg,image/png" style="width:100%" id="newslistimg" name="newslistimg"/>
            </td>
        </tr>
        <tr>
            <td>新闻主图:<span style="color:red">*</span></td>
            <td colspan="5">
                <input data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                       accept="image/jpeg,image/png" style="width:100%" id="newsmainimg" name="newsmainimg"/>
            </td>
        </tr>
    </table>
    <table id="newsContentTable" cellpadding="5">
        <tr>
            <td colspan="7" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        编辑新闻内容（请点击相应按钮，编辑内容）<span style="color:red">*</span>
                    </div>
                </div>
            </td>
        </tr>
        <tr id="trcontent1">
            <td >副标题:<span style="color:red">*</span></td>
            <td colspan="5">
                <input style="width:700px;" id="newscontent1" name="newscontent1"/>
                <input type="hidden" id="sort_newscontent1" name="sort_newscontent1"/>
                <input type="hidden" id="type_newscontent1" name="type_newscontent1" value='1'/>
            </td>
            <td>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteNewsContent('trcontent1')">删除</a>
            </td>
        </tr>
        <tr id="trcontent2">
            <td>图片:<span style="color:red">*</span></td>
            <td colspan="5">
                <input data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                       accept="image/jpeg,image/png" style="width:700px;" id="newscontent2" name="newscontent2"/>
                <input type="hidden" id="sort_newscontent2" name="sort_newscontent2"/>
                <input type="hidden" id="type_newscontent2" name="type_newscontent2" value='2'/>
            </td>
            <td>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteNewsContent('trcontent2')">删除</a>
            </td>
        </tr>
        <tr id="trcontent3">
            <td>文本:<span style="color:red">*</span></td>
            <td colspan="5">
                <input data-options='multiline:true'
                       style="width:700px;height:120px;" id="newscontent3" name="newscontent3"/>
                <input type="hidden" id="sort_newscontent3" name="sort_newscontent3"/>
                <input type="hidden" id="type_newscontent3" name="type_newscontent3" value='3'/>
            </td>
            <td>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteNewsContent('trcontent3')">删除</a>
            </td>
        </tr>
    </table>
</form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsSubtitle()">新增副标题</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsImage()">新增图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsText()">新增文本</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddNewsForm()">保存</a>
    </div>
</div>

