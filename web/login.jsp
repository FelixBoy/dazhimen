<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <link type="text/css" rel="stylesheet" href="css/login.css">
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.md5.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js"></script>
  <title>系统登录</title>
  <script type="text/javascript">
    function onLogin(){
        if(!($("#userNameInput").val())){
            alert("请输入用户名");
            $("#userNameInput").focus();
            return;
        }
        if(!($("#userPwdInput").val())){
            alert("请输入密码");
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
                   alert(resultObj.msg);
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