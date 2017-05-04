<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.Constant" %>
<script type="text/javascript">
    $(function(){
        $('#viewProductForm').form({onLoadSuccess:function(){
           $("#listImageReal").attr("src",$("#listimage").val() + "?rondomid=" + Math.random());
            dealMainImages();
        }});
        $("#viewProductForm").form("load", "<%=request.getContextPath()%>/product/getProductInforById.do" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function dealMainImages(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getMainImagesInforById.do" +
                "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                var arr = JSON.parse(data);
                var arrLength = arr.length;
                if(!arrLength){
                    return;
                }
                var rowLength = Math.floor(arrLength / 3);
                if(rowLength <= 1){
                    var htmlArr = [];
                    for(var i = 0; i < arrLength; i++){
                        htmlArr.push("<td align='right'>产品主图:</td>");
                        htmlArr.push("<td align='left' colspan='3'>");
                        htmlArr.push("       <input type='hidden' id='mainimg"+i+"' value="+ arr[i].imageId +"/> ");
                        htmlArr.push("       <img align='left' src='" + arr[i].mainImage + "?randomid=" + Math.random() +"' width='200px' height='100px'/>");
                        htmlArr.push("</td>")
                    }
                    $(htmlArr.join("")).insertAfter("#listimgtr");
                }
            }
        });
    }
    function viewMasterInfo(){
        $('#viewMasterDialog').dialog({
            title: '查看掌门信息',
            width: 600,
            height: 400,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/product/fwdViewMasterInforPage.do?uid="+$("#uid").val(),
            modal: true
        });
        $('#viewMasterDialog').dialog("open").dialog('setTitle','查看掌门信息');
    }
    function returnManageProductInViewProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage.do?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
</script>
<div style="text-align: left;">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageProductInViewProduct()">返回</a>
</div>
<div style="margin:0px auto;width: 950px">
    <form id="viewProductForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="8" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">产品信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="pid" name="pid"></td>
                <td>名称:</td>
                <td><input class="dzm-noBorder-text" readonly id="pname" name="pname"></td>
                <td>类型:</td>
                <td><input class="dzm-noBorder-text" readonly id="type" name="type"></td>
                <td width="50px" nowrap="nowrap">价格:</td>
                <td><input class="dzm-noBorder-text" readonly id="price" name="price"></td>
            </tr>
            <tr>
                <td class="form-label-cell">余额支付减免:</td>
                <td><input class="dzm-noBorder-text" readonly  id="derateProportion" name="derateProportion"/></td>
                <%
                    HttpSession sessionObj = request.getSession(false);
                    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
                    if(userBean.getUtype().equals(Constant.userType_Admin)){
                %>
                <td nowrap="nowrap">首页轮播:</td>
                <td><input class="dzm-noBorder-text" readonly id="indexplay" name="indexPlay"/></td>
                <td nowrap="nowrap">首页排序:</td>
                <td><input class="dzm-noBorder-text" readonly id="indexsort" name="indexSort"/></td>
                <td colspan="2"></td>
                <%}%>
            </tr>
            <tr>
                <td nowrap="nowrap">列表图片:</td>
                <td id="listimgtr" colspan="2"><input class="dzm-noBorder-text" type="hidden" id="listimage" name="listImage" />
                    <img id="listImageReal" width="100px" height="100px"/></td>
            </tr>
            <tr>
                <td>介绍:</td>
                <td colspan="5"><textarea readonly style="width: 90%;overflow-y:auto;border: 1px solid #CCCCCC !important;" id="introduction" name="introduction" rows="5" /></td>
            </tr>
        </table>
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="8" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">责任掌门信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly id="uid" name="uid"></td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly id="name" name="uname" /></td>
                <td>性别:</td>
                <td><input class="dzm-noBorder-text" readonly id="gender" name="gender" /></td>
                <td>手机:</td>
                <td><input class="dzm-noBorder-text" readonly id="mphone" name="mphone" /></td>
            </tr>
            <tr>
                <td>登录账户:</td>
                <td><input class="dzm-noBorder-text" readonly id="loginname" name="loginname" /></td>
            </tr>
        </table>
        <div id="viewMasterDialog"></div>
    </form>
</div>