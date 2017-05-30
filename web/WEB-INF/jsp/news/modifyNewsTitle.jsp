<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    function returnManageNewsInModifyNews(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
        });
    }
    $(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/news/getModifyNewsTitleData.do" +
            "?nid=<%=request.getAttribute("nid").toString()%>&random_id=" + Math.random(),
            type:'get',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                var jsonObj = JSON.parse(data);
                if(!jsonObj){
                    return;
                }
                $("#newstitleInModifyTitle").val(jsonObj.title);
                $("#nidInModifyTitle").val(jsonObj.nid);
                $("#listImageInModifyNews").attr("src", jsonObj.listimgurl + "?rondomid=" + Math.random());
                $("#mainImageInModifyNews").attr("src",jsonObj.mainimgurl + "?rondomid=" + Math.random());
            }
        });
        $.extend($.fn.validatebox.defaults.rules, {
            maxLen:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber($.trim(value)) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            imgfile:{
                validator: function (value, param) {
                    var imgFileSuffixName = value.substring(value.lastIndexOf("."));
                    if(imgFileSuffixName.toLowerCase() != ".jpg" && imgFileSuffixName.toLowerCase() != ".png"){
                        MsgBox.show("图片格式不正确，仅支持jpg、png");
                        return false;
                    }
                    return true;
                },
                message:'图片格式不正确，请选择jpg,png格式'
            }
        });
        $('#newstitleInModifyTitle').textbox({
            required: true,
            validType: 'maxLen[80]',
            missingMessage:'最多输入80个字符',
            prompt:'请输入新闻标题'
        });
    });
    function checkModifyNewsTitleFormBeforeSubmit(){
        if($.trim($("#newstitleInModifyTitle").val()).length == 0){
            MsgBox.show("新闻标题不能为空");
            return false;
        }
        if(StringUtil.getCharNumber($("#newstitleInModifyTitle").val()) > 80){
            MsgBox.show("新闻标题过长，最长80个字符");
            return false;
        }
        return true;
    }
    function openModifyNewsListImgDialog(){
        $('#modifyNewsListImgDialog').dialog({
            title: '修改新闻列表图片',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyNewsListImgDialog").dialog({
            onClose:function(){
                $("#modifyNewsListImgDialog").empty();
            }
        });
        $('#modifyNewsListImgDialog').dialog("open");
        $("#modifyNewsListImgDialog").dialog("refresh", "<%=request.getContextPath()%>/news/fwdModifyNewsListImgPage.do?nid=" + $("#nidInModifyTitle").val()
            + "&random_id=" + Math.random());
    }
    function submitModifyNewsTitleForm(){
        if(!checkModifyNewsTitleFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/news/saveModifyNewsTitle.do",
            data:$('#modifyNewsTitleForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $.ajax({
                    url:"<%=request.getContextPath()%>/news/getModifyNewsTitleData.do" +
                    "?nid=<%=request.getAttribute("nid").toString()%>&random_id=" + Math.random(),
                    type:'get',
                    async:false,
                    error:function(data){
                        MsgBox.show(data.responseText);
                    },
                    success:function(data){
                        var jsonObj = JSON.parse(data);
                        if(!jsonObj){
                            return;
                        }
                        $("#newstitleInModifyTitle").val(jsonObj.title);
                        $("#nidInModifyTitle").val(jsonObj.nid);
                        $("#listImageInModifyNews").attr("src", jsonObj.listimgurl + "?rondomid=" + Math.random());
                        $("#mainImageInModifyNews").attr("src",jsonObj.mainimgurl + "?rondomid=" + Math.random());
                    }
                });
            }
        });
    }
    function openModifyNewsMainImgDialog(){
        $('#modifyNewsMainImgDialog').dialog({
            title: '修改新闻主图',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyNewsMainImgDialog").dialog({
            onClose:function(){
                $("#modifyNewsMainImgDialog").empty();
            }
        });
        $('#modifyNewsMainImgDialog').dialog("open");
        $("#modifyNewsMainImgDialog").dialog("refresh", "<%=request.getContextPath()%>/news/fwdModifyNewsMainImgPage.do?nid=" + $("#nidInModifyTitle").val()
            + "&random_id=" + Math.random());
    }

</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInModifyNews()">返回</a>
</div>
<div id="modifyNewsListImgDialog"></div>
<div id="modifyNewsMainImgDialog"></div>
<div style="margin:0px auto;width: 900px;text-align: center;">
    <form id="modifyNewsTitleForm">
    <table id="modifyNewsTitleTable" cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        修改新闻标题
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>新闻标题:<span style="color:red">*</span></td>
            <td colspan="4">
                <input style="width:700px;" id="newstitleInModifyTitle" name="newstitle"/>
                <input type="hidden" id="nidInModifyTitle" name="nid" />
            </td>
        </tr>
    </table>
    </form>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyNewsTitleForm()">保存标题修改</a>
    </div>
    <div style="height: 50px;">
    </div>
    <table id="modifyNewsImageTable" cellpadding="5">
        <tr>
            <td colspan="6" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        修改列表图片和新闻主图
                    </div>
                </div>
            </td>
        </tr>
        <tr id="imgtr">
            <td nowrap="nowrap">列表图片:</td>
            <td id="listimgtr" colspan="2">
                <img id="listImageInModifyNews" width="100px" height="100px"/>
            </td>
            <td align='right'>新闻主图:</td>
            <td align='left' colspan='2'>
                <img id="mainImageInModifyNews"  align='left' width='200px' height='100px'/><br/>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right;"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="openModifyNewsListImgDialog()">修改列表图片</a></td>
            <td colspan="3" style="text-align: center;"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="openModifyNewsMainImgDialog()">修改新闻主图</a></td>
        </tr>
    </table>
</div>