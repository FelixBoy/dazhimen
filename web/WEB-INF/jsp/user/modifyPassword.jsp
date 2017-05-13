<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %>
<%@ page import="com.google.gson.Gson" %><%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script type="text/javascript">
    $(function () {
        $.extend($.fn.validatebox.defaults.rules, {
            maxLenWithoutTrim:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber(value) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            numberAndLetter:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9a-zA-Z]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为字母或数字组合'
            }
        });
        $('#oldpassword').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入原始密码'
        });
        $('#newpassword').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入新密码'
        });
        $('#newpasswordcheck').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请再次输入新密码'
        });
    });
    function checkModifyPassWordFormBeforeSubmit() {
        if($("#oldpassword").val().length == 0){
            MsgBox.show("原始密码不能为空");
            return false;
        }
        var reg_oldpassword = /^[0-9a-zA-Z]*$/g;
        if(!reg_oldpassword.test($("#oldpassword").val())){
            MsgBox.show("原始密码格式不正确，只能为字母或数字组合");
            return false;
        }
        if($("#newpassword").val().length == 0){
            MsgBox.show("新密码不能为空");
            return false;
        }
        var reg_newpassword = /^[0-9a-zA-Z]*$/g;
        if(!reg_newpassword.test($("#newpassword").val())){
            MsgBox.show("新密码格式不正确，只能为字母或数字组合");
            return false;
        }
        if($("#newpasswordcheck").val().length == 0){
            MsgBox.show("新密码确认不能为空");
            return false;
        }
        var reg_newpasswordcheck = /^[0-9a-zA-Z]*$/g;
        if(!reg_newpasswordcheck.test($("#newpasswordcheck").val())){
            MsgBox.show("新密码确认格式不正确，只能为字母或数字组合");
            return false;
        }
        if($("#newpasswordcheck").val() != $("#newpassword").val()){
            MsgBox.show("新密码两次输入不一致");
            return false;
        }
        return true;
    }
    function submitModifyPasswordForm() {
        if(!checkModifyPassWordFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveModifyPassword.do",
            data:$('#modifyPasswordForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyPasswordDialog').dialog('close');
            }
        });
    }
</script>
<div  style="width: 580px;margin: 0 auto;text-align: center;">
    <form id="modifyPasswordForm">
    <table cellpadding="5">
        <tr>
            <td colspan="4" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">用户信息</div>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: right"  nowrap="nowrap">ID:</td>
            <td><input class="dzm-noBorder-text" readonly id="uid" value="<%=userBean.getUid()%>" name="uid" style="width:200px"></td>
            <td style="text-align: right"  nowrap="nowrap">登录名:</td>
            <td><input class="dzm-noBorder-text" readonly id="loginnameInModifyPassword" value="<%=userBean.getLoginname()%>" name="loginname" style="width:200px"/></td>
        </tr>
        <tr>
            <td style="text-align: right" nowrap="nowrap">姓名:</td>
            <td><input class="dzm-noBorder-text" readonly id="nameInModifyPassword" name="name" value="<%=userBean.getUname()%>" style="width:200px"/></td>
            <td style="text-align: right"  nowrap="nowrap">身份类型:</td>
            <td>
                <input class="dzm-noBorder-text" readonly id="utypestr" name="type" value="<%=userBean.getUtypeStr()%>" style="width:200px"/>
            </td>
        </tr>
    </table>
    <div  style="width: 400px;margin: 0 auto;">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="3" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改密码</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">原始密码:<span style="color:red">*</span></td>
                <td><input id="oldpassword" type="password"  name="oldpassword" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">新密码:<span style="color:red">*</span></td>
                <td><input  id="newpassword" type="password" name="newpassword" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">新密码确认:<span style="color:red">*</span></td>
                <td><input id="newpasswordcheck"  type="password" name="newpasswordcheck" style="width:300px"></td>
            </tr>
        </table>
    </form>
    </div>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyPasswordForm()">保存</a>
    </div>
</div>