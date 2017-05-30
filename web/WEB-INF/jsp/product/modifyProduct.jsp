<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    function returnManageProductInModifyProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage.do?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
    $(function(){
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
                    var k= /^[0-9][0-9]{0,1}$/;
                    return k.test($.trim(value));
                },
                message: '减免百分比格式不合法，请重新输入'
            },
            imgfile:{
                validator: function (value, param) {
                    var imgFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(imgFileSuffixName.toLocaleLowerCase() != ".jpg" && imgFileSuffixName.toLocaleLowerCase() != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            }
        });
        $('#pnameInModify').textbox({
            required: true,
            validType: 'maxLen[15]',
            missingMessage:'最多输入15个字符',
            prompt:'请输入产品名称'
        });
        $("#priceInModify").textbox({
            required:true,
            missingMessage:'保留两位小数',
            prompt:'请输入金额',
            validType:'price'
        });
        $("#derateProportionInModify").textbox({
            required:true,
            missingMessage:'整数百分比，1-99',
            prompt:'请输入减免比例',
            validType:'percent'
        });
        $("#introduction").textbox({
            required:true,
            missingMessage:'介绍信息，最多输入2000个字符',
            validType: 'maxLen[2000]',
            prompt:'请输入产品介绍'
        });
        $('#modifyProductForm').form({onLoadSuccess:function(){
            $("#listImageInModify").attr("src",$("#listimage").val()+"?random_id="+Math.random());
            dealMainImagesInModifyProduct();
        }});
        $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById.do" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function dealMainImagesInModifyProduct(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getMainImagesInforById.do" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                var arr = JSON.parse(data);
                var arrLength = arr.length;
                if(!arrLength){
                    return;
                }
                $("#mainImageRealInModify").attr("src",arr[0].mainImage + "?random_id="+Math.random());
            }
        });
    }
    function openModifyMainImgDialog(){
        $('#modifyProductMainImgDialog').dialog({
            title: '修改产品主图',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyProductMainImgDialog").dialog({
            onClose:function(){
                $("#modifyProductMainImgDialog").empty();
            }
        });
        $('#modifyProductMainImgDialog').dialog("open");
        $("#modifyProductMainImgDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyProductMainImgPage.do?pid=" + $("#pid").val()
            + "&random_id=" + Math.random());
    }
    function openModifyListImgDialog(){
        $('#modifyProductListImgDialog').dialog({
            title: '修改产品列表图片',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyProductListImgDialog").dialog({
            onClose:function(){
                $("#modifyProductListImgDialog").empty();
            }
        });
        $('#modifyProductListImgDialog').dialog("open");
        $('#modifyProductListImgDialog').dialog("refresh","<%=request.getContextPath()%>/product/fwdModifyProductListImgPage.do?pid=" + $("#pid").val()
                + "&random_id=" + Math.random());
    }

    function checkModifyProductFormBeforeSubmit(){
        if($.trim($("#pnameInModify").val()).length == 0){
            MsgBox.show("请填写产品名称");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#pnameInModify").val())) > 15){
            MsgBox.show("产品名称过长，最长15个字符");
            return false;
        }
        if($.trim($("#priceInModify").val()).length == 0){
            MsgBox.show("请填写产品价格");
            return false;
        }
        var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if(!reg.test($.trim($("#priceInModify").val()))){
            MsgBox.show("产品价格[" + $.trim($("#priceInModify").val()) + "]格式不正确");
            return false;
        }
        if($.trim($("#derateProportionInModify").val()).length > 0){
            var k= /^[0-9][0-9]{0,1}$/;
            if(!k.test($.trim($("#derateProportionInModify").val()))){
                MsgBox.show("余额支付减免[" + $.trim($("#derateProportionInModify").val()) + "]格式不正确");
                return false;
            }
        }
        if($.trim($("#derateProportionInModify").val()).length > 0){
            var price_float = parseFloat($.trim($("#priceInModify").val()));
            var derateProportion_float = 1 - (parseFloat($.trim($("#derateProportionInModify").val())) / 100);
            if(price_float * derateProportion_float < 0.01){
                MsgBox.show("减免之后，价格小于0.01元，无法保存");
                return false;
            }
        }
        if(StringUtil.getCharNumber($.trim($("#introduction").val())) > 2000){
            MsgBox.show("产品介绍过长，最长2000个字符");
            return false;
        }
        return true;
    }
    function submitModifyProductForm(){
        if(!checkModifyProductFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/product/saveModifyProductBasicInfo.do",
            data:$('#modifyProductForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById.do" +
                    "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
            }
        });
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageProductInModifyProduct()">返回</a>
</div>
<div id="modifyProductListImgDialog"></div>
<div id="modifyProductMainImgDialog"></div>
<div style="margin:0px auto;width: 950px">
    <form id="modifyProductForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="8" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改产品基本信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">产品ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="pid" name="pid"></td>
                <td nowrap="nowrap">类型:</td>
                <td><input class="dzm-noBorder-text" readonly id="type" name="type"></td>
                <td nowrap="nowrap">掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uid" name="uid"></td>
                <td nowrap="nowrap">姓名:</td>
                <td><input class="dzm-noBorder-text" readonly id="name" name="uname" /></td>
            </tr>
            <tr>
                <td nowrap="nowrap">名称:<span style="color:red">*</span></td>
                <td><input id="pnameInModify" name="pname"></td>
                <td nowrap="nowrap">价格/年:<span style="color:red">*</span></td>
                <td><input id="priceInModify" name="price"></td>
                <td  nowrap="nowrap" class="form-label-cell">余额支付减免:<span style="color:red">*</span></td>
                <td nowrap="nowrap"><input id="derateProportionInModify"  name="derateProportion"/>%</td>
            </tr>
            <tr>
                <td nowrap="nowrap">介绍:</td>
                <td colspan="6"><input id="introduction" name="introduction" data-options="multiline:true" style="width:90%;height:80px;"/></td>
            </tr>
        </table>

        <div style="text-align: center;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyProductForm()">保存基本信息修改</a>
        </div>
        <div style="height: 50px;">

        </div>
    <table cellpadding="5" align="left">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改产品图片</div>
                </div>
            </td>
        </tr>
        <tr id="imgtr">
            <td nowrap="nowrap">列表图片:</td>
            <td id="listimgtr" colspan="2"><input class="dzm-noBorder-text" readonly type="hidden" id="listimage" name="listImage" />
                <img id="listImageInModify" width="100px" height="100px"/>
            </td>
            <td align='right'>产品主图:</td>
            <td align='left' colspan='2'>
                <img id="mainImageRealInModify"  align='left' width='200px' height='100px'/><br/>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right;"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="openModifyListImgDialog()">修改列表图片</a></td>
            <td colspan="3" style="text-align: center;"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="openModifyMainImgDialog()">修改产品主图</a></td>
        </tr>
    </table>
    </form>
</div>