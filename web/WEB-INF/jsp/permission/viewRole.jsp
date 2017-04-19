<script type="text/javascript">
    $(function(){
        $("#viewRoleForm").form("load", "<%=request.getContextPath()%>/permission/getRoleInfor" +
            "?rid=<%=request.getAttribute("rid").toString()%>&randomid=" + Math.random());
    });
</script>
<div style="width: 480px;margin: 0 auto;">
    <form id="viewRoleForm">
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div>
                        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                            角色基本信息
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">角色Id:</td>
                <td><input class="dzm-noBorder-text" readonly name="rid" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">角色名称:</td>
                <td><input class="dzm-noBorder-text" readonly name="name" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">可以分配给掌门:</td>
                <td><input class="dzm-noBorder-text" readonly name="ismastercanown" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">介绍:</td>
                <td style="text-align: left;"><textarea readonly style="width: 100%;overflow-y:auto;border: 1px solid #CCCCCC !important;" id="introduction" name="introduction" rows="5" /></td>
            </tr>
        </table>
    </form>
</div>
<div style="width: 480px;margin: 0 auto;">
    <table cellpadding="5">
        <tr>
            <td style="width:430px">
                <div class="formTitle" style="background-color:#f2f2f2;width: 100%;">
                    <div class="formTitle-icon">
                    </div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        角色对应权限模块
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div style="width:400px;margin: 0 auto;">
    <table id="roleModuleList" class="easyui-datagrid" style="width: auto;height: 230px;"
           url="<%=request.getContextPath()%>/permission/queryIrRoleModule?rid=<%=request.getAttribute("rid").toString()%>&randomid=" + Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'name'" width="100%">模块名称</th>
        </tr>
        </thead>
    </table>
    </div>
</div>