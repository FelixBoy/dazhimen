<script type="text/javascript">
    function returnManageNewsInModifyNewsContent(){
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
                $("#newstitleInModifyNewsContent").val(jsonObj.title);
                $("#nidInModifyNewsContent").val(jsonObj.nid);
            }
        });
    });
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInModifyNewsContent()">返回</a>
</div>
<div style="margin:0px auto;width: 900px;text-align: center;">
        <table cellpadding="5">
            <tr>
                <td colspan="6" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon"></div>
                        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                            新闻标题
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>新闻标题:</td>
                <td colspan="4">
                    <input class="dzm-noBorder-text" readonly style="width:700px;" id="newstitleInModifyNewsContent" name="newstitle"/>
                    <input type="hidden" id="nidInModifyNewsContent" name="nid" />
                </td>
            </tr>
        </table>
    <table id="modifyNewsContentTable" cellpadding="5">
        <tr>
            <td colspan="7" >
                <div class="formTitle" style="background-color:#f2f2f2;">
                    <div class="formTitle-icon"></div>
                    <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                        修改新闻内容（请点击相应按钮，编辑内容）
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsSubtitle()">添加副标题</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsImage()">添加图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsText()">添加内容</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddNewsForm()">保存</a>
    </div>
</div>