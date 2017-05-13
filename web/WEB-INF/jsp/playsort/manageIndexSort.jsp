<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            modal: true
        });
        $("#addSkillPackIndexSortDialog").dialog({
            onClose:function(){
                $("#addSkillPackIndexSortDialog").empty();
            }
        });
        $('#addSkillPackIndexSortDialog').dialog("open");
        $("#addSkillPackIndexSortDialog").dialog("refresh",
            "<%=request.getContextPath()%>/playsort/forwardAddSkillPackIndexSortPage.do?random_id=" + Math.random());
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
            modal: true
        });
        $("#addExperiencePackIndexSortDialog").dialog({
            onClose:function(){
                $("#addExperiencePackIndexSortDialog").empty();
            }
        });
        $('#addExperiencePackIndexSortDialog').dialog("open");
        $("#addExperiencePackIndexSortDialog").dialog("refresh",
            "<%=request.getContextPath()%>/playsort/forwardAddExperiencePackIndexSortPage.do?random_id=" + Math.random());
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
            modal: true
        });
        $("#addNewsIndexSortDialog").dialog({
            onClose:function(){
                $("#addNewsIndexSortDialog").empty();
            }
        });
        $('#addNewsIndexSortDialog').dialog("open");
        $("#addNewsIndexSortDialog").dialog("refresh",
            "<%=request.getContextPath()%>/playsort/forwardAddNewsIndexSortPage.do?random_id=" + Math.random());
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
            modal: true
        });
        $("#addMasterIndexSortDialog").dialog({
            onClose:function(){
                $("#addMasterIndexSortDialog").empty();
            }
        });
        $('#addMasterIndexSortDialog').dialog("open");
        $("#addMasterIndexSortDialog").dialog("refresh",
            "<%=request.getContextPath()%>/playsort/forwardAddMasterIndexSortPage.do?random_id=" + Math.random());
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
    function saveDeleteSkillPackSort(index){
        $("#skillPackIndexSortList").datagrid("selectRow", index);
        var row = $('#skillPackIndexSortList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认取消【技能包】【'+ row.pname + '】的首页排序吗？',function(r) {
                if(r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveDeleteSkillPackSort.do?pid=" + row.pid + "&random_id="+Math.random(),
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
    }
    function saveDeleteExperiencePackSort(index){
        $("#experiencePackIndexSortList").datagrid("selectRow", index);
        var row = $('#experiencePackIndexSortList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认取消【技能包】【'+ row.pname + '】的首页排序吗？',function(r) {
                if(r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveDeleteExperiencePackSort.do?pid=" + row.pid + "&random_id="+Math.random(),
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
    }
    function saveDeleteNewsSort(index){
        $("#newsIndexSortList").datagrid("selectRow", index);
        var row = $('#newsIndexSortList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认取消【新闻】【'+ row.title + '】的首页排序吗？',function(r) {
                if(r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveDeleteNewsSort.do?nid=" + row.nid + "&random_id="+Math.random(),
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
    }
    function saveDeleteMasterSort(index){
        $("#masterIndexSortList").datagrid("selectRow", index);
        var row = $('#masterIndexSortList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认取消【掌门】【'+ row.uname + '】的首页排序吗？',function(r) {
                if(r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/playsort/saveDeleteMasterSort.do?uid=" + row.uid + "&random_id="+Math.random(),
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
    }
    function formatSkillPackOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="saveDeleteSkillPackSort('+index+')">取消排序</a>';
    }
    function formatExperiencePackOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="saveDeleteExperiencePackSort('+index+')">取消排序</a>';
    }
    function formatNewsOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="saveDeleteNewsSort('+index+')">取消排序</a>';
    }
    function formatMasterOper(val,row,index){
        return '<a href="javascript:void(0)" onclick="saveDeleteMasterSort('+index+')">取消排序</a>';
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
                    <th data-options="field:'pid'" width="25%">Id</th>
                    <th data-options="field:'pname'" width="40%">名称</th>
                    <th data-options="field:'type'" width="15%">类型</th>
                    <th data-options="field:'operate',align:'center',formatter:formatSkillPackOper" width="20%">操作</th>
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
                    <th data-options="field:'pid'" width="25%">Id</th>
                    <th data-options="field:'pname'" width="40%">名称</th>
                    <th data-options="field:'type'" width="15%">类型</th>
                    <th data-options="field:'operate',align:'center',formatter:formatExperiencePackOper" width="20%">操作</th>
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
                    <th data-options="field:'nid'" width="25%">Id</th>
                    <th data-options="field:'title'" width="55">标题</th>
                    <th data-options="field:'operate',align:'center',formatter:formatNewsOper" width="20%">操作</th>
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
                    <th data-options="field:'uid'" width="25%">Id</th>
                    <th data-options="field:'uname'" width="35%">姓名</th>
                    <th data-options="field:'mphone'" width="20%">手机号码</th>
                    <th data-options="field:'operate',align:'center',formatter:formatMasterOper" width="20%">操作</th>
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