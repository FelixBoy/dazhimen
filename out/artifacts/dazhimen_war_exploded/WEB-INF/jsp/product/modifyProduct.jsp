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
            $("#listImageReal").attr("src",$("#listimage").val());
            dealMainImagesInModifyProduct();
        }});
        $("#modifyProductForm").form("load", "<%=request.getContextPath()%>/product/getModifyProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function openModifyMainImgDialog(){
        MsgBox.show("修改1");
    }
    function openModifyListImgDialog(){
        MsgBox.show("修改2");
    }
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
                var rowLength = Math.floor(arrLength / 3);
                if(rowLength <= 1){
                    var htmlArr = [];
                    for(var i = 0; i < arrLength; i++){
                        htmlArr.push("<td align='right'>产品主图:</td>");
                        htmlArr.push("<td align='left' colspan='2'>");
                        htmlArr.push("       <input type='hidden' id='mainimg"+i+"' value="+ arr[i].imageId +"/> ");
                        htmlArr.push("       <img align='left' src='" + arr[i].mainImage + "' width='200px' height='100px'/><br/>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" onclick='openModifyMainImgDialog()'>修改产品主图</a>");
                        htmlArr.push("</td>")
                    }
                    $(htmlArr.join("")).insertAfter("#listimgtr");
                    $.parser.parse($("#imgtr"));
                }
            }
        });
    }
    function checkModifyProductFormBeforeSubmit(){
        if($("#pnameInModify").val().length == 0){
            MsgBox.show("请填写产品名称");
            $("#pnameInModify").focus();
            return false;
        }
        if($("#priceInModify").val().length == 0){
            MsgBox.show("请填写产品价格");
            $("#priceInModify").focus();
            return false;
        }
        var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if(!reg.test($("#priceInModify").val())){
            MsgBox.show("产品价格[" + $("#priceInModify").val() + "]格式不正确");
            return false;
        }
        if($("#derateProportionInModify").val().length > 0){
            if($("#derateProportionInModify").val() >99 || $("#derateProportionInModify").val() < 0){
                MsgBox.show("余额支付减免[" +$("#derateProportionInModify").val() + "]超出范围");
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
            }
        });
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageProductInModifyProduct()">返回</a>
</div>
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
                <td><input class="easyui-textbox" id="priceInModify" name="price"></td>
                <td class="form-label-cell">余额支付减免:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="derateProportionInModify" name="derateProportion"/>%</td>
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
    <table cellpadding="5">
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
                <img id="listImageReal" width="100px" height="100px"/><br/>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="openModifyListImgDialog()">修改列表图片</a></td>
        </tr>
    </table>
    </form>
</div>