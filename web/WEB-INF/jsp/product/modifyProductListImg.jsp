<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    $(function(){
        $("#pidInModifyProductListImg").val("<%=request.getAttribute("pid")%>");
        $("#listImgInModifyDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片，建议大小【2M】以内',
            validType:'imgfile'
        });
    });
    var checkCountInModifyListImg = 10;
    function cbInModifyListImg(){
        var f = $('#ModifyProductListimgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyListImg){
                setTimeout(cbInModifyListImg, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealModifyProductListimgFormBeforeSubmit(){
        var frameId = "ModifyProductListimgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyListImg);
        $("#modifyProductListimgForm").attr('target', frameId);
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
            $('#modifyProductListImgDialog').dialog('close');
            MsgBox.show(msg);
            $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById.do" +
                "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());

        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function checkListImgModify(){
        if(!$("#listImgInModifyDialog").filebox("getValue")){
            MsgBox.show("请选择列表图片");
            return false;
        }
        var imgFileName = $("#listImgInModifyDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName.toLocaleLowerCase() != ".jpg" && imgFileSuffixName.toLocaleLowerCase() != ".png"){
            MsgBox.show("列表图片文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    function submitModifyProductListImg(){
        if(!checkListImgModify()){
            return;
        }
        dealModifyProductListimgFormBeforeSubmit();
        $("#modifyProductListimgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyProductListimgForm" action="<%=request.getContextPath()%>/product/saveModifyProductListImg.do"
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
                    <input type="hidden" id="pidInModifyProductListImg" name="pid"/>
                    <input id="listImgInModifyDialog" name="listimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyProductListImg()">保存</a>
    </div>
</div>