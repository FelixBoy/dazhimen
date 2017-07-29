<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        buyCount:{
            validator: function (value, param) {
                var result = false;
               if(value >= 0 && value <= 999999){
                   result = true;
               }
                return result;
            },
            message:'格式错误，请输入0-999999'
        }
    });
    $('#buycount').textbox({
        required: true,
        validType: ['buyCount'],
        missingMessage:'输入范围0-999999',
        prompt:'请输入已购人数'
    });
    function checkMoidfyBuyCountFormBeforeSubmit(){
        if($.trim($("#buycount").val()).length == 0){
            MsgBox.show("请输入购买人数");
            return false;
        }
        if(!($.trim($("#buycount").val()) >= 0 && $.trim($("#buycount").val()) <= 999999)){
            MsgBox.show("购买人数格式错误，请输入0-999999");
            return false;
        }
        return true;
    }
    function submitModifyBuyCountForm(){
        if(!checkMoidfyBuyCountFormBeforeSubmit()){
            return;
        }
        var buycount = $("#buycount").val();
        $.ajax({
            url:"<%=request.getContextPath()%>/product/saveModifyBuyCount.do?random_id=" + Math.random()
            + "&pid=<%=request.getAttribute("pid")%>&buycount="+buycount,
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyBuyCountDialog').dialog('close');
                $('#productList').datagrid('reload');
            }
        });
    }

</script>
<form id="modifyBuyCountForm" method="post">
    <table cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请修改已购人数<span style="color:red">*</span></div>
                </div>
            </td>
        </tr>
        <tr>
        <tr>
            <td style="text-align: right">已购人数:</td>
            <td><input id="buycount" name="buycount" style="width:180px"></td>
        </tr>
        </tr>
    </table>
</form>
<div style="text-align:center;padding:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyBuyCountForm()">保存</a>
</div>