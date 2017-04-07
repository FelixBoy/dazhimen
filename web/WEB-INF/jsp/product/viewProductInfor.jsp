<script type="text/javascript">
    $(function(){
        $('#viewProductForm').form({onLoadSuccess:function(){
           $("#listImageReal").attr("src",$("#listimage").val());
            dealMainImages();
        }});
        $("#viewProductForm").form("load", "<%=request.getContextPath()%>/product/getProductInforById" +
            "?pid=<%=request.getAttribute("pid").toString()%>&random_id=" + Math.random());
    });
    function dealMainImages(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getMainImagesInforById" +
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
                    htmlArr.push("<tr>");
                    for(var i = 0; i < arrLength; i++){
                        htmlArr.push("<td>产品主图</td>");
                        htmlArr.push("<td align='left'>");
                        htmlArr.push("       <input type='hidden' id='mainimg"+i+"' value="+ arr[i].imageId +"/> ");
                        htmlArr.push("       <img src='" + arr[i].mainImage + "' width='120px' height='60px'/>");
                        htmlArr.push("</td>")
                    }
                    htmlArr.push("</tr>");
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
            href: "<%=request.getContextPath()%>/product/fwdViewMasterInforPage?uid="+$("#uid").val(),
            modal: true
        });
        $('#viewMasterDialog').dialog("open").dialog('setTitle','查看掌门信息');
    }
    function returnManageProduct(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/product/fwdManageProductPage?random_id="+Math.random(),
            onLoad:function(){
            }
        });
    }
</script>
<div style="text-align: left;">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="returnManageProduct()">返回</a>
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
                <td><input class="dzm-noBorder-text" readonly="true" id="pid" name="pid"></td>
                <td>名称:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="pname" name="pname"></td>
                <td>类型:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="type" name="type"></td>
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
                <td colspan="8" >
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
                <td>性别:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="gender" name="gender" /></td>
                <td>手机:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="mphone" name="mphone" /></td>
                <%--<td colspan="2">--%>
                    <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="viewMasterInfo()">完整掌门信息</a>--%>
                <%--</td>--%>
            </tr>
            <tr>
                <td>登录账户:</td>
                <td><input class="dzm-noBorder-text" readonly="true" id="loginname" name="loginname" /></td>
            </tr>
        </table>
        <div id="viewMasterDialog"></div>
    </form>
</div>