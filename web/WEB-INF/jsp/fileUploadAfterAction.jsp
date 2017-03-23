<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%
    String parameters=null;
    if(pageContext.findAttribute("parameters")!=null){
        parameters = pageContext.findAttribute("parameters").toString();
    }
    if (parameters != null && !parameters.equalsIgnoreCase("")) {
        parameters = parameters.replaceAll("\'","【");
        parameters = parameters.replaceAll("\'","】");
        parameters = parameters.replaceAll("\\\\","\\\\\\\\");
        parameters = parameters.replaceAll("\n","\\\\n");
        parameters = parameters.replaceAll("\r","\\\\r");
        parameters = parameters.replaceAll("\t","\\\\t");
%>
<script id="script_message_alert" type="text/javascript" defer="defer">
    <%
    %>
        parent.actionAfterSubmit('<%=parameters%>');
    <%
        }
    %>
</script>