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
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改产品信息</div>
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
    </form>
</div>