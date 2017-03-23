<%@ page import="dazhimen.bg.bean.ViewMainImageBean" %>
<%@ page import="java.util.List" %>
<script type="text/javascript">
    $(function(){
        $('#viewProductForm').form({onLoadSuccess:function(){
           $("#listImageReal").attr("src",$("#listimage").val());
            dealMainImages();
        }});
        $("#viewProductForm").form("load", "<%=request.getContextPath()%>/product/getProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function viewMasterInfo(){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function dealMainImages(){
        $.get("<%=request.getContextPath()%>/product/getMainImagesInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random()
            ,function(data,status){
                var arr = JSON.parse(data);
                var arrLength = arr.length;
                if(!arrLength){
                    return;
                }
                for(var i = 0; i < arrLength; i++){
                    $("<tr><td>产品主图-" + (i+1) + "</td>"
                        + "<td><input type='hidden' id='mainimg"+i+"' value="+ arr[i].imageId +"/></td>"
                        + "<td colspan='6'><img src='" + arr[i].mainImage + "' width='60px' height='60px'/></td>"
                        + "</tr>").insertAfter("#listimgtr");
                }
        });
    }
</script>
<div style="margin:0px auto;width: 950px;border: 1px solid red">
    <form id="viewProductForm" action="<%=request.getContextPath()%>/product/saveAddProduct"
          enctype="multipart/form-data" method="post">
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
                <td><input class="dzm-noBorder-text" readonly="true" id="pid" name="pid"></td>
                <td>类型:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="type" name="type"></td>
                <td>名称:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="pname" name="pname"></td>
                <td width="50px">价格:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="price" name="price"></td>
            </tr>
            <tr>
                <td class="form-label-cell">余额支付减免:</td>
                <td><input class="dzm-noBorder-text" readonly="true"  id="derateProportion" name="derateProportion"/></td>
                <td>首页轮播:</td>
                <td><input class="dzm-noBorder-text" readonly="true" style="font-size: large" id="indexplay" name="indexPlay"/></td>
                <td>热卖排序:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="indexsort" name="indexSort"/></td>
                <td colspan="2"></td>
            </tr>
            <tr id="listimgtr">
                <td>列表图片:</td>
                <td><input class="dzm-noBorder-text" readonly="true" type="hidden" id="listimage" name="listImage" />
                    <img id="listImageReal" width="60px" height="60px"/></td>
                <td>介绍:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="introduction" name="introduction" /></td>
                <td></td>
            </tr>
        </table>
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">责任掌门信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>掌门ID:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="uid" name="uid"></td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="name" name="uname" /></td>
                <td>手机:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="mphone" name="mphone" /></td>
                <td colspan="2">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="viewMasterInfo()">完整掌门信息</a>
                </td>
            </tr>
        </table>
    </form>
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">编辑课程信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>课程ID:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="couid" name="uid"></td>
                <td>姓名:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="couname" name="uname" /></td>
                <td colspan="2">查看详细信息按钮</td>
            </tr>
        </table>
</div>