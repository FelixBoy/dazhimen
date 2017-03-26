<script type="text/javascript">
    $(function(){
        $("#viewMasterForm").form("load", "<%=request.getContextPath()%>/product/getMasterInfor" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random());
    });
</script>
<div style="padding:10px 60px 20px 60px">
    <form id="viewMasterForm">
        <table cellpadding="5">
            <tr>
                <td>掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="uid" name="uid"></td>
            </tr>
            <tr>
                <td>登录名:</td>
                <td><input class="dzm-noBorder-text" readonly="true"  id="loginname" name="loginname" /></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="name" name="name" /></td>
            </tr>
            <tr>
                <td>手机号码:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="mphone" name="mphone" /></td>
            </tr>
            <tr>
                <td>性别:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="gender" name="gender" /></td>
            </tr>
            <tr>
            <tr>
                <td>生成日期:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="createDatestr" name="createDatestr" /></td>
            </tr>
            </tr>
        </table>
    </form>
</div>