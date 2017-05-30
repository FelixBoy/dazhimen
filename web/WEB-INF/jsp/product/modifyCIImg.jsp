<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $("#courseidInModifyCIImgDialog").val("<%=request.getAttribute("courseid")%>");
        $("#contentidInModifyCIImgDialog").val("<%=request.getAttribute("contentid")%>");
        $("#pidInModifyCIImgDialog").val("<%=request.getAttribute("pid")%>");
        $("#imgInModifyCIImgDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片，建议大小【2M】以内',
            validType:'imgfile'
        });
    });
    function checkCIImgModify(){
        if(!$("#imgInModifyCIImgDialog").filebox("getValue")){
            MsgBox.show("请选择图片");
            return false;
        }
        var imgFileName = $("#imgInModifyCIImgDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
            MsgBox.show("图片文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    var checkCountInModifyCIImg = 10;
    function cbInModifyCIImg(){
        var f = $('#ModifyCIImgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyCIImg){
                setTimeout(cbInModifyCIImg, 100);
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
            refreshCourseInfor();
            $('#modifyCIImgDialog').dialog('close');
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealModifyCIImgFormBeforeSubmit(){
        var frameId = "ModifyCIImgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyCIImg);
        $("#modifyCIImgForm").attr('target', frameId);
    }
    function submitModifyCIImg(){
        if(!checkCIImgModify()){
            return;
        }
        dealModifyCIImgFormBeforeSubmit();
        $("#modifyCIImgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyCIImgForm" action="<%=request.getContextPath()%>/product/saveModifyCIImg.do"
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
                    <input type="hidden" id="pidInModifyCIImgDialog" name="pid"/>
                    <input type="hidden" id="courseidInModifyCIImgDialog" name="courseid"/>
                    <input type="hidden" id="contentidInModifyCIImgDialog" name="contentid"/>
                    <input id="imgInModifyCIImgDialog" name="contentimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyCIImg()">保存</a>
    </div>
</div>