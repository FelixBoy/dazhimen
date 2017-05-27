<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $.ajax({
            url:"<%=request.getContextPath()%>/product/getViewCourseData.do" +
            "?courseid=<%=request.getAttribute("courseid").toString()%>&random_id=" + Math.random(),
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
                $("#courseidInViewCourse").val(jsonObj.courseid);
                $("#coursenameInViewCourse").val(jsonObj.coursename);
                $("#sortInViewCourse").val(jsonObj.sort);
                $("#istryInViewCourse").val(jsonObj.istry);
                $("#filenameInViewCourse").val(jsonObj.filename);
                $("#filesizestrInViewCourse").val(jsonObj.filesizestr);

                $("#viewCourseIntroduction").append(jsonObj.courseintroductionhtml);
                $.parser.parse($('#viewCourseIntroduction'));
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
<div style="width:900px; margin: 0 auto;">
    <div id="newsListImgAndMainImage" style="width: 520px;float: left;">
        <div style="height: 10px;"></div>
        <div class="formTitle" style="background-color:#f2f2f2;width: 520px;">
            <div class="formTitle-icon"></div>
            <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                课程基本信息
            </div>
        </div>
        <div style="height: 10px;"></div>
        <div style="width: 520px;height: 450px;">
            <form id="modifyCourseForm" action="<%=request.getContextPath()%>/product/saveModifyCourse.do"
                  enctype="multipart/form-data" method="post">
                <br/>
                <table cellpadding="5">
                    <tr style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">Id:</td>
                        <td><input class="dzm-noBorder-text" readonly  id="courseidInViewCourse" name="courseid" style="width:400px">
                        </td>
                    </tr>
                    <tr style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">名称:</td>
                        <td><input class="dzm-noBorder-text" readonly  id="coursenameInViewCourse" name="coursename" style="width:400px"></td>
                    </tr>
                    <tr  style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">排序:</td>
                        <td><input class="dzm-noBorder-text" readonly  id="sortInViewCourse" name="sort" style="width:400px"/></td>
                    </tr>
                    <tr  style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">试学:</td>
                        <td><input class="dzm-noBorder-text" readonly  id="istryInViewCourse" name="istry" style="width:400px"/></td>
                    </tr>
                    <tr  style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">音频名称:</td>
                        <td><input class="dzm-noBorder-text" readonly id="filenameInViewCourse" name="filename" style="width:400px"></td>
                    </tr>
                    <tr  style="height: 60px;">
                        <td nowrap="nowrap" style="text-align: right">音频大小:</td>
                        <td><input class="dzm-noBorder-text" readonly id="filesizestrInViewCourse" name="filesizestr" style="width:400px"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div style="float: left;margin-left: 60px;">
        <div style="height: 10px;"></div>
        <div class="formTitle" style="background-color:#f2f2f2;width: 300px;">
            <div class="formTitle-icon"></div>
            <div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">
                课程介绍
            </div>
        </div>
        <div id="viewCourseIntroduction" style="margin-top:10px;width: 300px;overflow-y:auto;height:450px;text-align: left;border: 1px black solid;">
        </div>
    </div>
</div>