<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="util.Constant" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>大职门后台管理</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dazhimen.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/loadingMaskLayer.css?_=<%=Constant.FrontEndVersion%>">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/locale/easyui-lang-zh_CN.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/StringUtil.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/MsgBox.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/LoadingMaskLayer.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script>
        $(function(){
            $('#menu-tree').tree({
                onClick: function(node){
                    $("#center_oper_area").panel({title: node.text});
                    forwardUserManage(node.id);
                }
            });
        });
        function forwardUserManage(nodeid){
            switch (nodeid){
                case 'master_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdMasterManagePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'product_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/product/fwdManageProductPage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'customer_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/customer/fwdCustomerManagePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'indexplay_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/playsort/fwdIndexPlayManagePage?random_id="+Math.random()
                    });
                    break;
                case 'admin_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdManageAdminPage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'recharge_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/recharge/fwdManageRechargePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'order_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/order/fwdManageOrderPage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'indexsort_manange':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/playsort/fwdIndexSortManagePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'test_fileuploadcb':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/demo/fwdTestFileUploadCallBack?random_id="+Math.random()
                    });
                    break;
                case 'news_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
                    });
                    break;
                default:
                    MsgBox.show("功能正在开发，敬请期待！");
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/demo/fwdSuspensionInfor?random_id="+Math.random()
                    });
            }
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px;text-align: center">
    <div style="font-size: 30px;margin: 0 auto;">大职门后台管理系统</div>
</div>
<div data-options="region:'west',split:false,title:'导航菜单'" style="width:240px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <div class="easyui-panel" style="padding:5px">
        <ul id="menu-tree" class="easyui-tree">
            <li id="product_manage">产品管理</li>
            <li id="master_manage">掌门管理</li>
            <li id="admin_manage">管理员管理</li>
            <li id="indexplay_manage">首页轮播</li>
            <li id="indexsort_manange">首页排序</li>
            <li id="customer_manage">会员查询</li>
            <li id="recharge_manage">充值查询</li>
            <li id="order_manage">订单查询</li>
            <li id="news_manage">新闻管理</li>
            <li id="permission_manage">权限管理</li>
            <%--<li id="test_fileuploadcb" >测试文件上传回调</li>--%>
        </ul>
    </div>
</div>
<div id="center_oper_area" data-options="region:'center',title:' '">
    <div id="content_panel" class="easyui-panel"style="padding:10px;text-align: center"
         data-options="fit:true,border:false">
    </div>
</div>
</body>
</html>
