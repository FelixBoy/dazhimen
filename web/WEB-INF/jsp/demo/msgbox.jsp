<script>
	function submitForm(){
	    $("#xxxx").submit();
	}
	function dealSortValue(){
        var newsContent = $("input[id^='newscontent']");
        if(newsContent.length > 0){
            newsContent.each(function(index, domElement){
                domElement.
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
        $("#xxxx").append("副标题<input class='easyui-textbox' " +
            " style='width:80%' id='newscontent" + nextIndex +"' name='newscontent" + nextIndex + "'/><br/>");
        $.parser.parse($('#xxxx'));
        dealSortValue();
    }
	function addImage() {
    }
    function addNewsText() {
        
    }
</script>
<form id="xxxx" action="<%=request.getContextPath()%>/demo/testTextArea">
	新闻标题<input class="easyui-textbox" id="newstitle"
		   style="width:80%;"
		   name="newstitle" /><br/>
	列表图片<input class="easyui-filebox" id="newslistimg" name="newslistimg" style="width:80%" accept="image/jpeg,image/png"
                data-options="prompt:'请选择列表图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/><br/>
	新闻主图<input class="easyui-filebox" id="newsmainimg" name="newsmainimg" style="width:80%" accept="image/jpeg,image/png"
               data-options="prompt:'请选择新闻(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'"/><br/>
    副标题<input class="easyui-textbox" id="newscontent5" name="newscontent5" style="width:80%"/><br/>
</form>
<input type="button" onclick="submitForm()" value="提交"/>
<input type="button" onclick="addNewsSubtitle()" value="添加副标题"/>
<input type="button" onclick="addNewsImage()" value="添加图片"/>
<input type="button" onclick="addNewsText()" value="添加内容"/>
