<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js"></script>
  <title>系统登录</title>
  <script type="text/javascript">
    function onLogin(){
        $.post("<%=request.getContextPath()%>/login/doLoginCheck?random_id="+Math.random(),

            {loginname:$("#userNameInput").val(), password:$("#userPwdInput").val()},

            function(result){
              location.href=result+"?random_id="+Math.random();
            });
    }
  </script>
</head>
<body>
<form id="formsss">
  登录名<input type="text" id="userNameInput" />
  密码<input type="password" id="userPwdInput" />
  <input type="submit" id="logonBtn" value="提交" onclick="onLogin()"/>
</form>
</body>
</html>