<script type="text/javascript">
    $(function(){
        $('#masterViewForm').form({onLoadSuccess:function(){
            $("#headImgReal").attr("src",$("#headerimg").val()+"?random_id="+Math.random());
        }});
        $("#masterViewForm").form("load", "<%=request.getContextPath()%>/user/getMasterData.do" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random());
    });
</script>
<div style="width: 400px;margin: 0 auto;">
    <form id="masterViewForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">掌门信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">头像:</td>
                <td><img id="headImgReal" width="100px" height="100px"/>
                    <input class="dzm-noBorder-text" readonly="true" type="hidden" id="headerimg" name="headerimg" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">掌门ID:</td>
                <td><input class="dzm-noBorder-text" id="uidInViewMaster" name="uid"
                           style="width:300px"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">登录名:</td>
                <td><input class="dzm-noBorder-text" id="loginnameInViewMaster" name="loginname"
                           style="width:300px"/></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">姓名:</td>
                <td><input class="dzm-noBorder-text" id="nameInViewMaster" name="name" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">手机号码:</td>
                <td><input class="dzm-noBorder-text" id="mphoneInViewMaster" name="mphone" style="width:300px" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">身份:</td>
                <td><input class="dzm-noBorder-text" id="identityInViewMaster" name="identity" style="width:300px" data-options="prompt:'请输入掌门'" /></td>
            </tr>
            <tr>
                <td style="text-align: right" nowrap="nowrap">介绍:</td>
                <td><input class="dzm-noBorder-text" name="introduction" style="width:300px" /></td>
            </tr>
        </table>
    </form>
</div>