<script>
    function formatOper(val,row,index) {
        return '<a href="javascript:void(0)" onclick="saveUpSkillPack('+index+')">上移</a>&nbsp&nbsp&nbsp&nbsp'
            +'<a href="javascript:void(0)" onclick="saveDownSkillPack('+index+')">下移</a>';
    }
    function saveUpSkillPack(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function saveDownSkillPack(index){
        MsgBox.show("功能正在开发，敬请期待");
    }
    function forwardAddSkillPackIndexSortPage(){
        var rows = $("#skillPackIndexSortList").datagrid("getRows");
        if(rows.length >= 2){
            MsgBox.show("最多允许有2个技能包，添加为首页排序");
            return;
        }
        $('#addSkillPackIndexSortDialog').dialog({
            title: '新增【技能包】首页排序',
            width: 580,
            height: 500,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/playsort/forwardAddSkillPackIndexSortPage?random_id=" + Math.random(),
            modal: true
        });
        $('#addSkillPackIndexSortDialog').dialog("open");
    }
</script>
<div style="padding:5px 0;">
    <div id="addSkillPackIndexSortDialog" style="text-align: center;"></div>
    <table id="skillPackIndexSortList" title="技能包首页排序" class="easyui-datagrid" style="width: auto;height: auto;"
           url="<%=request.getContextPath()%>/playsort/queryAllSkillPackIndexSort?random_id="+Math.random()
           rownumbers="true" fitColumns="true" singleSelect="true" >
        <thead>
        <tr>
            <th data-options="field:'pid'" width="20%">Id</th>
            <th data-options="field:'pname'" width="30%">名称</th>
            <th data-options="field:'type'" width="20%">类型</th>
            <th data-options="field:'operate',align:'center',formatter:formatOper" width="30%">操作</th>
        </tr>
        </thead>
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddSkillPackIndexSortPage()">新增</a>
    <%--<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddIndexPlayPage()">删除</a>--%>
</div>