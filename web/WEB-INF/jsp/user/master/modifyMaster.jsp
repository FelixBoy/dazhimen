<script type="text/javascript">
    var checkCountInMasterModify = 10;
    function cbInModifyMaster(){
        var f = $('#MasterModifyForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCountInMasterModify){
                setTimeout(cbInModifyMaster, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function actionAfterSubmit(jsonObj) {
        LoadingMaskLayer.hide();
        var resultObj = JSON.parse(jsonObj);
        if (!resultObj) {
            return;
        }
        var code = resultObj.code;
        if (code == '200') {
            var msg = resultObj.msg;
            MsgBox.show(msg);
            $('#masterModifyDialog').dialog('close');
            $('#masterList').datagrid('reload');
        } else {
            MsgBox.show(resultObj.msg);
        }
    }
    function dealmasterModifyFormBeforeSubmit(){
        var frameId = "MasterModifyForm_iframe", $frame = null;
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
        $frame.bind('load', cbInModifyMaster);
        $("#masterModifyForm").attr('target', frameId);
    }
    function submitModifyMasterForm(){
        if(!checkMoidfyMasterFormBeforeSubmit()){
            return;
        }
        dealmasterModifyFormBeforeSubmit();
        $("#masterModifyForm").submit();
        LoadingMaskLayer.show();
    }
    $(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/user/getMasterData.do" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data) {
                if (!data) {
                    return;
                } else {
                    var jsonObj = JSON.parse(data);
                    if (!jsonObj) {
                        return;
                    }
                    $("#uidInModifyMaster").val(jsonObj.uid);
                    $("#nameInModifyMaster").val(jsonObj.name);
                    $("#mphoneInModifyMaseter").val(jsonObj.mphone);
                    if(jsonObj.gender == '1'){
                        $("#gender_boy").prop("checked", "checked");
                    }else{
                        $("#gender_girl").prop("checked", "checked");
                    }
                    $("#loginnameInModifyMaster").val(jsonObj.loginname);
                    $("#lognnameOrginalInModify").val(jsonObj.loginname);
                    $("#introductionInModfiyMaster").val(jsonObj.introduction);
                    $("#identityInModifyMaseter").val(jsonObj.identity);
                    $("#headImgRealInModifyMaster").attr("src", jsonObj.headerimg+"?random_id="+Math.random());
                }
            }
        });
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
            maxLenWithoutTrim:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber(value) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            numberAndLetter:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9a-zA-Z]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为字母或数字组合'
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
            },
            mphone:{
                validator: function (value, param) {
                    var reg = /^1\d{10}$/;
                    return reg.test(value);
                },
                message:'格式不正确，只能为以1开头的11位数字'
            }
        });
        $('#loginnameInModifyMaster').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入登录名'
        });
        $('#nameInModifyMaster').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入姓名'
        });
        $('#mphoneInModifyMaseter').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[11]','mphone'] ,
            missingMessage:'以1开头的11位数字',
            prompt:'请输入手机号码'
        });
        $("#fuckthismasterhead").filebox({
            required:true,
            validType:'imgfile',
            missingMessage:'支持jpg,png格式',
            prompt:'请选择头像图片，建议大小【2M】以内'
        });
        $('#identityInModifyMaseter').textbox({
            required: true,
            validType: 'maxLen[50]',
            missingMessage:'最多输入50个字符',
            prompt:'请输入身份'
        });
        $('#introductionInModfiyMaster').textbox({
            required: true,
            validType: 'maxLen[2000]',
            missingMessage:'最多输入2000个字符',
            prompt:'请输入介绍'
        });
    });
    function checkMoidfyMasterFormBeforeSubmit(){
        if($.trim($("#loginnameInModifyMaster").val()).length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#loginnameInModifyMaster").val())) > 100){
            MsgBox.show("登录名过长，无法保存");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($.trim($("#loginnameInModifyMaster").val()))){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if($.trim($("#nameInModifyMaster").val()).length == 0){
            MsgBox.show("请输入姓名");
            return false;
        }
        if(StringUtil.getBinaryLength($.trim($("#nameInModifyMaster").val())) > 100){
            MsgBox.show("姓名过长，无法保存");
            return false;
        }
        if($.trim($("#mphoneInModifyMaseter").val()).length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg = /^1\d{10}$/;
        if (!reg.test($.trim($("#mphoneInModifyMaseter").val()))) {
            MsgBox.show("手机号码格式有误");
            return false;
        }
        if($.trim($("#identityInModifyMaseter").val()).length == 0){
            MsgBox.show("请输入掌门身份");
            return false;
        }
        return true;
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="masterModifyForm" action="<%=request.getContextPath()%>/user/saveMasterModify.do"
          enctype="multipart/form-data" method="post">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改掌门信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">头像:</td>
                <td><img id="headImgRealInModifyMaster" width="100px" height="100px"/></td>
            </tr>
            <tr>
                <td style="text-align: right">掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uidInModifyMaster" name="uid" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                <td><input id="loginnameInModifyMaster" name="loginname" style="width:300px" /></td>
                <input type="hidden" id="lognnameOrginalInModify" name="loginnameorginal">
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">姓名:<span style="color:red">*</span></td>
                <td><input style="width:300px" id="nameInModifyMaster" name="name" /></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">手机号码:<span style="color:red">*</span></td>
                <td><input style="width:300px" id="mphoneInModifyMaseter" name="mphone" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">身份:<span style="color:red">*</span></td>
                <td><input id="identityInModifyMaseter" name="identity" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">头像文件:</td>
                <td>
                    <input id="fuckthismasterhead" name="fuackmasterheadimg" data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'"
                           style="width:300px" accept="image/jpeg,image/png"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">性别:</td>
                <td>
                    <span class="radioSpan">
                        <input type="radio" id="gender_boy" name="gender" value="1" checked >男</input>
                        <input type="radio" id="gender_girl" name="gender" value="2">女</input>
                    </span>
                </td>
            </tr>
            <input type="hidden" name="type" value="1"/>
            <tr>
                <td style="text-align: right">介绍:</td>
                <td><input id="introductionInModfiyMaster" name="introduction" data-options="multiline:true" style="width:300px;height:60px;"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyMasterForm()">保存</a>
    </div>
</div>