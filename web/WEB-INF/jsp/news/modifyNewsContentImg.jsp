<script type="text/javascript">
    $(function(){
        $("#nidInModifyNewsContentImgDialog").val("<%=request.getAttribute("nid")%>");
        $("#contentidInModifyNewsContentImgDialog").val("<%=request.getAttribute("contentid")%>");
        $("#imgInModifyNewsContentImgDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片，建议大小【2M】以内',
            validType:'imgfile'
        });
    });
    function checkNewsContentImgModify(){
        if(!$("#imgInModifyNewsContentImgDialog").filebox("getValue")){
            MsgBox.show("请选择图片");
            return false;
        }
        var imgFileName = $("#imgInModifyNewsContentImgDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("图片文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    var checkCountInModifyNewsContentImg = 10;
    function cbInModifyNewsContentImg(){
        var f = $('#ModifyNewsContentimgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyNewsContentImg){
                setTimeout(cbInModifyNewsContentImg, 100);
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
            refreshNewsContent();
            $('#modifyNewsContentImgDialog').dialog('close');
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealModifyNewsContentimgFormBeforeSubmit(){
        var frameId = "ModifyNewsContentimgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyNewsContentImg);
        $("#modifyNewsContentimgForm").attr('target', frameId);
    }
    function submitModifyNewsContentImg(){
        if(!checkNewsContentImgModify()){
            return;
        }
        dealModifyNewsContentimgFormBeforeSubmit();
        $("#modifyNewsContentimgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyNewsContentimgForm" action="<%=request.getContextPath()%>/news/saveModifyNewsContentImg.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请重新选择图片</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">图片:<span style="color:red">*</span></td>
                <td>
                    <input type="hidden" id="nidInModifyNewsContentImgDialog" name="nid"/>
                    <input type="hidden" id="contentidInModifyNewsContentImgDialog" name="contentid"/>
                    <input id="imgInModifyNewsContentImgDialog" name="contentimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyNewsContentImg()">保存</a>
    </div>
</div>