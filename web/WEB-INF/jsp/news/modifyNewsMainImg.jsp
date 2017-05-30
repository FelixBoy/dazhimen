<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $("#nidInModifyNewsMainImgDialog").val("<%=request.getAttribute("nid")%>");
        $("#mainImgInModifyNewsTitleDialog").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'将会覆盖原图片，建议大小【2M】以内',
            validType:'imgfile'
        });
    });
    function checkNewsMainImgModify(){
        if(!$("#mainImgInModifyNewsTitleDialog").filebox("getValue")){
            MsgBox.show("请选择新闻主图");
            return false;
        }
        var imgFileName = $("#mainImgInModifyNewsTitleDialog").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
            MsgBox.show("新闻主图文件，仅支持jpg、png");
            return false;
        }
        return true;
    }
    var checkCountInModifyNewsMainImg = 10;
    function cbInModifyNewsMainImg(){
        var f = $('#ModifyNewsMainimgForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInModifyNewsMainImg){
                setTimeout(cbInModifyNewsMainImg, 100);
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
            $('#modifyNewsMainImgDialog').dialog('close');
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function dealModifyNewsMainimgFormBeforeSubmit(){
        var frameId = "ModifyNewsMainimgForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyNewsMainImg);
        $("#modifyNewsMainimgForm").attr('target', frameId);
    }
    function submitModifyNewsMainImg(){
        if(!checkNewsMainImgModify()){
            return;
        }
        dealModifyNewsMainimgFormBeforeSubmit();
        $("#modifyNewsMainimgForm").submit();
        LoadingMaskLayer.show();
    }
</script>
<div  style="width: 380px;margin: 0 auto;">
    <form id="modifyNewsMainimgForm" action="<%=request.getContextPath()%>/news/saveModifyNewsMainImg.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请重新选择新闻主图</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">列表图片:<span style="color:red">*</span></td>
                <td>
                    <input type="hidden" id="nidInModifyNewsMainImgDialog" name="nid"/>
                    <input id="mainImgInModifyNewsTitleDialog" name="mainimgmodify" style="width:280px" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
        </table>
    </form>
    <br/>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyNewsMainImg()">保存</a>
    </div>
</div>