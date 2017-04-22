<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="util.Constant" %>
<%@ page import="dazhimen.bg.bean.login.LoginUserBean" %>
<%@ page import="util.GlobalUtils" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
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
        <%if(userBean.getUserPermissionMap().size() > 0 || userBean.getLoginname().equals(Constant.defaultAdministrator)){%>
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
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&menuid=product_news",
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
                case 'news_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/news/fwdManageNewsPage?random_id="+Math.random()
                    });
                    break;
                case 'customer_recharge_order':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&menuid=customer_recharge_order",
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
                case 'play_sort':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() + "&menuid=play_sort",
                        onLoad:function(){
                        }
                    });
                    break;
                case 'indexplay_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/playsort/fwdIndexPlayManagePage?random_id="+Math.random()
                    });
                    break;
                case 'indexsort_manange':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/playsort/fwdIndexSortManagePage?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'master_admin_permission':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdTipsInforPage?random_id="+Math.random() +  "&menuid=master_admin_permission",
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
                case 'admin_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdManageAdminPage?random_id="+Math.random(),
                        onLoad:function(){
                        }
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
        <%}%>
        function modifyPassword(){
            $('#modifyPasswordDialog').dialog({
                title: '修改密码',
                width: 600,
                height: 400,
                closed: true,
                cache: false,
                href: "<%=request.getContextPath()%>/user/fwdModifyPasswordPage?randomid="+Math.random(),
                modal: true
            });
            $('#modifyPasswordDialog').dialog("open");
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px;text-align: center">
    <div style="font-size: 30px;float:left;">大职门后台管理系统</div>
    <div style="height:40px;font-size: 16px;line-height:20px;float: right;">
        <%=userBean.getUname()%>|<%=userBean.getUtypeStr()%><br/>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyPassword()" >修改密码</a>
        <a href="<%=request.getContextPath()%>/login/exitLogin" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" >退出</a>
    </div>
</div>
<div data-options="region:'west',split:false,title:'导航菜单'" style="width:240px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <div id="modifyPasswordDialog"></div>
    <%if(userBean.getUserPermissionMap().size() > 0 || userBean.getLoginname().equals(Constant.defaultAdministrator)){%>
    <div class="easyui-panel" style="padding:5px">
        <ul id="menu-tree" class="easyui-tree">
            <%
                boolean hasPerProduct = GlobalUtils.checkUserPermission(Constant.Per_Product, userBean);
                boolean hasPerNews =  GlobalUtils.checkUserPermission(Constant.Per_News, userBean);
                if(hasPerProduct || hasPerNews){
            %>
            <li id="product_news" data-options="state:'open'">
                <%if(hasPerNews && hasPerProduct){%>
                    <span>产品/新闻</span>
                <%}%>
                <%if(hasPerProduct && !hasPerNews){%>
                    <span>产品</span>
                <%}%>
                <%if(!hasPerProduct && hasPerNews){%>
                <span>新闻</span>
                <%}%>
                <ul>
                    <% if(hasPerProduct){%>
                    <li id="product_manage">产品管理</li>
                    <%}%>
                    <% if(hasPerNews){%>
                    <li id="news_manage">新闻管理</li>
                    <%}%>
                </ul>
            </li>
            <%
                }
            %>
            <%
                boolean hasPerCustomer = GlobalUtils.checkUserPermission(Constant.Per_Customer, userBean);
                boolean hasPerRecharge = GlobalUtils.checkUserPermission(Constant.Per_Recharge, userBean);
                boolean hasPerOrder = GlobalUtils.checkUserPermission(Constant.Per_Order, userBean);
                if(hasPerCustomer || hasPerRecharge|| hasPerOrder ){%>
            <li id="customer_recharge_order" data-options="state:'open'">
                <%if(hasPerCustomer && hasPerRecharge && hasPerOrder) {%>
                    <span>会员/充值/订单</span>
                <%}%>
                <%if(!hasPerCustomer && hasPerRecharge && hasPerOrder){%>
                    <span>充值/订单</span>
                <%}%>
                <%if(!hasPerRecharge && hasPerCustomer && hasPerOrder){%>
                    <span>会员/订单</span>
                <%}%>
                <%if(hasPerRecharge && hasPerCustomer && !hasPerOrder){%>
                    <span>会员/充值</span>
                <%}%>
                <%if(!hasPerRecharge && hasPerCustomer && !hasPerOrder){%>
                    <span>会员</span>
                <%}%>
                <%if(hasPerRecharge && !hasPerCustomer && !hasPerOrder){%>
                <span>充值</span>
                <%}%>
                <%if(!hasPerRecharge && !hasPerCustomer && hasPerOrder){%>
                    <span>订单</span>
                <%}%>
                <ul>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Customer, userBean)){%>
                        <li id="customer_query">会员查询</li>
                    <%}%>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Recharge, userBean)){%>
                         <li id="recharge_query">充值查询</li>
                    <%}%>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Order, userBean)){%>
                        <li id="order_query">订单查询</li>
                    <%}%>
                </ul>
            </li>
            <%}%>
            <%
                boolean hasPerIndexPlay = GlobalUtils.checkUserPermission(Constant.Per_Indexplay, userBean);
                boolean hasPerIndexSort = GlobalUtils.checkUserPermission(Constant.Per_Indexsort, userBean);
                if(hasPerIndexPlay || hasPerIndexSort){%>
            <li id="play_sort" data-options="state:'open'">
                <%if(hasPerIndexPlay && hasPerIndexSort){%>
                    <span>轮播/排序</span>
                <%}%>
                <%if(hasPerIndexPlay && !hasPerIndexSort){%>
                    <span>轮播</span>
                <%}%>
                <%if(!hasPerIndexPlay && hasPerIndexSort){%>
                <span>排序</span>
                <%}%>
                <ul>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Indexplay, userBean)){%>
                    <li id="indexplay_manage">首页轮播</li>
                    <%}%>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Indexsort, userBean)){%>
                    <li id="indexsort_manange">首页排序</li>
                    <%}%>
                </ul>
            </li>
            <%}%>
            <%
                boolean hasPerMaster = GlobalUtils.checkUserPermission(Constant.Per_Master, userBean);
                boolean hasPerAdmin =  GlobalUtils.checkUserPermission(Constant.Per_Admin, userBean);
                boolean hasPerPermission = GlobalUtils.checkUserPermission(Constant.Per_Permission, userBean);
                if(hasPerMaster || hasPerAdmin || hasPerPermission){%>
            <li id="master_admin_permission" data-options="state:'open'">
                <%if(hasPerMaster && hasPerAdmin && hasPerPermission){%>
                    <span>掌门/管理员/权限</span>
                <%}%>
                <%if(hasPerMaster && hasPerAdmin && !hasPerPermission){%>
                    <span>掌门/管理员</span>
                <%}%>
                <%if(hasPerMaster && !hasPerAdmin && hasPerPermission){%>
                    <span>掌门/权限</span>
                <%}%>
                <%if(!hasPerMaster && hasPerAdmin && hasPerPermission){%>
                    <span>管理员/权限</span>
                <%}%>
                <%if(hasPerMaster && !hasPerAdmin && !hasPerPermission){%>
                    <span>掌门</span>
                <%}%>
                <%if(!hasPerMaster && hasPerAdmin && !hasPerPermission){%>
                    <span>管理员</span>
                <%}%>
                <%if(!hasPerMaster && !hasPerAdmin && hasPerPermission){%>
                <span>权限</span>
                <%}%>
                <ul>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Master, userBean)){%>
                    <li id="master_manage">掌门管理</li>
                    <%}%>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Admin, userBean)){%>
                    <li id="admin_manage">管理员管理</li>
                    <%}%>
                    <%if(GlobalUtils.checkUserPermission(Constant.Per_Permission, userBean)){%>
                    <li id="permission_manage">权限管理</li>
                    <%}%>
                </ul>
            </li>
            <%}%>
        </ul>
    </div>
    <%}else{%>
        <div style="height: 200px;"></div>
        <div style="height:100px;font-size: 30px;line-height: 60px;">您没有权限，请向管理员申请权限后重试</div>
    <%}%>
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
