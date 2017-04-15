<%@ page import="util.Constant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css?_=<%=Constant.FrontEndVersion%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css?_=<%=Constant.FrontEndVersion%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css?_=<%=Constant.FrontEndVersion%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dazhimen.css?_=<%=Constant.FrontEndVersion%>">
  <link type="text/css" rel="stylesheet" href="css/login.css?_=<%=Constant.FrontEndVersion%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dazhimen.css?_=<%=Constant.FrontEndVersion%>" >
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js?_=<%=Constant.FrontEndVersion%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js?_=<%=Constant.FrontEndVersion%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.md5.js?_=<%=Constant.FrontEndVersion%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js?_=<%=Constant.FrontEndVersion%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/MsgBox.js?_=<%=Constant.FrontEndVersion%>"></script>
  <title>系统登录</title>
  <script type="text/javascript">
    function onLogin(){
        if(!($("#userNameInput").val())){
            MsgBox.show("请输入用户名");
            $("#userNameInput").focus();
            return;
        }
        if(!($("#userPwdInput").val())){
            MsgBox.show("请输入密码");
            $("#userPwdInput").focus();
            return;
        }
        var md5Pw = $.md5($("#userNameInput").val() + $("#userPwdInput").val());
        $.ajax({
            url:"<%=request.getContextPath()%>/login/doLoginCheck?random_id="+Math.random(),
            data: {loginname:$("#userNameInput").val(), password:md5Pw},
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                var resultObj = JSON.parse(data);
                location.href=resultObj.rediretUrl + "?random_id="+Math.random();
            }
        });
    }
    $(function(){
        $('#userNameInput').bind('keypress',function(event){
            if(event.keyCode == 13)
            {
                onLogin();
            }
        });
        $('#userPwdInput').bind('keypress',function(event){
            if(event.keyCode == 13)
            {
                onLogin();
            }
        });
    });

  </script>
</head>
<body>
<%-- 背景图片 --%>
<img class="dw-logon-bg" src="image/login/login_bg_3.jpg">
<div class="dw-logon-form">
  <form id="loginform" action="<%=request.getContextPath()%>/login/doLoginCheck?random_id="+Math.random() method="post">
    <input type="text" id="userNameInput" class="dw-logon-form-loginname"/>
    <input type="password" id="userPwdInput" class="dw-logon-form-pwd"/>
    <input type="button" id="logonBtn" class="dw-logon-form-btnlogin" onclick="onLogin()"/>
  </form>
</div>
</body>
</html>