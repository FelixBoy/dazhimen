<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="util.Constant" %>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
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
                case 'product_news':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&tipinfo=产品与新闻管理<br/>请点击相应子菜单",
                        onLoad:function(){
                        }
                    });
                    break;
                case 'customer_recharge_order':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&tipinfo=会员、充值、订单查询<br/>请点击相应子菜单",
                        onLoad:function(){
                        }
                    });
                    break;
                case 'play_sort_right':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&tipinfo=首页轮播与首页排序配置<br/>请点击相应子菜单",
                        onLoad:function(){
                        }
                    });
                    break;
                case 'master_admin_right':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&tipinfo=掌门、管理员、权限管理<br/>请点击相应子菜单",
                        onLoad:function(){
                        }
                    });
                    break;
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
                case 'customer_query':
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
                case 'recharge_query':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/recharge/fwdManageRechargePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'order_query':
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
                case 'news_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
                    });
                    break;
                case 'permission_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/permission/fwdManagePermissionPage?random_id="+Math.random()
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
    <div style="font-size: 30px;float:left;">大职门后台管理系统</div>
    <div style="height:40px;font-size: 16px;line-height:40px;float: right;">
        <%=userBean.getUname()%>，<%=userBean.getUtypeStr()%>&nbsp&nbsp<a href="<%=request.getContextPath()%>/login/exitLogin">退出登录</a>
    </div>
</div>
<div data-options="region:'west',split:false,title:'导航菜单'" style="width:240px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <div class="easyui-panel" style="padding:5px">
        <ul id="menu-tree" class="easyui-tree">
            <li id="product_news" data-options="state:'open'">
                <span>产品/新闻</span>
                <ul>
                    <li id="product_manage">产品管理</li>
                    <li id="news_manage">新闻管理</li>
                </ul>
            </li>
            <li id="customer_recharge_order" data-options="state:'open'">
                <span>会员/充值/订单</span>
                <ul>
                    <li id="customer_query">会员查询</li>
                    <li id="recharge_query">充值查询</li>
                    <li id="order_query">订单查询</li>
                </ul>
            </li>
            <li id="play_sort_right" data-options="state:'open'">
                <span>轮播/排序</span>
                <ul>
                    <li id="indexplay_manage">首页轮播</li>
                    <li id="indexsort_manange">首页排序</li>
                </ul>
            </li>
            <li id="master_admin_right" data-options="state:'open'">
                <span>掌门/管理员/权限</span>
                <ul>
                    <li id="master_manage">掌门管理</li>
                    <li id="admin_manage">管理员管理</li>
                    <li id="permission_manage">权限管理</li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div id="center_oper_area" data-options="region:'center',title:' '">
    <div id="content_panel" class="easyui-panel"style="padding:10px;text-align: center"
         data-options="fit:true,border:false">
        <div style="height: 200px;"></div>
        <div style="height:100px;font-size: 30px;line-height: 60px;">欢迎使用大职门后台管理系统</div>
    </div>
</div>
</body>
</html>
