<script type="text/javascript">
    $(function(){
        $("#nidInModifyNewsListImgDialog").val("<%=request.getAttribute("nid")%>");
        $("#listImgInModifyNewsTitleDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片',
            validType:'imgfile'
        });
    });
    function checkNewsListImgModify(){
        if(!$("#listImgInModifyNewsTitleDialog").filebox("getValue")){
            MsgBox.show("请选择列表图片");
            return false;
        }
        var imgFileName = $("#listImgInModifyNewsTitleDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("列表图片文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    var checkCountInModifyNewsListImg = 10;
    function cbInModifyNewsListImg(){
        var f = $('#ModifyNewsListimgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyNewsListImg){
                setTimeout(cbInModifyNewsListImg, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealModifyNewsListimgFormBeforeSubmit(){
        var frameId = "ModifyNewsListimgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyNewsListImg);
        $("#modifyNewsListimgForm").attr('target', frameId);
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
            $.ajax({
                url:"<%=request.getContextPath()%>/news/getModifyNewsTitleData.do" +
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
                    $("#newstitleInModifyTitle").val(jsonObj.title);
                    $("#nidInModifyTitle").val(jsonObj.nid);
                    $("#listImageInModifyNews").attr("src", jsonObj.listimgurl + "?rondomid=" + Math.random());
                    $("#mainImageInModifyNews").attr("src",jsonObj.mainimgurl + "?rondomid=" + Math.random());
                }
            });
            $('#modifyNewsListImgDialog').dialog('close');
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function submitModifyNewsListImg(){
        if(!checkNewsListImgModify()){
            return;
        }
        dealModifyNewsListimgFormBeforeSubmit();
        $("#modifyNewsListimgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyNewsListimgForm" action="<%=request.getContextPath()%>/news/saveModifyNewsListImg.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请重新选择列表图片</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">列表图片:<span style="color:red">*</span></td>
                <td>
                    <input type="hidden" id="nidInModifyNewsListImgDialog" name="nid"/>
                    <input id="listImgInModifyNewsTitleDialog" name="listimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyNewsListImg()">保存</a>
    </div>
</div>