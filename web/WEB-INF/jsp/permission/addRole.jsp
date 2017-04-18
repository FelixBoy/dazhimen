<script type="text/javascript">
    function selectAllPermission(){
        $("input[id^='per_']").prop("checked", true);
    }
    function cancelSelectAllPermission(){
        $("input[id^='per_']").prop("checked", false);
    }
    function checkAddRoleFormBeforeSubmit(){
        if($("#roleNameInAddRole").val().length == 0){
            MsgBox.show("请填写角色名称");
            return false;
        }
        return true;
    }
    function submitAddRoleForm(){
        if(!checkAddRoleFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/permission/saveAddRole",
            data:$('#addRoleForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#addRoleDialog').dialog('close');
                $('#roleList').datagrid('reload');
            }
        });
    }
</script>
<div style="width: 480px;margin: 0 auto;">
    <form id="addRoleForm">
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div>
                        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                            填写角色信息
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">角色名称:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="roleNameInAddRole" name="name"
                           style="width:300px" data-options="prompt:'请输入角色名称'" /></td>
            </tr>
            <tr>
                <td style="text-align: right">可以分配给掌门:</td>
                <td><input type="checkbox" id="ismastercanown" name="ismastercanown" style="width: 100%;" value="1"/></td>
            </tr>
            <tr>
                <td style="text-align: right">介绍:</td>
                <td style="text-align: left;"><input class="easyui-textbox" name="introduction" data-options="multiline:true" style="width:300px;height:60px"/></td>
            </tr>
        </table>
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="4" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">配置权限</div>
                        <div style="float: left;height: 100%;font: bold 14px/45px '宋体';margin-left: 10px;">
                            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="selectAllPermission()">全选</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="cancelSelectAllPermission()">取消全选</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">产品管理:</td>
                <td><input type="checkbox" id="per_product_manage" name="rolepermission" style="width: 120px;" value="product_manage"/></td>
                <td style="text-align: right"  nowrap="nowrap">新闻管理:</td>
                <td><input type="checkbox" id="per_news_manage" name="rolepermission" style="width: 120px;" value="news_manage"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">会员查询:</td>
                <td><input type="checkbox" id="per_customer_query" name="rolepermission" style="width: 120px;" value="customer_query"/></td>
                <td style="text-align: right"  nowrap="nowrap">充值查询:</td>
                <td><input type="checkbox" id="per_recharge_query" name="rolepermission" style="width: 120px;"  value="recharge_query"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">订单查询:</td>
                <td><input type="checkbox" id="per_order_query" name="rolepermission" style="width: 120px;" value="order_query"/></td>
                <td style="text-align: right"  nowrap="nowrap">首页轮播:</td>
                <td><input type="checkbox" id="per_indexplay_manage" name="rolepermission" style="width: 120px;"  value="indexplay_manage"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">首页排序:</td>
                <td><input type="checkbox" id="per_indexsort_manange" name="rolepermission" style="width: 120px;" value="indexsort_manange"/></td>
                <td style="text-align: right"  nowrap="nowrap">掌门管理:</td>
                <td><input type="checkbox" id="per_master_manage" name="rolepermission" style="width: 120px;" value="master_manage"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">管理员管理:</td>
                <td><input type="checkbox" id="per_admin_manage" name="rolepermission" style="width: 120px;" value="admin_manage"/></td>
                <td style="text-align: right"  nowrap="nowrap">权限管理:</td>
                <td><input type="checkbox" id="per_permission_manage" name="rolepermission" style="width: 120px;" value="permission_manage"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddRoleForm()">保存</a>
    </div>
</div>