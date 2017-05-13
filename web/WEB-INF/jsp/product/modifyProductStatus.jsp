<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
<%
    String status = request.getAttribute("status").toString();
    if( status != null && !status.equals("")){%>
        $("#statusOldValue").val("<%=status%>");
        <%
        if(status.equals("1")){%>
            $("#groud").prop("checked", "checked");
        <%}
        if(status.equals("2")){%>
            $("#prepare").prop("checked", "checked");
        <%}if(status.equals("3")){%>
            $("#undergroud").prop("checked", "checked");
        <%}%>
    <%}%>
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
        $.ajax({
            url:"<%=request.getContextPath()%>/product/saveModifyProductStatus.do?random_id=" + Math.random()
            + "&pid=<%=request.getAttribute("pid")%>&status="+newStatus,
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyProductStatusDialog').dialog('close');
                $('#productList').datagrid('reload');
            }
        });
    }
</script>
<form id="modifyProductStatusForm" method="post">
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
