<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        viewCount:{
            validator: function (value, param) {
                var result = false;
                if(value >= 0 && value <= 999999){
                    result = true;
                }
                return result;
            },
            message:'格式错误，请输入0-9999999999'
        }
    });
    $('#viewcount').textbox({
        required: true,
        validType: ['viewCount'],
        missingMessage:'输入范围0-9999999999',
        prompt:'请输入已读人数'
    });
    function checkMoidfyViewCountFormBeforeSubmit(){
        if($.trim($("#viewcount").val()).length == 0){
            MsgBox.show("请输入已读人数");
            return false;
        }
        if(!($.trim($("#viewcount").val()) >= 0 && $.trim($("#viewcount").val()) <= 9999999999)){
            MsgBox.show("已读人数格式错误，请输入0-9999999999");
            return false;
        }
        return true;
    }
    function submitModifyViewCountForm(){
        if(!checkMoidfyViewCountFormBeforeSubmit()){
            return;
        }
        var viewcount = $("#viewcount").val();
        $.ajax({
            url:"<%=request.getContextPath()%>/product/saveModifyViewCount.do?random_id=" + Math.random()
            + "&courseid=<%=request.getAttribute("courseid")%>&viewcount="+viewcount,
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyViewCountDialog').dialog('close');
                $('#courseList').datagrid('reload');
            }
        });
    }
</script>
<form id="modifyViewCountForm" method="post">
    <table cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">请修改已读人数<span style="color:red">*</span></div>
                </div>
            </td>
        </tr>
        <tr>
        <tr>
            <td style="text-align: right">已读人数:</td>
            <td><input id="viewcount" name="viewcount" style="width:180px"></td>
        </tr>
        </tr>
    </table>
</form>
<div style="text-align:center;padding:5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyViewCountForm()">保存</a>
</div>