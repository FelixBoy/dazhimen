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
    function submitAddProduct(){
        if(!checkProductForm()){
            return;
        }
        $("#productForm").submit();
    }
    function checkProductForm(){
        if($("#uid").val().length == 0){
            alert("请选择掌门后新增");
            return false;
        }
    }
    function addMainImage(){
        alert("功能正在开发");
    }
</script>
<div style="margin:0px auto;width: 800px;">
    <form id="productForm" action="<%=request.getContextPath()%>/product/saveAddProduct"
          enctype="multipart/form-data" method="post">
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请选择掌门</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>掌门ID:</td>
                <td><input class="easyui-textbox" readonly="true" id="uid" name="uid"></td>
                <td>登录名:</td>
                <td><input class="easyui-textbox" readonly="true" id="loginname" name="loginname"></td>
                <td>姓名:</td>
                <td><input class="easyui-textbox" readonly="true" id="name" name="name" /></td>
            </tr>
            <tr>
                <td>手机:</td>
                <td><input class="easyui-textbox" readonly="true" id="mphone" name="mphone"/></td>
                <td>性别:</td>
                <td><input class="easyui-textbox" readonly="true" id="gender" name="gender" /></td>
                <td>备注:</td>
                <td><input class="easyui-textbox" readonly="true" name="remarks" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
        <div style="text-align: right;margin-right: 80px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="selectMaster()">选择掌门</a>
            <div id="selectMasterDialog"></div>
        </div>
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
                <td>类型:</td>
                <td><input class="easyui-textbox"  id="type" name="type"></td>
                <td>名称:</td>
                <td><input class="easyui-textbox"  id="pname" name="pname"></td>
                <td>价格:</td>
                <td><input class="easyui-textbox" id="price" name="price" /></td>
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
                <td>列表图片:</td>
                <td colspan="4"><input class="easyui-filebox" id="listimg" name="listimg" style="width:85%" data-options="prompt:'请选择列表图片',buttonText:'&nbsp;选&nbsp;择&nbsp;'"></td>
            </tr>
            <tr>
                <td>产品主图-1:</td>
                <td colspan="4"><input class="easyui-filebox" id="mainimg1" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图一',buttonText:'&nbsp;选&nbsp;择&nbsp;'"></td>
            </tr>
            <tr>
                <td>产品主图-2:</td>
                <td colspan="4"><input class="easyui-filebox" id="mainimg2" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图二',buttonText:'&nbsp;选&nbsp;择&nbsp;'"></td>
            </tr>
            <tr>
                <td>产品主图-3:</td>
                <td colspan="4"><input class="easyui-filebox" id="mainimg3" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图三',buttonText:'&nbsp;选&nbsp;择&nbsp;'"></td>
                <td><a href="#" class="easyui-linkbutton" style="text-align: left" data-options="iconCls:'icon-add'" onclick="addMainImage()">添加主图</a></td>
            </tr>
        </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddProduct()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
    </div>
</div>