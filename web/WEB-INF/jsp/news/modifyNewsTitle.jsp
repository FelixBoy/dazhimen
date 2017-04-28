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
    });
    function checkModifyNewsTitleFormBeforeSubmit(){
        if($.trim($("#newstitleInModifyTitle").val()).length == 0){
            MsgBox.show("新闻标题不能为空");
            return false;
        }
        if(StringUtil.getBinaryLength($("#newstitleInModifyTitle").val()) > 150){
            MsgBox.show("新闻标题过长，无法保存");
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
        $("#modifyNewsListImgDialog").dialog("refresh", "<%=request.getContextPath()%>/news/fwdModifyNewsListImgPage.do?nid=" + $("#nidInModifyTitle").val()
            + "&random_id=" + Math.random());
        $('#modifyNewsListImgDialog').dialog("open");
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
        $("#modifyNewsMainImgDialog").dialog("refresh", "<%=request.getContextPath()%>/news/fwdModifyNewsMainImgPage.do?nid=" + $("#nidInModifyTitle").val()
            + "&random_id=" + Math.random());
        $('#modifyNewsMainImgDialog').dialog("open");
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
                <input class="easyui-textbox" style="width:700px;" id="newstitleInModifyTitle" name="newstitle"/>
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