<script type="text/javascript">
    function returnManageProductInModifyProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
    $(function(){
        $('#modifyProductForm').form({onLoadSuccess:function(){
            $("#listImageInModify").attr("src",$("#listimage").val()+"?random_id="+Math.random());
            dealMainImagesInModifyProduct();
        }});
        $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function dealMainImagesInModifyProduct(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getMainImagesInforById" +
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
        $("#modifyProductMainImgDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyProductMainImgPage?pid=" + $("#pid").val()
            + "&random_id=" + Math.random());
        $('#modifyProductMainImgDialog').dialog("open");
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
        $("#modifyProductListImgDialog").dialog("refresh", "<%=request.getContextPath()%>/product/fwdModifyProductListImgPage?pid=" + $("#pid").val()
            + "&random_id=" + Math.random());
        $('#modifyProductListImgDialog').dialog("open");
    }

    function checkModifyProductFormBeforeSubmit(){
        if($.trim($("#pnameInModify").val()).length == 0){
            MsgBox.show("请填写产品名称");
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
            if($.trim($("#derateProportionInModify").val()) >99 || $.trim($("#derateProportionInModify").val()) < 0){
                MsgBox.show("余额支付减免[" + $.trim($("#derateProportionInModify").val()) + "]超出范围");
                return false;
            }
        }
        return true;
    }
    function submitModifyProductForm(){
        if(!checkModifyProductFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/product/saveModifyProductBasicInfo",
            data:$('#modifyProductForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById" +
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
                <td>产品ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="pid" name="pid"></td>
                <td>类型:</td>
                <td><input class="dzm-noBorder-text" readonly id="type" name="type"></td>
                <td>掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uid" name="uid"></td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly id="name" name="uname" /></td>
            </tr>
            <tr>
                <td>名称:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="pnameInModify" name="pname"></td>
                <td width="50px" nowrap="nowrap">价格/年:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="priceInModify" name="price" data-options="prompt:'请输入金额，两位小数'"></td>
                <td class="form-label-cell">余额支付减免:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="derateProportionInModify" data-options="prompt:'请输入百分比'" name="derateProportion"/>%</td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="6"><input class="easyui-textbox" name="introduction" data-options="multiline:true" style="width:90%;height:80px;"/></td>
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
            <td id="listimgtr" colspan="2"><input class="dzm-noBorder-text" readonly="true" type="hidden" id="listimage" name="listImage" />
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