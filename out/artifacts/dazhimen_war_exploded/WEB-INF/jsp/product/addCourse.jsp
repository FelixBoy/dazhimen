<script>
    function submitAddCourse(){
        MsgBox.show("1111");
    }
</script>
<div style="width: 500px;margin: 0 auto;">
<form id="productForm" action="<%=request.getContextPath()%>/product/saveAddCourse"
      enctype="multipart/form-data" method="post">
    <br/>
    <table cellpadding="5">
        <tr>
            <td colspan="2" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon">
                    </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写课程信息</div>
                </div>
            </td>
        </tr>
        <tr>
            <td>名称:<span style="color:red">*</span></td>
            <td><input class="easyui-textbox"  id="coursename" name="coursename"
                       data-options="prompt:'请填写课程名称'" style="width:350px"></td>
        </tr>
        <tr>
            <td>排序:</td>
            <td>
                <select class="easyui-combobox" name="sort" id="sort" style="width:140px;" style="width:350px">
                    <option value="0">按上架时间排序</option>
                    <option value="1">排序1</option>
                    <option value="2">排序2</option>
                    <option value="3">排序3</option>
                    <option value="4">排序4</option>
                    <option value="5">排序5</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>试学:</td>
            <td><input type="checkbox" id="istry" name="istry" style="width:100px"/></td>
        </tr>
        <tr>
            <td>音频文件:<span style="color:red">*</span></td>
            <td>
                <input class="easyui-filebox" id="audio" name="audio" style="width:350px" accept="audio/mpeg"
                       data-options="prompt:'请选课程音频文件，支持mp3',buttonText:'&nbsp;选&nbsp;择&nbsp;'">
            </td>
        </tr>
    </table>
</form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddCourse()">保存</a>
    </div>
</div>