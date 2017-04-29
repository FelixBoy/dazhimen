<script type="text/javascript">
    function returnManageNewsInModifyNewsContent(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage.do?random_id="+Math.random()
        });
    }
    $(function(){
        refreshNewsContent();
    });
    function refreshNewsContent(){
        $.ajax({
            url:"<%=request.getContextPath()%>/news/getModifyNewsContentData.do" +
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
                var newsContentArr = jsonObj.newscontent;
                if(!newsContentArr){
                    return;
                }
                $("#modifyNewsContentTable").empty();
                $("#modifyNewsContentTable").append("<tr><td colspan='7' >" +
                "<div class='formTitle' style='background-color:#f2f2f2;'>" +
                    "<div class='formTitle-icon'></div>" +
                    "<div class='formTitle-text' style='font-weight:bold;text-decoration:none;font-style:normal;text-align:left;'>"+
                    "修改新闻内容（请点击相应按钮，编辑内容）"+
                    "</div>"+
                "</div>"+
                "</td></tr>");
                for(var i = 0; i < newsContentArr.length; i++){
                    if(newsContentArr[i].contenttype == '1'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>副标题:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><input class='easyui-textbox' " +
                            " style='width:700px;' id='newscontent" + (i+1) +"' name='newscontent" + (i+1) + "'/>" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"modifyNewsContentSubtitle('" + (i+1) + "','" + newsContentArr[i].contentid + "')\">保存修改</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContent('trcontent" + (i+1) + "','" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#newscontent" + (i+1) +"").val(newsContentArr[i].contentvalue);
                    }
                    if(newsContentArr[i].contenttype == '2'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>内容图片:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><img width='120px' height='60px' id='newscontent" + (i+1) +"' />" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"openModifyNewsContentImgDialog('" + (i+1) +"','" + newsContentArr[i].contentid + "')\">修改图片</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContent('trcontent" + i +"')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#newscontent" + (i+1) +"").attr("src", newsContentArr[i].contentvalue + "?rondomid=" + Math.random());
                    }
                    if(newsContentArr[i].contenttype == '3'){
                        $("#modifyNewsContentTable").append("<tr id='trcontent" + (i+1) + "'><td nowrap='nowrap'>内容文本:<span style='color:red'>*</span></td>" +
                            "<td colspan='5'><input class='easyui-textbox' data-options='multiline:true'" +
                            " style='width:650px;height: 60px;' id='newscontent" + (i+1) +"' name='newscontent" + (i+1) + "'/>" +
                            "<input type='hidden' id='id_newscontent" + (i+1) + "' name='id_newscontent" + (i+1) + "' value='" + newsContentArr[i].contentid + "'/>" +
                            "<input type='hidden' id='sort_newscontent" + (i+1) + "' name='sort_newscontent" + (i+1) + "' value='" + (i+1) + "'/>" +
                            "</td>" +
                            "<td nowrap='nowrap'>" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-save'\" " +
                            "onclick=\"modifyNewsContentText('" + (i+1) + "','" + newsContentArr[i].contentid + "')\">保存修改</a>&nbsp;&nbsp;&nbsp;" +
                            "<a href='javascript:void(0)' class='easyui-linkbutton' data-options=\"iconCls:'icon-remove'\" " +
                            "onclick=\"deleteNewsContent('trcontent" + (i+1) + "','" + newsContentArr[i].contentid + "')\">删除</a>" +
                            "</td>" +
                            "</tr>");
                        $("#newscontent" + (i+1) +"").val(newsContentArr[i].contentvalue);
                    }
                }
                $.parser.parse($("#modifyNewsContentTable"));
            }
        });
    }
    function modifyNewsContentSubtitle(index, contentid){
        $.ajax({
            url: "<%=request.getContextPath()%>/news/modifyNewsContentSubtitle.do" +
            "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
            + "&subtitle=" + $("#newscontent" + index).val() + "&random_id=" + Math.random(),
            type: 'get',
            async: false,
            error: function (data) {
                MsgBox.show(data.responseText);
            },
            success: function (data) {
                MsgBox.show(data);
                refreshNewsContent();
            }
        });
    }
    function modifyNewsContentText(index, contentid){
        $.ajax({
            url: "<%=request.getContextPath()%>/news/modifyNewsContentText.do" +
            "?nid=" + $("#nidInModifyNewsContent").val() + "&contentid=" + contentid
            + "&text=" + $("#newscontent" + index).val() + "&random_id=" + Math.random(),
            type: 'get',
            async: false,
            error: function (data) {
                MsgBox.show(data.responseText);
            },
            success: function (data) {
                MsgBox.show(data);
                refreshNewsContent();
            }
        });
    }
    function openModifyNewsContentImgDialog(index, contentid){
        $('#modifyNewsContentImgDialog').dialog({
            title: '修改新闻内容图片',
            width: 430,
            height: 230,
            closed: true,
            cache: false,
            modal: true
        });
        $("#modifyNewsContentImgDialog").dialog("refresh",
            "<%=request.getContextPath()%>/news/fwdModifyNewsContentImgPage.do?nid=" + $("#nidInModifyNewsContent").val()
            +"&contentid=" + contentid
            + "&random_id=" + Math.random());
        $('#modifyNewsContentImgDialog').dialog("open");
    }
</script>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInModifyNewsContent()">返回</a>
</div>
<div id="modifyNewsContentImgDialog"></div>
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
    </table>
    <div style="text-align: center;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsSubtitle()">添加副标题</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsImage()">添加图片</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNewsText()">添加内容</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddNewsForm()">保存</a>
    </div>
</div>