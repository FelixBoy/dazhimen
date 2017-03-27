<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css?_=<%=Math.random()%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css?_=<%=Math.random()%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css?_=<%=Math.random()%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dazhimen.css?_=<%=Math.random()%>">
  <link type="text/css" rel="stylesheet" href="css/login.css?_=<%=Math.random()%>">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dazhimen.css?_=<%=Math.random()%>" >
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js?_=<%=Math.random()%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js?_=<%=Math.random()%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.md5.js?_=<%=Math.random()%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js?_=<%=Math.random()%>"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/MsgBox.js?_=<%=Math.random()%>"></script>
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
        $.post("<%=request.getContextPath()%>/login/doLoginCheck?random_id="+Math.random(),
            {loginname:$("#userNameInput").val(), password:md5Pw},
            function(result){
               var resultObj = JSON.parse(result);
               if(resultObj.code == 'succ'){
                   location.href=resultObj.rediretUrl + "?random_id="+Math.random();
               }else{
                   MsgBox.show(resultObj.msg);
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
<img class="dw-logon-bg" src="image/login/login_bg_new.jpg">
<div class="dw-logon-form">
  <form id="loginform" action="<%=request.getContextPath()%>/login/doLoginCheck?random_id="+Math.random() method="post">
    <input type="text" id="userNameInput" class="dw-logon-form-loginname"/>
    <input type="password" id="userPwdInput" class="dw-logon-form-pwd"/>
    <input type="button" id="logonBtn" class="dw-logon-form-btnlogin" onclick="onLogin()"/>
  </form>
</div>
</body>
</html>