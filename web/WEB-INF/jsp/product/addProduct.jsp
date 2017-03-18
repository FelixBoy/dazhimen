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
        $("#masterInfoForm").submit();
    }
</script>
<div style="text-align:center;margin:0px auto;">
    <form id="masterInfoForm" action="<%=request.getContextPath()%>/product/saveAddProduct"
          enctype="multipart/form-data" method="post">
        <table cellpadding="5">
            <tr>
                <td>掌门ID:</td>
                <td><input class="easyui-textbox" readonly="true" id="uid" name="uid"></td>
                <td>登录名:</td>
                <td><input class="easyui-textbox" readonly="true" id="loginname" name="loginname"></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input class="easyui-textbox" readonly="true" id="name" name="name" /></td>
                <td>手机号码:</td>
                <td><input class="easyui-textbox" readonly="true" id="mphone" name="mphone"/></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td><input class="easyui-textbox" readonly="true" id="gender" name="gender" /></td>
                <td>备注:</td>
                <td><input class="easyui-textbox" readonly="true" name="remarks" data-options="multiline:true" style="height:50px"/></td>
            </tr>
        </table>
        <div style="text-align:right;padding-right:50px;padding-top:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="selectMaster()">选择掌门</a>
            <div id="selectMasterDialog"></div>
        </div>

        <table cellpadding="5">
            <tr>
                <td>产品类型:</td>
                <td><input class="easyui-textbox"  id="type" name="type"></td>
                <td>产品名称:</td>
                <td><input class="easyui-textbox"  id="pname" name="pname"></td>
            </tr>
            <tr>
                <td>价格:</td>
                <td><input class="easyui-textbox" id="price" name="price" /></td>
                <td>余额支付减免:</td>
                <td><input class="easyui-textbox" id="derateProportion" name="derateProportion"/></td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="3"><input class="easyui-textbox" id="introduction" style="width:85%;height:60px;"
                                       name="introduction" data-options="multiline:true"/></td>
            </tr>
            <tr>
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
                <td>列表图片:</td>
                <td colspan="3"><input class="easyui-filebox" id="listimg" name="listimg" style="width:85%" data-options="prompt:'请选择列表图片'"></td>
            </tr>
            <tr>
                <td>产品主图一:</td>
                <td colspan="3"><input class="easyui-filebox" id="mainimg1" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图一'"></td>
            </tr>
            <tr>
                <td>产品主图二:</td>
                <td colspan="3"><input class="easyui-filebox" id="mainimg2" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图二'"></td>
            </tr>
            <tr>
                <td>产品主图三:</td>
                <td colspan="3"><input class="easyui-filebox" id="mainimg3" name="mainimg" style="width:85%" data-options="prompt:'请选择产品主图三'"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <div style="text-align:left;padding-left:210px;padding-top:5px">
                        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addProductMainPage()">添加产品主图</a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddProduct()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
    </div>
</div>
