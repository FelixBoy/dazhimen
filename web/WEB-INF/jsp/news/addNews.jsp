<script>
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
        if(StringUtil.getBinaryLength($("#newstitle").val()) > 150){
            MsgBox.show("新闻标题过长，无法保存");
            return false;
        }
        if(!$("#newslistimg").filebox("getValue")){
            MsgBox.show("请选择列表图片");
            return false;
        }
        var imgFileName = $("#newslistimg").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("列表图片文件，仅支持jpg、png");
            return false;
        }
        if(!$("#newsmainimg").filebox("getValue")){
            MsgBox.show("请选择新闻主图");
            return false;
        }
        imgFileName = $("#newsmainimg").filebox("getValue");
        imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
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
                        return;
                    }
                    imgFileName = $("#" + domid).filebox("getValue");
                    imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("无法保存，图片文件，仅支持jpg、png");
                        result = false;
                        return;
                    }
                }else if(dom_type == '1'){
                    if($.trim($("#" + domid).val()).length == 0){
                        MsgBox.show("无法保存，存在副标题未填写");
                        result = false;
                        return;
                    }
                }else if(dom_type == '3'){
                    if($.trim($("#" + domid).val()).length == 0){
                        MsgBox.show("无法保存，存在文本未填写");
                        result = false;
                        return;
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
            "<td colspan='5'><input class='easyui-textbox' " +
            " style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='1'>" +
            "</td>" +
            "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addNewsImage() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>图片:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-filebox' " +
            " data-options=\"prompt:'请选择图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            "  accept='image/jpeg,image/png'  style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td>" +
            "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addNewsText() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>文本:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-textbox' data-options='multiline:true'" +
            " style='width:700px;height: 60px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td>" +
             "<td>" +
                "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                "onclick=\"deleteNewsContent('trcontent" + nextIndex +"')\">删除</a>" +
              "</td>" +
            "</tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function returnManageNewsInAddNews(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
        });
    }
    function deleteNewsContent(trcontentid){
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if (r){
                var trcontent = $("#" + trcontentid);
                trcontent.remove();
                dealSortValue();
            }
        });
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
                <input class="easyui-textbox" style="width:750px" id="newstitle" name="newstitle"/>
            </td>
        </tr>
        <tr>
            <td>列表图片:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-filebox" data-options="prompt:'用于新闻列表展示，(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                       accept="image/jpeg,image/png" style="width:100%" id="newslistimg" name="newslistimg"/>
            </td>
        </tr>
        <tr>
            <td>新闻主图:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-filebox" data-options="prompt:'用于首页轮播，(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"
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
                        编辑新闻内容（请点击相应按钮，编辑内容）
                    </div>
                </div>
            </td>
        </tr>
        <tr id="trcontent1">
            <td >副标题:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-textbox" style="width:700px;" id="newscontent1" name="newscontent1"/>
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
                <input class="easyui-filebox" data-options="prompt:'请选择图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"
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
                <input class="easyui-textbox"  data-options='multiline:true'
                       style="width:700px;height: 60px;" id="newscontent3" name="newscontent3"/>
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

