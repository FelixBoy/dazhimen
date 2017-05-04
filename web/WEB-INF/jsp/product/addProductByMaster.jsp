<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script type="text/javascript">
    $(function () {
        $('#pname').textbox({
            required: true,
            validType: 'maxLen[50]',
            missingMessage:'最多输入50个字符',
            prompt:'请输入产品名称'
        });
        $("#price").textbox({
            required:true,
            missingMessage:'保留两位小数',
            prompt:'请输入金额',
            validType:'price'
        });
        $("#derateProportion").textbox({
            required:true,
            missingMessage:'整数百分比，1-99',
            prompt:'请输入减免比例',
            validType:'percent'
        });
        $("#prodcut_introduction").textbox({
            required:true,
            missingMessage:'产品介绍，最多输入2000个字符',
            validType: 'maxLen[2000]',
            prompt:'请输入产品介绍'
        });
        $("#listimg").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'请选择图片，用于列表展示',
            validType:'imgfile'
        });
        $("#mainimg1").filebox({
            required:true,
            missingMessage:'支持jpg,png格式',
            prompt:'请选择主图，用于首页轮播',
            validType:'imgfile'
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
            price: {
                validator: function (value, param) {
                    var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
                    return reg.test($.trim(value));
                },
                message: '金额格式不合法，请重新输入'
            },
            percent:{
                validator: function (value, param) {
                    if(!$.trim(value)){
                        return true;
                    }
                    var k= /^[1-9][0-9]{0,1}$/;
                    return k.test($.trim(value));
                },
                message: '减免百分比格式不合法，请重新输入'
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
        $("#selectMasterForm").form("load", "<%=request.getContextPath()%>/user/getUserInforJson.do?random_id" + Math.random());
    });
    var checkCount = 10;
    function cbInAddProduct(){
        var f = $('#ProductForm_iframe'), data = "";
        if (!f.length){
            return
        }
        f.unbind();
        var body = f.contents().find('body');
        data = body.html();
        if (data == ""){
            if (--checkCount){
                setTimeout(cbInAddProduct, 100);
                return;
            }
        }
        setTimeout(function(){
            f.unbind();
            f.remove();
        }, 100);
    }
    function dealProductFormBeforeSubmit(){
        var frameId = "ProductForm_iframe", $frame = null;
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
        $frame.bind('load', cbInAddProduct);
        $("#productForm").attr('target', frameId);
    }
    function submitAddProduct(){
        if(!checkProductForm()){
            return;
        }
        dealProductFormBeforeSubmit();
        $("#productForm").submit();
        LoadingMaskLayer.show();
    }
    function checkProductForm(){
        if($("#uid").val().length == 0){
            MsgBox.show("请选择掌门信息");
            return false;
        }
        if($.trim($("#pname").val()).length == 0){
            MsgBox.show("请填写产品名称");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#pname").val())) > 50){
            MsgBox.show("产品名称过长，最长50个字符");
            return false;
        }
        if($.trim($("#price").val()).length == 0){
            MsgBox.show("请填写产品价格");
            $("#price").focus();
            return false;
        }
        var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if(!reg.test($.trim($("#price").val()))){
            MsgBox.show("产品价格[" + $.trim($("#price").val()) + "]格式不正确");
            return false;
        }
        if($.trim($("#derateProportion").val()).length > 0){
            var k= /^[0-9][0-9]{0,1}$/;
            if(!k.test($.trim($("#derateProportion").val()))){
                MsgBox.show("余额支付减免[" + $.trim($("#derateProportion").val()) + "]格式不正确");
                return false;
            }
        }

        if(!$("#listimg").filebox("getValue")){
            MsgBox.show("请选择列表图片");
            return false;
        }
        var imgFileName = $("#listimg").filebox("getValue");
        var imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("列表图片文件，仅支持jpg、png");
            return false;
        }
        if(!$("#mainimg1").filebox("getValue")){
            MsgBox.show("请选择产品主图");
            return false;
        }
        imgFileName = $("#mainimg1").filebox("getValue");
        imgFileSuffixName = imgFileName.substring(imgFileName.lastIndexOf("."));
        if(imgFileSuffixName != ".jpg" && imgFileSuffixName != ".png"){
            MsgBox.show("产品主图文件，仅支持jpg、png");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#prodcut_introduction").val())) > 2000){
            MsgBox.show("产品介绍过长，最长2000个字符");
            return false;
        }
        return true;
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
            MsgBox.show(msg);
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdProductInfoPage.do?random_id=" + Math.random()+"&pid=" + pid,
                onLoad:function(){
                }
            });
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function returnManageProductInAddProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage.do?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageProductInAddProduct()">返回</a>
</div>
<div style="margin:0px auto;width: 840px;">
    <form id="selectMasterForm">
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请选择掌门<span style="color:red">*</span></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>责任掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uid" name="uid">&nbsp&nbsp</td>
                <td>登录账号:</td>
                <td><input class="dzm-noBorder-text" readonly id="loginname" name="loginname">&nbsp&nbsp</td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly id="uname" name="uname" /></td>
            </tr>
            <tr>
                <td>手机号码:</td>
                <td><input class="dzm-noBorder-text" readonly id="mphone" name="mphone"/>&nbsp&nbsp</td>
                <td>性别:</td>
                <td><input class="dzm-noBorder-text" readonly id="gender" name="gender" />&nbsp&nbsp</td>
                <td>备注信息:</td>
                <td><textarea class="dzm-noBorder-text" readonly id="introduction" name="introduction" style="height:50px"/></td>
            </tr>
        </table>
        <br/>
    </form>
    <form id="productForm" action="<%=request.getContextPath()%>/product/saveAddProduct.do"
          enctype="multipart/form-data" method="post">
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写产品信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>名称:<span style="color:red">*</span></td>
                <td><input id="pname" name="pname" />
                    <input type="hidden" id="uidInProductForm" name="uid" value="<%=userBean.getUid()%>"></td>
                <td>类型:<span style="color:red">*</span></td>
                <td>
                    <select class="easyui-combobox" name="type" id="type" editable="false" style="width:98%">
                        <option value="1">技能包</option>
                        <option value="2">经验包</option>
                    </select>
                </td>
                <td nowrap="nowrap">价格/年:<span style="color:red">*</span></td>
                <td><input id="price" name="price" ></td>
            </tr>
            <tr>
                <td>余额支付减免:</td>
                <td><input id="derateProportion"  name="derateProportion"/>%</td>
            </tr>
            <tr>
                <td>列表图片:<span style="color:red">*</span></td>
                <td colspan="2">
                        <input id="listimg" name="listimg" style="width:100%" accept="image/jpeg,image/png"
                               data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
                <td nowrap="nowrap" style="text-align: right">产品主图:<span style="color:red">*</span></td>
                <td colspan="2">
                    <input id="mainimg1" name="mainimg" style="width:100%" accept="image/jpeg,image/png"
                           data-options="buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="5"><input id="prodcut_introduction"
                                       style="width:100%;height:80px;"
                                       name="introduction" data-options="multiline:true"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddProduct()">保存</a>
    </div>
</div>