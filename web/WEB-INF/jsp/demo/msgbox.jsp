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
//            var pid = resultObj.pid;
            MsgBox.show(msg);
            <%--$('#content_panel').panel({--%>
                <%--href:"<%=request.getContextPath() %>/product/fwdProductInfoPage?random_id=" + Math.random()+"&pid=" + pid,--%>
                <%--onLoad:function(){--%>
                <%--}--%>
            <%--});--%>
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
	function submitAddNewsForm(){
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
        $("#addNewsForm").append("副标题<input class='easyui-textbox' " +
            " style='width:80%' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
			"<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
			"<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='1'>" +
			"<br/>");
        $.parser.parse($('#addNewsForm'));
        dealSortValue();
    }
	function addNewsImage() {
        var nextIndex = getNextIndex();
        $("#addNewsForm").append("图片：<input class='easyui-filebox' " +
			" data-options=\"prompt:'请选择图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'\"" +
            " style='width:80%' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='2'>" +
            "<br/>");
        $.parser.parse($('#addNewsForm'));
        dealSortValue();
    }
    function addNewsText() {
        var nextIndex = getNextIndex();
        $("#addNewsForm").append("内容：<input class='easyui-textbox' data-options='multiline:true' " +
            " style='width:80%;height: 50px;' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='sort_newscontent" + nextIndex + "' name='sort_newscontent" + nextIndex + "'/>" +
            "<input type='hidden' id='type_newscontent" + nextIndex + "' name='type_newscontent" + nextIndex + "' value='3'>" +
            "<br/>");
        $.parser.parse($('#addNewsForm'));
        dealSortValue();
    }
</script>
<form id="addNewsForm" action="<%=request.getContextPath()%>/news/saveAddNews"
	  enctype="multipart/form-data" method="post">
	新闻标题<input class="easyui-textbox" id="newstitle" style="width:80%;"
		   name="newstitle" /><br/>
	列表图片<input class="easyui-filebox" id="newslistimg" name="newslistimg" style="width:80%" accept="image/jpeg,image/png"
                data-options="prompt:'请选择列表图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/><br/>
	新闻主图<input class="easyui-filebox" id="newsmainimg" name="newsmainimg" style="width:80%" accept="image/jpeg,image/png"
               data-options="prompt:'请选择新闻(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/><br/>
</form>
<input type="button" onclick="submitAddNewsForm()" value="提交"/>
<input type="button" onclick="addNewsSubtitle()" value="添加副标题"/>
<input type="button" onclick="addNewsImage()" value="添加图片"/>
<input type="button" onclick="addNewsText()" value="添加内容"/>
