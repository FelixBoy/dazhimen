<script type="text/javascript">
    function returnManageNewsInModifyNewsContent(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
        });
    }
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
        refreshNewsContent();
    });
    function refreshNewsContent(){
        $.ajax({
            url:"<%=request.getContextPath()%>/news/getModifyNewsContentData.do" +
            "?nid=<%=request.getAttribute("nid").toString()%>&random_id=" + Math.random(),
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
                $("#newstitleInModifyNewsContent").val(jsonObj.title);
                $("#modifyNewsContentTable").empty();
                $("#modifyNewsContentTable").append("<tr><td colspan='7' >" +
                    "<div class='formTitle' style='background-color:#f2f2f2;'>" +
                    "<div class='formTitle-icon'></div>" +
                    "<div class='formTitle-text' style='font-weight:bold;text-decoration:none;font-style:normal;text-align:left;'>"+
                    "修改新闻内容（请点击相应按钮，编辑内容）"+
                    "</div>"+
                    "</div>"+
                    "</td></tr>");
                $.parser.parse($("#modifyNewsContentTable"));
                $("#nidInModifyNewsContent").val(jsonObj.nid);
                var newsContentArr = jsonObj.newscontent;
                if(!newsContentArr){
                    return;
                }
                for(var i = 0; i < newsContentArr.length; i++){
                    if(newsContentArr[i].contenttype == '1'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>副标题:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><input " +
                            " style='width:700px;' id='newscontent" + (i+1) +"' name='newscontent" + (i+1) + "'/>" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"modifyNewsContentSubtitle('" + (i+1) + "','" + newsContentArr[i].contentid + "')\">保存修改</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContentSubtitle('" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#newscontent" + (i+1) +"").textbox({
                            required: true,
                            validType: 'maxLen[80]',
                            missingMessage:'最多输入80个字符',
                            prompt:'请输入副标题',
                            value:newsContentArr[i].contentvalue
                        });
                    }
                    if(newsContentArr[i].contenttype == '2'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>图片:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><img width='120px' height='60px'  id='img_newscontent" + (i+1) +"'/>" +
                            "<input type='hidden' id='newscontent" + (i+1) +"'/>"+
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"openModifyNewsContentImgDialog('" + (i+1) +"','" + newsContentArr[i].contentid + "')\">修改图片</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContentImg('" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#img_newscontent" + (i+1) +"").attr("src", newsContentArr[i].contentvalue + "?rondomid=" + Math.random());
                    }
                    if(newsContentArr[i].contenttype == '3'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>文本:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><input data-options='multiline:true'" +
                            " style='width:650px;height: 60px;' id='newscontent" + (i+1) +"' name='newscontent" + (i+1) + "'/>" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"modifyNewsContentText('" + (i+1) + "','" + newsContentArr[i].contentid + "')\">保存修改</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContentText('" + newsContentArr[i].contentid + "')\">删除</a>" +
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
                $.parser.parse($("#modifyNewsContentTable"));
            }
        });
    }

    function deleteNewsContentImg(contentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个新闻内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if(r){
                $.ajax({
                    url: "<%=request.getContextPath()%>/news/deleteNewsContentImg.do" +
                    "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
                    + "&random_id=" + Math.random(),
                    type: 'get',
                    async: false,
                    error: function (data) {
                        MsgBox.show(data.responseText);
                    },
                    success: function (data) {
                        MsgBox.show(data);
                        refreshNewsContent();
                    }
                });
            }
        });
    }
    function deleteNewsContentSubtitle(contentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个新闻内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if(r){
                $.ajax({
                    url: "<%=request.getContextPath()%>/news/deleteNewsContentSubtitle.do" +
                    "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
                    + "&random_id=" + Math.random(),
                    type: 'get',
                    async: false,
                    error: function (data) {
                        MsgBox.show(data.responseText);
                    },
                    success: function (data) {
                        MsgBox.show(data);
                        refreshNewsContent();
                    }
                });
            }
        });
    }
    function deleteNewsContentText(contentid){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length <= 1){
            MsgBox.show("无法删除，至少有一个新闻内容");
            return;
        }
        $.messager.confirm('确认','您确认删除吗？',function(r){
            if(r){
                $.ajax({
                    url: "<%=request.getContextPath()%>/news/deleteNewsContentText.do" +
                    "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
                    + "&random_id=" + Math.random(),
                    type: 'get',
                    async: false,
                    error: function (data) {
                        MsgBox.show(data.responseText);
                    },
                    success: function (data) {
                        MsgBox.show(data);
                        refreshNewsContent();
                    }
                });
            }
        });
    }
    function modifyNewsContentSubtitle(index, contentid){
        if($.trim($("#newscontent" + index).val()).length == 0){
            MsgBox.show("新闻副标题不能为空");
            return;
        }
        if(StringUtil.getCharNumber($("#newscontent" + index).val()) > 80){
            MsgBox.show("副标题超长，最多输入80个字符");
            return;
        }
        $.ajax({
            url: "<%=request.getContextPath()%>/news/modifyNewsContentSubtitle.do" +
            "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
            + "&subtitle=" + $("#newscontent" + index).val() + "&random_id=" + Math.random(),
            type: 'get',
            async: false,
            error: function (data) {
                MsgBox.show(data.responseText);
            },
            success: function (data) {
                MsgBox.show(data);
                refreshNewsContent();
            }
        });
    }
    function modifyNewsContentText(index, contentid){
        if($.trim($("#newscontent" + index).val()).length == 0){
            MsgBox.show("文本不能为空");
            return;
        }
        if(StringUtil.getCharNumber($("#newscontent" + index).val()) > 4000){
            MsgBox.show("文本超长，最多输入4000个字符");
            return;
        }
        $.ajax({
            url: "<%=request.getContextPath()%>/news/modifyNewsContentText.do" +
            "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
            + "&text=" + $("#newscontent" + index).val() + "&random_id=" + Math.random(),
            type: 'get',
            async: false,
            error: function (data) {
                MsgBox.show(data.responseText);
            },
            success: function (data) {
                MsgBox.show(data);
                refreshNewsContent();
            }
        });
    }
    function openModifyNewsContentImgDialog(index, contentid){
        $('#modifyNewsContentImgDialog').dialog({
            title: '修改新闻内容图片',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyNewsContentImgDialog").dialog({
            onClose:function(){
                $("#modifyNewsContentImgDialog").empty();
            }
        });
        $('#modifyNewsContentImgDialog').dialog("open");
        $("#modifyNewsContentImgDialog").dialog("refresh",
            "<%=request.getContextPath()%>/news/fwdModifyNewsContentImgPage.do?nid=" + $("#nidInModifyNewsContent").val()
            +"&contentid=" + contentid
            + "&random_id=" + Math.random());
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
    function addNewsSubtitleInModify(){
        var nextIndex = getNextIndexInModify();
        $("#addNewsContentTable").append("<tr id='trcontent" + nextIndex + "'>" +
            "<td  nowrap='nowrap'>副标题(新增):<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='1'>" +
            "</td>" +
            "<td nowrap='nowrap'>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteNewsContentInModify('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).textbox({
            required: true,
            validType: 'maxLen[80]',
            missingMessage:'最多输入80个字符',
            prompt:'请输入副标题'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValueInModify();
    }
    function addNewsImageInModify() {
        var nextIndex = getNextIndexInModify();
        $("#addNewsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>图片(新增):<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input " +
            " data-options=\"buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            "  accept='image/jpeg,image/png'  style='width:700px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "</td>" +
            "<td>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteNewsContentInModify('trcontent" + nextIndex +"')\">删除</a>" +
            "</td>" +
            "</tr>");
        $("#newscontent" + nextIndex).filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            validType:'imgfile',
            prompt:'请选择图片'
        });
        $.parser.parse($('#trcontent'+nextIndex));
        dealSortValueInModify();
    }
    function addNewsTextInModify() {
        var nextIndex = getNextIndexInModify();
        $("#addNewsContentTable").append("<tr id='trcontent" + nextIndex + "'><td>文本(新增):<span style='color:red'>*</span></td>" +
            "<td colspan='5'><input data-options='multiline:true'" +
            " style='width:700px;height: 60px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "</td>" +
            "<td>" +
            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
            "onclick=\"deleteNewsContentInModify('trcontent" + nextIndex +"')\">删除</a>" +
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
    function deleteNewsContentInModify(trcontentid){
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
    function dealSortValueInModify(){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                var domid = domElement.id;
                $("#sort_" + domid).val(index + 1);
            });
        }
    }
    var checkCountInModifyNews = 10;
    function cbInModifyNews(){
        var f = $('#addNewsFormInModify_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyNews){
                setTimeout(cbInModifyNews, 100);
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
            $("#addNewsContentTable").empty();
            refreshNewsContent();
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealAddNewsFormInModifyBeforeSubmit(){
        var frameId = "addNewsFormInModify_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyNews);
        $("#addNewsFormInModify").attr('target', frameId);
    }
    function checkModifyNewsFormBeforeSubmit(){
        var addNewsContentTable = $("#addNewsContentTable");
        var newsContent = addNewsContentTable.find("input[id^='newscontent']");
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
        }else{
            return false;
        }
        return result;
    }
    function submitAddNewsFormInModify(){
        if(!checkModifyNewsFormBeforeSubmit()){
            return;
        }
        dealAddNewsFormInModifyBeforeSubmit();
        dealSortValueInModify();
        $("#addNewsFormInModify").submit();
        LoadingMaskLayer.show();
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInModifyNewsContent()">返回</a>
</div>
<div id="modifyNewsContentImgDialog"></div>
<div style="margin:0px auto;width: 900px;text-align: center;">
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon"></div>
                        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                            新闻标题
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>新闻标题:</td>
                <td colspan="4">
                    <input class="dzm-noBorder-text" readonly style="width:700px;" id="newstitleInModifyNewsContent" name="newstitle"/>
                    <input type="hidden" id="nidInModifyNewsContent" name="nid" />
                </td>
            </tr>
        </table>
    <table id="modifyNewsContentTable" cellpadding="5">
    </table>
    <form id="addNewsFormInModify" action="<%=request.getContextPath()%>/news/saveAddNewsContent.do"
        enctype="multipart/form-data" method="post">
        <input type="hidden" name="nid" id="nidInAddNewsForm" value="<%=request.getAttribute("nid").toString()%>"/>
        <table id="addNewsContentTable" cellpadding="5">
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsSubtitleInModify()">新增副标题</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsImageInModify()">新增图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsTextInModify()">新增文本</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddNewsFormInModify()">保存新增</a>
    </div>
</div>