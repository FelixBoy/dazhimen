<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%
    String message = null;
    String parameters=null;
    if (pageContext.findAttribute("message") != null) {
        message = pageContext.findAttribute("message").toString();
        if(pageContext.findAttribute("parameters")!=null){
            parameters = pageContext.findAttribute("parameters").toString();
        }
    }
    if (message != null && !message.equalsIgnoreCase("")) {
        message=message.replaceAll("\'","【");
        message=message.replaceAll("\'","】");
        message=message.replaceAll("\\\\","\\\\\\\\");
        message=message.replaceAll("\n","\\\\n");
        message=message.replaceAll("\r","\\\\r");
        message=message.replaceAll("\t","\\\\t");
%>
<script id="script_message_alert" type="text/javascript" defer="defer">
    <%
        if(parameters!=null&&!parameters.equalsIgnoreCase("")){
    %>
        parent.actionAfterSubmit('<%=parameters%>');
    <%
        }
    %>
</script>
<%
    }
%>