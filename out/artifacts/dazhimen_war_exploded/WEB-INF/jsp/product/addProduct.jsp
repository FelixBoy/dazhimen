<script type="text/javascript">
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
        return true;
    }
    function actionAfterSubmit(jsonObj){
        alert("innn");
        var resultObj = JSON.parse(jsonObj);
        if(!resultObj){
            return;
        }
        var code = resultObj.code;
        if(code == '200'){
            var msg = resultObj.msg;
            var pid = resultObj.pid;
            alert("pid");
            MsgBox.show(msg);
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/product/fwdProductInfoPage?random_id=" + Math.random()+"&pid=" + pid,
                onLoad:function(){
                }
            });
        }else{
            MsgBox.show("上传商品失败。"+resultObj.msg);
        }
    }
    function clearForm(){
        var pid = "p17032300042";
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdProductInfoPage?random_id=" + Math.random()+"&pid=" + pid,
            onLoad:function(){
            }
        });
    }
    function addMainImage(){
        MsgBox.show("功能正在开发，敬请期待");
    }
</script>
<div style="margin:0px auto;width: 810px;">
    <form id="productForm" action="<%=request.getContextPath()%>/product/saveAddProduct"
          enctype="multipart/form-data" method="post">
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
                <td><input class="dzm-noBorder-text" readonly="true" name="remarks" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
        <div style="text-align: right;margin-right: 80px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectMaster()">选择掌门</a>
            <div id="selectMasterDialog"></div>
        </div>
        <br/>
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
                <td>类型:<span style="color:red">*</span></td>
                <td>
                    <select class="easyui-combobox" name="type" id="type" style="width:98%">
                        <option value="1">技能包</option>
                        <option value="2">经验包</option>
                    </select>
                </td>
                <td>名称:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox"  id="pname" name="pname"></td>
                <td>价格/年:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="price" name="price" data-options="prompt:'请输入金额，两位小数'" ></td>
            </tr>
            <tr>
                <td>余额支付减免:</td>
                <td><input class="easyui-textbox" id="derateProportion" name="derateProportion"/></td>
                <td>首页轮播:</td>
                <td><input type="checkbox" id="indexplay" name="indexplay" value="1"/></td>
                <td>热卖排序:</td>
                <td><select class="easyui-combobox" name="indexosrt" id="indexsort" style="width:140px;">
                    <option value="0">按上架时间排序</option>
                    <option value="1">排序1</option>
                    <option value="2">排序2</option>
                    <option value="3">排序3</option>
                    <option value="4">排序4</option>
                    <option value="5">排序5</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="4"><input class="easyui-textbox" id="introduction"
                                       style="width:90%;height:60px;"
                                       name="introduction" data-options="multiline:true"/></td>
            </tr>
            <tr>
                <td>列表图片:<span style="color:red">*</span></td>
                <td colspan="4">
                        <input class="easyui-filebox" id="listimg" name="listimg" style="width:85%"
                               data-options="prompt:'请选择列表图片',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td>产品主图-1:<span style="color:red">*</span></td>
                <td colspan="4">
                    <input class="easyui-filebox" id="mainimg1" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图一',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td>产品主图-2:<span style="color:red">*</span></td>
                <td colspan="4">
                    <input class="easyui-filebox" id="mainimg2" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图二',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
            </tr>
            <tr>
                <td>产品主图-3:<span style="color:red">*</span></td>
                <td colspan="4">
                    <input class="easyui-filebox" id="mainimg3" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图三',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
                </td>
                <td><a href="#" class="easyui-linkbutton" style="text-align: left" data-options="iconCls:'icon-add'" onclick="addMainImage()">添加主图</a></td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddProduct()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">测试上传完成</a>
    </div>
</div>