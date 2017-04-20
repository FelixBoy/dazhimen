<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %>
<%@ page import="com.google.gson.Gson" %><%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<div  style="width: 580px;margin: 0 auto;text-align: center;">
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
    <form id="modifyPasswordForm">
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
                <td><input class="easyui-textbox" id="oldpassword" name="oldpassword" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">新密码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="newpassword" name="newpassword" style="width:300px"></td>
            </tr>
            <tr>
                <td style="text-align: right"  nowrap="nowrap">新密码确认:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" id="newpasswordcheck" name="newpasswordcheck" style="width:300px"></td>
            </tr>
        </table>
    </form>
    </div>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyAdminForm()">保存</a>
    </div>
</div>