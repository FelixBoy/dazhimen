<script type="text/javascript">
    function returnManageNewsInViewNews(){
        $('#content_panel').panel({
            href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
        });
    }
    $(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/news/getViewNewsData" +
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
                $("#newListImage").attr("src", jsonObj.listimgurl + "?rondomid=" + Math.random());
                $("#newsMainImage").attr("src",jsonObj.mainimgurl + "?rondomid=" + Math.random());
                $("#viewNewsContent").append(jsonObj.contenthtml);
                $.parser.parse($('#viewNewsContent'));
            }
        });
    });
</script>
<style type="text/css">
    * {margin: 0; padding: 0;}
    .top {padding: 10px 15px; font-size: 25px;}
    .content {padding: 10px 25px;}
    .content .subtitle {padding-top:10px;padding-bottom:10px; padding-left:20px; font-size: 20px;}
    .content img {width: 100%;height:120px;padding-top: 10px; padding-bottom:10px;}
    .content .main {color: #575757; text-indent: 2em}
</style>
<div style="text-align: left;">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="returnManageNewsInViewNews()">返回</a>
</div>
<div style="width:800px; margin: 0 auto;">
<div id="newsListImgAndMainImage" style="width: 300px;float: left;">
    <div class="formTitle" style="background-color:#f2f2f2;width: 300px;">
        <div class="formTitle-icon"></div>
        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
            列表图片，用于新闻列表展示
        </div>
    </div>
    <div style="height: 10px;"></div>
    <div style="width: 300px;height: 150px;">
        <img id="newListImage" width="100%" height="100%"/>
    </div>
    <div style="height: 50px;"></div>
    <div class="formTitle" style="background-color:#f2f2f2;width: 300px;">
        <div class="formTitle-icon"></div>
        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
            新闻主图，用于首页轮播
        </div>
    </div>
    <div style="height: 10px;"></div>
    <div style="width: 300px;height: 150px;">
        <img id="newsMainImage" width="100%" height="100%"/>
    </div>
</div>
<div style="float: left;margin-left: 100px;">
    <div class="formTitle" style="background-color:#f2f2f2;width: 300px;">
        <div class="formTitle-icon"></div>
        <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
            查看新闻内容
        </div>
    </div>
    <div id="viewNewsContent" style="margin-top:10px;width: 300px;overflow-y:auto;height:500px;text-align: left;border: 1px black solid;">
    </div>
</div>
</div>