<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fluid Layout - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js"></script>
    <script>
        $(function(){
            $('#menu-tree').tree({
                onClick: function(node){
//            alert(node.id);  // 在用户点击的时候提示
                    $("#center_oper_area").panel({title: node.text});
                    forwardUserManage(node.id);

                }
            });
        });
        function forwardUserManage(nodeid){
            switch (nodeid){
                case 'master_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdMasterManagePage",
                        onLoad:function(){
                        }
                    });
                    break;
            }
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">主标题栏</div>
<div data-options="region:'west',split:false,title:'导航菜单'" style="width:240px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <div class="easyui-panel" style="padding:5px">
        <ul id="menu-tree" class="easyui-tree">
            <li  id="user_manage" data-options="state:'closed'">
                <span>用户管理</span>
                <ul>
                    <li id="user_add">添加用户</li>
                    <li id="user_infor">用户详情</li>
                    <li id="user_modify">修改详情</li>
                </ul>
            </li>
            <li id="recharge_manage" data-options="state:'closed'">
                <span>充值管理</span>
                <ul>
                    <li id="recharge_infor">充值详情</li>
                    <li id="recharge_add">添加充值</li>
                </ul>
            </li>
            <li id="order_manage" data-options="state:'closed'">
                <span>订单管理</span>
                <ul>
                    <li id="order_infor">订单详情</li>
                    <li id="order_add">添加订单</li>
                    <li id="order_modify">修改订单</li>
                    <li id="order_history">订单记录</li>
                </ul>
            </li>
            <li id="product_manage" data-options="state:'closed'">
`               <span>产品管理</span>
                <ul>
                <li id="product_info" data-options="state:'closed'">
                    <span>产品详情</span>
                    <ul>
                        <li id="product_order_infor">订单详情</li>
                    </ul>
                </li>
                <li id="product_upload">上传商品</li>
                <li id="product_modify">修改商品</li>
                </ul>
            </li>
            <li id="master_manage" data-options="state:'closed'">
                <span>掌门管理</span>
                <ul>
                    <li id="master_info" >掌门详情</li>
                    <li id="master_add">新增掌门</li>
                    <li id="master_modify">修改掌门</li>
                </ul>
            </li>
            <li id="content_manage" data-options="state:'closed'">
                <span>内容管理</span>
                <ul>
                    <li id="content_info" >内容详情</li>
                    <li id="content_add">新增内容</li>
                    <li id="content_modify">修改内容</li>
                </ul>
            </li>
            <li id="permission_manage" data-options="state:'closed'">
                <span>权限管理</span>
                <ul>
                    <li id="role_add" >新增权限角色</li>
                    <li id="permisssion_modify">权限修改</li>
                </ul>
            </li>
            <li id="admin_manage" data-options="state:'closed'">
                <span>管理员管理</span>
                <ul>
                    <li id="admin_add" >新增管理员</li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div id="center_oper_area" data-options="region:'center',title:' '">
    <div id="content_panel" class="easyui-panel"style="width:100%;height:200px;padding:10px;"
         data-options="fit:true,border:false">
    </div>
</div>
</body>
</html>
