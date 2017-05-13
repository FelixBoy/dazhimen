<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $("#pidInModifyProductMainImg").val("<%=request.getAttribute("pid")%>");
        $("#mainImgInModifyDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片，建议大小【2M】以内',
            validType:'imgfile'
        });
    });
    function checkMainImgModify(){
        if(!$("#mainImgInModifyDialog").filebox("getValue")){
            MsgBox.show("请选择产品主图");
            return false;
        }
        var imgFileName = $("#mainImgInModifyDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("产品主图文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    var checkCountInModifyMainImg = 10;
    function cbInModifyMainImg(){
        var f = $('#ModifyProductMainimgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyMainImg){
                setTimeout(cbInModifyMainImg, 100);
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
            var pid = resultObj.pid;
            $('#modifyProductMainImgDialog').dialog('close');
            MsgBox.show(msg);
            $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById.do" +
                "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());

        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealModifyProductMainimgFormBeforeSubmit(){
        var frameId = "ModifyProductMainimgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyMainImg);
        $("#modifyProductMainimgForm").attr('target', frameId);
    }
    function submitModifyProductMainImg(){
        if(!checkMainImgModify()){
            return;
        }
        dealModifyProductMainimgFormBeforeSubmit();
        $("#modifyProductMainimgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyProductMainimgForm" action="<%=request.getContextPath()%>/product/saveModifyProductMainImg.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请重新选择产品主图</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">产品主图:<span style="color:red">*</span></td>
                <td>
                    <input type="hidden" id="pidInModifyProductMainImg" name="pid"/>
                    <input id="mainImgInModifyDialog" name="mainimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyProductMainImg()">保存</a>
    </div>
</div>