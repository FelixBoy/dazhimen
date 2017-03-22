<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<form>
		<input type="button" name="show1" value="换行测试" onclick="fnMsgBox(11)"></input>
		<input type="button" name="show2" value="detail一行测试" onclick="fnMsgBox(12)"></input>
		<input type="button" name="show3" value="长detail、换行" onclick="fnMsgBox(13)"></input>
		<input type="button" name="isExist" value="Msgbox.isExist" onclick="fnMsgBox(6)"></input>
		<input type="button" name="alert" value="没有detail" onclick="fnMsgBox(2)"></input>
		<input type="button" name="confirm" value="长detail" onclick="fnMsgBox(3)"></input>
		<input type="button" name="confirm11" value="长msg 短detail" onclick="fnMsgBox(5)"></input>
		<input type="button" name="confirm11" value="大于466 不出..." onclick="fnMsgBox(7)"></input>
		<input type="button" name="getDBDate" value="getDBDate" onclick="fnMsgBox(4)"></input>
		<input type="button" name="test1" value="测试fix1" onclick="testMsg(1)"></input>
		<input type="button" name="test2" value="测试fix2" onclick="testMsg(2)"></input>
		<input type="button" name="test3" value="测试fix3" onclick="testMsg(3)"></input>
		<input type="button" name="test4" value="测试fix4" onclick="testMsg(4)"></input>
		<input type="button" name="test5" value="测试fix5" onclick="testMsg(5)"></input>
		<input type="button" name="test6" value="测试fix6" onclick="testMsg(6)"></input>
</form>


<script type="text/javascript">

	function testMsg(para){
		switch(para){
		case 1:
			MsgBox.fix();
			break;
		case 2:
			MsgBox.fix();
			MsgBox.show("fix在前边");
			break;
		case 3:
			MsgBox.show("fix在后边");
			MsgBox.fix();
			break;
		case 4:
			MsgBox.fix();
			MsgBox.show("fix在前边1","fix在前边1");
			break;
		case 5:
			MsgBox.show("fix在后边1","fix在\n\n后边1");
			MsgBox.fix();
			break;
		case 6:
			MsgBox.fix();
			MsgBox.show(null,null);
			MsgBox.fix();
			break;
		}
	}
		
	function fnMsgBox(para){
		switch(para){
		case 11:
			MsgBox.fix();
			MsgBox.show("这是MsgBox.show函数的调用效果!调用效果!!", "你好的范围是否我发" + "\n" + "发发沙发来撒粉\r\n82！@##%￥#￥……￥#");
			break;
		case 12:
			MsgBox.show("  该业务不具备权限。", "具备权限的是：技术服务费服务、服务、搜房网。");
			MsgBox.fix();
			break;
		case 13:
			MsgBox.show("这是MsgBox.show函数的调用效果!调用效果!!","你好的范围\n是否我发发发沙发\n来撒粉丝服务服务费阿双方\n的首发发威范文芳是的发生访问粉色服务方式发生egesgdg你好的范围是否我发发发沙发来撒粉丝服务服务费阿双方的首发发威范文芳是的发生访问粉色服务方式发生egesgdg你你好的范围是否我发发发沙发来撒粉丝服务服务费阿双方的首发发威范文芳是的发生访问粉色服务方式发生egesgdg你好的范围是否我发发发沙发来撒粉丝服务服务费阿双方的首发发威范文芳是的发生访问粉色服务方式发生egesgdg你");
			break;
		case 2:
			MsgBox.show("你我是方法我发了个假两件发生了分解了文件佛法渐叟激发了山东科技管理的开发设计是否违法师傅师傅师傅的说法是方式飞洒发所发生的无法沃尔而定了深刻福建省上来看附件为 ");
			//MsgBox.show("ref","");
			//MsgBox.show("这是MsgBox.show");
			//MsgBox.alert("警告","这是MsgBox.alert函数的调用效果!!");
			break;
		case 3:
			MsgBox.show("该业务不具备权限。","    哎呀爱要服务费发私聊发完sdfdsfwfwfsfsfsfsg了非我方师傅就是了卡的飞机my favorite 离开我就发文件佛个我就疯了my favorite habbite is singing and dacing and singing and dancing and singing and dacing 哇房间里萨分局这是MsgBox.20收费服务方法是否是浪费是分开的时间付款了可加适量的开发交流交流空间的是否了解show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show这是MsgBox.show好汉是否为孙菲菲是否是是小玩排位分生栋覆屋山东地方服务服务范围是服务范围 舒服舒服卡普空无法借我是服务范围是否拉萨发了多少份简历上看到结果来看的价格了肯定发几个了快递费 ");
			break;
		case 4:
			alert(DateUtil.getDBDate());
			break;
		case 5:
			MsgBox.show("好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上","哎呀爱要服务费发私聊为是否是服务十分十分大方师傅师傅问热热身辅导费");
			break;
		case 6:
			alert(MsgBox.isExist());
			break;
		case 7:
			MsgBox.show("好好工作天天向上好好工作天天向上好好工作天天向上好好工作天天向上好好","哎呀爱要服务费发私聊为是否是服务十分十分大方师傅师傅问热热身辅导费");
			MsgBox.fix();
			break;
		}
	}
</script>
