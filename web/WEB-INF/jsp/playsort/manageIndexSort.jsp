<script>
    function forwardAddSkillPackIndexSortPage(){
        var rows = $("#skillPackIndexSortList").datagrid("getRows");
        if(rows.length >= 2){
            MsgBox.show("最多有2个【技能包】为首页排序");
            return;
        }
        $('#addSkillPackIndexSortDialog').dialog({
            title: '新增【技能包】首页排序',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/playsort/forwardAddSkillPackIndexSortPage.do?random_id=" + Math.random(),
            modal: true
        });
        $('#addSkillPackIndexSortDialog').dialog("open");
    }
    function forwardAddExperiencePackIndexSortPage(){
        var rows = $("#experiencePackIndexSortList").datagrid("getRows");
        if(rows.length >= 2){
            MsgBox.show("最多有2个【经验包】首页排序");
            return;
        }
        $('#addExperiencePackIndexSortDialog').dialog({
            title: '新增【经验包】首页排序',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/playsort/forwardAddExperiencePackIndexSortPage.do?random_id=" + Math.random(),
            modal: true
        });
        $('#addExperiencePackIndexSortDialog').dialog("open");
    }

    function forwardAddNewsIndexSortPage(){
        var rows = $("#newsIndexSortList").datagrid("getRows");
        if(rows.length >= 2){
            MsgBox.show("最多有2个【新闻】首页排序");
            return;
        }
        $('#addNewsIndexSortDialog').dialog({
            title: '新增【新闻】首页排序',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/playsort/forwardAddNewsIndexSortPage.do?random_id=" + Math.random(),
            modal: true
        });
        $('#addNewsIndexSortDialog').dialog("open");
    }

    function forwardAddMasterIndexSortPage(){
        var rows = $("#masterIndexSortList").datagrid("getRows");
        if(rows.length >= 2){
            MsgBox.show("最多有2个【掌门】首页排序");
            return;
        }
        $('#addMasterIndexSortDialog').dialog({
            title: '新增【掌门】首页排序',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/playsort/forwardAddMasterIndexSortPage.do?random_id=" + Math.random(),
            modal: true
        });
        $('#addMasterIndexSortDialog').dialog("open");
    }
    function clearSkillPackIndexSort(){
        $.messager.confirm('确认','您确定清空【技能包】首页排序吗？',function(r){
            if (r){
                $.ajax({
                    url:"<%=request.getContextPath()%>/playsort/clearSkillPackIndexSort.do?random_id="+Math.random(),
                    type:'get',
                    async:false,
                    error:function(data){
                        MsgBox.show(data.responseText);
                    },
                    success:function(data){
                        MsgBox.show(data);
                        $('#skillPackIndexSortList').datagrid('reload');
                    }
                });
            }
        });
    }
    function clearExperiencePackIndexSort(){
        $.messager.confirm('确认','您确定清空【经验包】首页排序吗？',function(r){
            if (r){
                $.ajax({
                    url:"<%=request.getContextPath()%>/playsort/clearExperiencePackIndexSort.do?random_id="+Math.random(),
                    type:'get',
                    async:false,
                    error:function(data){
                        MsgBox.show(data.responseText);
                    },
                    success:function(data){
                        MsgBox.show(data);
                        $('#experiencePackIndexSortList').datagrid('reload');
                    }
                });
            }
        });
    }
    function clearNewsIndexSort(){
        $.messager.confirm('确认','您确定清空【新闻】首页排序吗？',function(r){
            if (r){
                $.ajax({
                    url:"<%=request.getContextPath()%>/playsort/clearNewsIndexSort.do?random_id="+Math.random(),
                    type:'get',
                    async:false,
                    error:function(data){
                        MsgBox.show(data.responseText);
                    },
                    success:function(data){
                        MsgBox.show(data);
                        $('#newsIndexSortList').datagrid('reload');
                    }
                });
            }
        });
    }
    function clearMasterIndexSort(){
        $.messager.confirm('确认','您确定清空【掌门】首页排序吗？',function(r){
            if (r){
                $.ajax({
                    url:"<%=request.getContextPath()%>/playsort/clearMasterIndexSort.do?random_id="+Math.random(),
                    type:'get',
                    async:false,
                    error:function(data){
                        MsgBox.show(data.responseText);
                    },
                    success:function(data){
                        MsgBox.show(data);
                        $('#masterIndexSortList').datagrid('reload');
                    }
                });
            }
        });
    }

</script>
<div style="padding:5px 0;">
    <div class="easyui-layout" style="width:100%;height:230px;text-align: center;">
        <div data-options="region:'west',collapsible:false" title="【技能包】首页排序" style="width:50%">
            <div id="addSkillPackIndexSortDialog" style="text-align: center;"></div>
            <table id="skillPackIndexSortList" class="easyui-datagrid" style="width: auto;height: auto;"
                   url="<%=request.getContextPath()%>/playsort/queryAllSkillPackIndexSort.do?random_id="+Math.random()
                   rownumbers="true" fitColumns="true" singleSelect="true" >
                <thead>
                <tr>
                    <th data-options="field:'pid'" width="30%">Id</th>
                    <th data-options="field:'pname'" width="40%">名称</th>
                    <th data-options="field:'type'" width="30%">类型</th>
                </tr>
                </thead>
            </table>
            <br/>
            <div style="margin: 0 auto;text-align: center;">
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddSkillPackIndexSortPage()">新增</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearSkillPackIndexSort()">清空排序</a>
            </div>
        </div>
        <div data-options="region:'center'" title="【经验包】首页排序">
            <div id="addExperiencePackIndexSortDialog" style="text-align: center;"></div>
            <table id="experiencePackIndexSortList" class="easyui-datagrid" style="width: auto;height: auto;"
                   url="<%=request.getContextPath()%>/playsort/queryAllExperiencePackIndexSort.do?random_id="+Math.random()
                   rownumbers="true" fitColumns="true" singleSelect="true" >
                <thead>
                <tr>
                    <th data-options="field:'pid'" width="30%">Id</th>
                    <th data-options="field:'pname'" width="40%">名称</th>
                    <th data-options="field:'type'" width="30%">类型</th>
                </tr>
                </thead>
            </table>
            <br/>
            <div style="margin: 0 auto;text-align: center;">
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddExperiencePackIndexSortPage()">新增</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearExperiencePackIndexSort()">清空排序</a>
            </div>
        </div>
    </div>
    <div style="height: 20px;width: 100%;"></div>
    <div class="easyui-layout" style="width:100%;height:230px;text-align: center;">
        <div data-options="region:'west',collapsible:false" title="【新闻首】页排序" style="width:50%">
            <div id="addNewsIndexSortDialog" style="text-align: center;"></div>
            <table id="newsIndexSortList" class="easyui-datagrid" style="width: auto;height: auto;"
                   url="<%=request.getContextPath()%>/playsort/queryAllNewsIndexSort.do?random_id="+Math.random()
                   rownumbers="true" fitColumns="true" singleSelect="true" >
                <thead>
                <tr>
                    <th data-options="field:'nid'" width="30%">Id</th>
                    <th data-options="field:'title'" width="70%">标题</th>
                </tr>
                </thead>
            </table>
            <br/>
            <div style="margin: 0 auto;text-align: center;">
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddNewsIndexSortPage()">新增</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearNewsIndexSort()">清空排序</a>
            </div>
        </div>
        <div data-options="region:'center'" title="【掌门】首页排序">
            <div id="addMasterIndexSortDialog" style="text-align: center;"></div>
            <table id="masterIndexSortList" class="easyui-datagrid" style="width: auto;height: auto;"
                   url="<%=request.getContextPath()%>/playsort/queryAllMasterIndexSort.do?random_id="+Math.random()
                   rownumbers="true" fitColumns="true" singleSelect="true" >
                <thead>
                <tr>
                    <th data-options="field:'uid'" width="30%">Id</th>
                    <th data-options="field:'uname'" width="40%">姓名</th>
                    <th data-options="field:'mphone'" width="30%">手机号码</th>
                </tr>
                </thead>
            </table>
            <br/>
            <div style="margin: 0 auto;text-align: center;">
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddMasterIndexSortPage()">新增</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearMasterIndexSort()">清空排序</a>
            </div>
        </div>
    </div>
</div>