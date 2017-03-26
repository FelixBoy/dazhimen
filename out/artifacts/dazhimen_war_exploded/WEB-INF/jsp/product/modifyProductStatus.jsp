<script>
<%
    String status = request.getAttribute("status").toString();
    if( status != null && !status.equals("")){%>
        $("#statusOldValue").val("<%=status%>");
        <%
        if(status.equals("1")){%>
            $("#groud").attr("checked", "checked");
        <%}
        if(status.equals("2")){%>
            $("#prepare").attr("checked", "checked");
        <%}if(status.equals("3")){%>
            $("#undergroud").attr("checked", "checked");
        <%}%>
    <%}%>
</script>
<script>
    function modifyStatus(index){
        var newStatus;
        if(index == '1'){
            newStatus = $("#groud").val();
        }
        if(index == '2'){
            newStatus = $("#prepare").val();
        }
        if(index == '3'){
            newStatus = $("#undergroud").val();
        }
        var oldStatus = $("#statusOldValue").val();
        if(newStatus == oldStatus){
            return;
        }
        $.get("<%=request.getContextPath()%>/product/saveModifyProductStatus?random_id=" + Math.random()
                + "&pid=<%=request.getAttribute("pid")%>&status="+newStatus,
            function(data){
                MsgBox.show(data);
                $('#modifyProductStatusDialog').dialog('close');		// close the dialog
                $('#productList').datagrid('reload');
            }
        );
    }
</script>
<form id="modifyProductStatusForm" action="<%=request.getContextPath()%>/product/modifyProductStatus" method="post">
    <table cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请修改产品状态<span style="color:red">*</span></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>上架:</td>
            <td><input type="radio" id="groud" name="status" value="1" onclick="modifyStatus('1')">&nbsp&nbsp</td>
            <td>预告:</td>
            <td><input type="radio" id="prepare" name="status" value="2" onclick="modifyStatus('2')">&nbsp&nbsp</td>
            <td>下架:</td>
            <td><input type="radio" id="undergroud" name="status" value="3" onclick="modifyStatus('3')">&nbsp&nbsp</td>
            <input type="hidden" id="statusOldValue" />
        </tr>
    </table>
</form>
