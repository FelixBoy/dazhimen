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
                href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
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
        if($("#newstitle").val().length == 0){
            MsgBox.show("请填写新闻标题");
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
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                var domid = domElement.id;
                var dom_type = $("#type_" + domid).val();
                if(!dom_type){
                    return false;
                }
                if(dom_type == '2'){
                    if(!$("#" + domid).filebox("getValue")){
                        MsgBox.show("无法保存，存在内容图片未选择");
                        return false;
                    }
                    imgFileName = $("#" + domid).filebox("getValue");
                    imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
                    if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
                        MsgBox.show("无法保存，内容主图文件，仅支持jpg、png");
                        return false;
                    }
                }else if(dom_type == '1'){
                    if($("#" + domid).val().length == 0){
                        MsgBox.show("无法保存，存在新闻副标题未填写");
                        return false;
                    }
                }else if(dom_type == '3'){
                    if($("#" + domid).val().length == 0){
                        MsgBox.show("无法保存，存在内容文本未填写");
                        return false;
                    }
                }
            });
        }
        return true;
    }
    function submitAddNewsForm(){
        if(!checkAddNewsFormBeforeSubmit()){
            return;
        }
        dealAddNewsFormBeforeSubmit();
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
            " style='width:100%' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='1'>" +
            "</td></tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addNewsImage() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>内容图片:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-filebox' " +
            " data-options=\"prompt:'请选择图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            " style='width:100%' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td></tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function addNewsText() {
        var nextIndex = getNextIndex();
        $("#newsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>内容文本:<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input class='easyui-textbox' data-options='multiline:true'" +
            " style='width:100%;height: 60px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td></tr>");
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValue();
    }
    function returnManageNewsInAddProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
        });
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageNewsInAddProduct()">返回</a>
</div>
<div style="margin:0px auto;width: 900px;text-align: center;">
<form id="addNewsForm" action="<%=request.getContextPath()%>/news/saveAddNews"
      enctype="multipart/form-data" method="post">
    <table cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请选择掌门<span style="color:red">*</span></div>
                </div>
            </td>
        </tr>
        <tr>
            <td nowrap="nowrap">新闻标题:<span style="color:red">*</span></td>
            <td colspan="5"><input class="easyui-textbox" id="newstitle" style="width: 750px;" name="newstitle" /></td>
        </tr>
        <tr>
            <td nowrap="nowrap">列表图片:<span style="color:red">*</span></td>
            <td colspan="2"><input class="easyui-filebox" id="newslistimg" name="newslistimg" style="width:300px" accept="image/jpeg,image/png"
                        data-options="prompt:'用于新闻列表展示，(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/>
            </td>
            <td nowrap="nowrap">新闻主图:<span style="color:red">*</span></td>
            <td colspan="2"><input class="easyui-filebox" id="newsmainimg" name="newsmainimg" style="width:300px" accept="image/jpeg,image/png"
                       data-options="prompt:'用于首页轮播，(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/>
            </td>
        </tr>
    </table>
    <table id="newsContentTable" cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        编辑新闻内容（请点击相应按钮，添加内容）
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>副标题:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-textbox" style="width:750px" id="newscontent1" name="newscontent1"/>
                <input type="hidden" id="sort_newscontent1" name="sort_newscontent1"/>
                <input type="hidden" id="type_newscontent1" name="type_newscontent1" value='1'/>
            </td>
        </tr>
        <tr>
            <td>内容图片:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-filebox" data-options="prompt:'请选择图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                       style="width:100%" id="newscontent2" name="newscontent2"/>
                <input type="hidden" id="sort_newscontent2" name="sort_newscontent2"/>
                <input type="hidden" id="type_newscontent2" name="type_newscontent2" value='2'/>
            </td>
        </tr>
        <tr>
            <td>内容文本:<span style="color:red">*</span></td>
            <td colspan="5">
                <input class="easyui-textbox"  data-options='multiline:true'
                       style="width:100%;height: 60px;" id="newscontent3" name="newscontent3"/>
                <input type="hidden" id="sort_newscontent3" name="sort_newscontent3"/>
                <input type="hidden" id="type_newscontent3" name="type_newscontent3" value='3'/>
            </td>
        </tr>
    </table>
</form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsSubtitle()">添加副标题</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsImage()">添加图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsText()">添加内容</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddNewsForm()">保存</a>
    </div>
</div>

