<script type="text/javascript">
    $(function(){
        $('#selectMasterForm').form({onLoadSuccess:function(){
          $("#uidInProductForm").val($("#uid").val());
        }});
    });
    function selectMaster(){
        $('#selectMasterDialog').dialog({
            title: '选择掌门',
            width: 600,
            height: 400,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/product/fwdSelectMasterPage?random_id=" + Math.random(),
            modal: true
        });
        $('#selectMasterDialog').dialog("open");
    }
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
        $.messager.progress();
    }
    function checkProductForm(){
        if($("#uid").val().length == 0){
            MsgBox.show("请选择掌门信息");
            return false;
        }
        if($("#pname").val().length == 0){
            MsgBox.show("请填写产品名称");
            $("#pname").focus();
            return false;
        }
        if($("#price").val().length == 0){
            MsgBox.show("请填写产品价格");
            $("#price").focus();
            return false;
        }
        var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if(!reg.test($("#price").val())){
            MsgBox.show("产品价格[" + $("#price").val() + "]格式不正确");
            return false;
        }
        if($("#derateProportion").val().length > 0){
            if($("#derateProportion").val() >99 || $("#derateProportion").val() < 0){
                MsgBox.show("余额支付减免[" +$("#derateProportion").val() + "]超出范围");
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
        return true;
    }
    function actionAfterSubmit(jsonObj){
        $.messager.progress('close');
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
                href:"<%=request.getContextPath() %>/product/fwdProductInfoPage?random_id=" + Math.random()+"&pid=" + pid,
                onLoad:function(){
                }
            });
        }else{
            MsgBox.show(resultObj.msg);
        }
    }
    function returnManageProductInAddProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageProductInAddProduct()">返回</a>
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
                <td><input class="dzm-noBorder-text" readonly="true" id="uid" name="uid">&nbsp&nbsp</td>
                <td>登录账号:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="loginname" name="loginname">&nbsp&nbsp</td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="name" name="name" /></td>
            </tr>
            <tr>
                <td>手机号码:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="mphone" name="mphone"/>&nbsp&nbsp</td>
                <td>性别:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="gender" name="gender" />&nbsp&nbsp</td>
                <td>备注信息:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="introduction" name="introduction" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
        <div style="text-align: right;margin-right: 80px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectMaster()">选择掌门</a>
            <div id="selectMasterDialog"></div>
        </div>
        <br/>
    </form>
    <form id="productForm" action="<%=request.getContextPath()%>/product/saveAddProduct"
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
                <td><input class="easyui-textbox"  id="pname" name="pname">
                    <input type="hidden" id="uidInProductForm" name="uid"></td>
                <td>类型:<span style="color:red">*</span></td>
                <td>
                    <select class="easyui-combobox" name="type" id="type" style="width:98%">
                        <option value="1">技能包</option>
                        <option value="2">经验包</option>
                    </select>
                </td>
                <td nowrap="nowrap">价格/年:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="price" name="price" data-options="prompt:'请输入金额，两位小数'" ></td>
            </tr>
            <tr>
                <td>余额支付减免:</td>
                <td><input class="easyui-textbox" id="derateProportion" data-options="prompt:'请输入百分比'"  name="derateProportion"/>%</td>
            </tr>
            <tr>
                <td>列表图片:<span style="color:red">*</span></td>
                <td colspan="2">
                        <input class="easyui-filebox" id="listimg" name="listimg" style="width:100%" accept="image/jpeg,image/png"
                               data-options="prompt:'请选择列表图片(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
                <td nowrap="nowrap" style="text-align: right">产品主图:<span style="color:red">*</span></td>
                <td colspan="2">
                    <input class="easyui-filebox" id="mainimg1" name="mainimg" style="width:100%" accept="image/jpeg,image/png"
                           data-options="prompt:'请选择产品主图(jpg、png)',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="5"><input class="easyui-textbox" id="prodcut_introduction"
                                       style="width:100%;height:80px;"
                                       name="introduction" data-options="multiline:true"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddProduct()">保存</a>
    </div>
</div>