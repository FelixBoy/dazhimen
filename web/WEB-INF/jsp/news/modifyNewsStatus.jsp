<script>
        <%
            String status = request.getAttribute("status").toString();
        if( status != null && !status.equals("")){%>
            $("#statusOldValue").val("<%=status%>");
            <%
            if(status.equals("1")){%>
            $("#groud").prop("checked", "checked");
            <%}if(status.equals("0")){%>
            $("#undergroud").prop("checked", "checked");
            <%}%>
        <%}%>
    function modifyNewsStatus(index){
        var newStatus;
        if(index == '1'){
            newStatus = $("#groud").val();
        }
        if(index == '0'){
            newStatus = $("#undergroud").val();
        }
        var oldStatus = $("#statusOldValue").val();
        if(newStatus == oldStatus){
            return;
        }
        $.get("<%=request.getContextPath()%>/news/saveModifyNewsStatus.do?random_id=" + Math.random()
            + "&nid=<%=request.getAttribute("nid")%>&status="+newStatus,
            function(data){
                MsgBox.show(data);
                $('#modifyNewsStatusDialog').dialog('close');
                $('#newsList').datagrid('reload');
            }
        );
    }
</script>
<form id="modifyNewsStatusForm" method="post">
    <table cellpadding="5">
        <tr>
            <td colspan="4" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请修改新闻状态<span style="color:red">*</span></div>
                </div>
            </td>
        </tr>
        <tr>
            <td nowrap="nowrap">上架:</td>
            <td><input type="radio" id="groud" name="status" value="1" style="width: 60px;" onclick="modifyNewsStatus('1')">&nbsp&nbsp</td>
            <td nowrap="nowrap">下架:</td>
            <td><input type="radio" id="undergroud" name="status" style="width: 60px;" value="0" onclick="modifyNewsStatus('0')">&nbsp&nbsp</td>
            <input type="hidden" id="statusOldValue" />
        </tr>
    </table>
</form>