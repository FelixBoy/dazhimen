/**
 * 消息管理工具类
 */
var MsgBox = (function(){
	var MSGBOX_DOMID = StringUtil.getUUID();
	var MSGBOX_FADEOUT_LESS_INTEVAL = 6000;
	var MSGBOX_FADEOUT_MORE_INTEVAL = 15000;
	var exports = {};
	var timeoutMsgBox = null;
	var fixedState = false; // true代表固定 false不固定
	
	
	var g_bundleObject = null; 	// 与MsgBox绑定的对象，
								// 若设定了这个对象，则框架定时轮训这个对象的active状态（调用它的isActive接口），
								// 若返回结果为false，则隐藏MsgBox
	
	var $msgBox = null,
		$msgBoxText = null,
		$msgBoxClose = null,
		$msgBoxFixed = null,
		$msgBoxDetail = null;
	
	var MSGBIGBOX_DOMID = StringUtil.getUUID();
	var $msgBigBox = null,
		$msgBigBoxTextMsg = null,
		$msgBigBoxTextDetail = null,
		$msgBigBoxTopMidLine = null,
		$msgBigBoxBottomMidLine = null,
		$msgBigBoxMid = null,
		$msgBigBoxClose = null;
	
	
	var msgString = null,
		detailString = null;
	
	var SwitchFixedBtnPic = function(){
		if(fixedState){
			$msgBoxFixed.removeClass("fixed");
			fixedState = false;
		}else{
			$msgBoxFixed.addClass("fixed");
			fixedState = true;
		}
	};
	
	var fixedBtnClick = function(msg){
		if(fixedState){
			if(timeoutMsgBox){
				clearTimeout(timeoutMsgBox);
				timeoutMsgBox = null;
			}
			$msgBox.show();
			fixedState = true;
		}else{
			if(timeoutMsgBox){
				clearTimeout(timeoutMsgBox);
				timeoutMsgBox = null;
			}
			setTimeOutMsgBox.call(this,msg);
			fixedState = false;
		}
	};
	
	var setTimeOutMsgBox = function(msg){
		if(typeof msg === undefined || (typeof msg === "string" && msg.length <= 30)){
			timeoutMsgBox = setTimeout(function(){$msgBox.fadeOut("slow");}, MSGBOX_FADEOUT_LESS_INTEVAL);
		}else{
			timeoutMsgBox = setTimeout(function(){$msgBox.fadeOut("slow");}, MSGBOX_FADEOUT_MORE_INTEVAL);
		}
	};
	
	var setMsgBigBoxWidth = function(msgBoxTextWidth){
		try{
			var msgBigBoxLeftTopRoundWidth = 24,
				msgBigBoxRightTopRoundWidth = 20,
				msgBigBoxLeftBottomRoundWidth = 19,
				msgBigBoxRightBottomRoundWidth = 20,
				msgBigBoxMidMarginRight = parseInt($msgBigBoxMid.css("marginRight")),
				msgBigBoxMidTextMsgMarginLeft = parseInt($msgBigBoxTextMsg.css("marginLeft")),
				msgBigBoxMidTextMsgMarginRight = parseInt($msgBigBoxTextMsg.css("marginRight"));
				msgBigBoxWidth = null;
				
			if(!msgBoxTextWidth){
				alert("MsgBox.setMsgBigBoxWidth方法入参MsgBoxText的【宽度】不能为空！")
			}
			
			msgBigBoxWidth  = msgBoxTextWidth + msgBigBoxMidTextMsgMarginLeft + msgBigBoxMidTextMsgMarginRight  + msgBigBoxMidMarginRight;
			if(msgBigBoxWidth < 466){
				msgBigBoxWidth = 466;
			}
			
			$msgBigBox.css({
				"width": msgBigBoxWidth
			});
			
			$msgBigBoxTopMidLine.css({
				"width": msgBigBoxWidth - msgBigBoxLeftTopRoundWidth - msgBigBoxRightTopRoundWidth
			});
			
			$msgBigBoxBottomMidLine.css({
				"width": msgBigBoxWidth - msgBigBoxLeftBottomRoundWidth - msgBigBoxRightBottomRoundWidth - msgBigBoxMidMarginRight
			});
			
			$msgBigBoxTextMsg.css({
				"max-width": msgBigBoxWidth - msgBigBoxMidMarginRight - msgBigBoxMidTextMsgMarginLeft - msgBigBoxMidTextMsgMarginRight
			});
			
		}catch(oE){
        	Exception.handler("MsgBigBox.setMsgBigBoxWidth", oE);
    	}
	};
	
	var showDetail = function(msg,detailStr,msgBoxTextWidth){
		try{
			var htmlArr = [],
			    msgSplitStr,
			    i;
			
			if(!$("#"+MSGBIGBOX_DOMID).length){
				
				// 注意dw-msgbox下的3个div标签一定不能加入空格，否则会导致div间会存在间距
				// 参考：http://www.zhangxinxu.com/wordpress/2012/04/inline-block-space-remove-%E5%8E%BB%E9%99%A4%E9%97%B4%E8%B7%9D/
				htmlArr.push("<div class=\"dw-msgbigbox\" id=\""+MSGBIGBOX_DOMID+"\">");
				htmlArr.push(		"<div class=\"dw-msgbigbox-top\">");
				htmlArr.push(			"<div class=\"dw-msgbigbox-top-leftTopRound\"></div>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-top-midTopLine\"></div>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-top-closeBtn\"></div>");
				htmlArr.push(		"</div>");
				htmlArr.push(		"<div class=\"dw-msgbigbox-mid\">");
				htmlArr.push(			"<span class=\"dw-msgbigbox-mid-MsgText\"></span>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-mid-line\"></div>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-mid-DetailText\"></div>");
				htmlArr.push(		"</div>");
				htmlArr.push(		"<div class=\"dw-msgbigbox-bottom\">");
				htmlArr.push(			"<div class=\"dw-msgbigbox-bottom-leftBottomRound\"></div>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-bottom-midBottomLine\"></div>");
				htmlArr.push(			"<div class=\"dw-msgbigbox-top-rightBottomRound\"></div>");
				htmlArr.push(		"</div>");
				htmlArr.push("</div>");
    			$(htmlArr.join("")).appendTo("body");
    			
    			$msgBigBox = $("#"+MSGBIGBOX_DOMID);
    			$msgBigBoxTextMsg = $msgBigBox.find(".dw-msgbigbox-mid-MsgText");
    			$msgBigBoxTextDail = $msgBigBox.find(".dw-msgbigbox-mid-DetailText");
    			$msgBigBoxClose = $msgBigBox.find(".dw-msgbigbox-top-closeBtn");
    			$msgBigBoxTopMidLine = $msgBigBox.find(".dw-msgbigbox-top-midTopLine");
    			$msgBigBoxBottomMidLine = $msgBigBox.find(".dw-msgbigbox-bottom-midBottomLine");
    			$msgBigBoxMid = $msgBigBox.find(".dw-msgbigbox-mid"); 
    			
    			//绑定关闭事件
    			$msgBigBoxClose.bind("click", function(){
    				$msgBigBox.hide();
    			});
    		}
			
			setMsgBigBoxWidth(msgBoxTextWidth);
			$msgBigBoxTextMsg.html("<span>" + HTMLEncode(msg) + "</span>");
			$msgBigBoxTextMsg.attr("title", msg);
			$msgBigBoxTextDail.html("<div>" + HTMLEncode(detailStr) + "</div>");
			$msgBigBoxTextDail.attr("title", detailStr);

			$msgBigBox.css({
				"left" : ($("body").width() - $msgBigBox.width() )/2
			});
			$msgBigBox.fadeIn("slow");
		}catch(oE){
        	Exception.handler("MsgBigBox.showDetail", oE);
    	}
	};
	

	function HTMLEncode(str) {
		if (str.length == 0)
			return "";

		var s = null;
		s = str.replace(/&/g, "&gt;");
		s = s.replace(/</g, "&lt;");
		s = s.replace(/>/g, "&gt;");
		s = s.replace(/ /g, "&nbsp;");
		s = s.replace(/\'/g, "'");
		s = s.replace(/\"/g, "&quot;");
		s = s.replace(/\n/g, "<br>");
		return s;
	};
	
	// 新版showBox
	exports.show = function(msg,detailStr){
		try{
			var htmlArr = [],
				msgBoxTextWidth = null;
			
			if(!$("#"+MSGBOX_DOMID).length){
				
				// 注意dw-msgbox下的3个span标签一定不能加入空格，否则会导致span间会存在间距
				// 参考：http://www.zhangxinxu.com/wordpress/2012/04/inline-block-space-remove-%E5%8E%BB%E9%99%A4%E9%97%B4%E8%B7%9D/
				htmlArr.push("<span class=\"dw-msgbox\" id=\""+MSGBOX_DOMID+"\">");
				htmlArr.push(		"<span class=\"dw-msgbox-left\"></span>");
				htmlArr.push(		"<span class=\"dw-msgbox-mid\">");
				htmlArr.push(			"<span class=\"dw-msgbox-mid-text\"></span>");
				htmlArr.push(			"<span class=\"dw-msgbox-mid-fixedBtn\"></span>");
				htmlArr.push(			"<span class=\"dw-msgbox-mid-detailBtn\"></span>");
				htmlArr.push(		"</span>");
				htmlArr.push(		"<span class=\"dw-msgbox-right\"></span>");
				htmlArr.push("</span>");
    			$(htmlArr.join("")).appendTo("body");
    			
    			$msgBox = $("#"+MSGBOX_DOMID);
    			$msgBoxText = $msgBox.find(".dw-msgbox-mid-text");
    			$msgBoxClose = $msgBox.find(".dw-msgbox-right");
    			$msgBoxFixed = $msgBox.find(".dw-msgbox-mid-fixedBtn");
    			$msgBoxDetail = $msgBox.find(".dw-msgbox-mid-detailBtn");
    			
    			//绑定关闭事件
    			$msgBoxClose.bind("click", function(){
    				fixedState = false;
    				$msgBoxFixed.removeClass("fixed");
    				$msgBox.hide();
    			});
    		}
			msgString = msg;
			detailString = detailStr;
			$msgBoxText.text(msg);
			$msgBoxText.attr("title", msg);
			$msgBox.css({
				"left" : ($("body").width() - $msgBox.width() )/2
			});
			
			if($msgBigBox != null){
				$msgBigBox.hide();
			}
			
			if(timeoutMsgBox){
				clearTimeout(timeoutMsgBox);
				timeoutMsgBox = null;
			}
				
			//确保新打开的按钮是原始状态
			fixedState = false;
			if(fixedState){
				$msgBoxFixed.removeClass("fixed");
				$msgBoxFixed.addClass("fixed");
			}else{
				$msgBoxFixed.removeClass("fixed");
			}
			
			
			//绑定锁定事件
			$msgBoxFixed.unbind("click").bind("click",function(){
				SwitchFixedBtnPic.call(this);
				fixedBtnClick.call(this,msg);
			});
			
			if(fixedState){
				$msgBox.fadeIn("slow");
			}else{
				$msgBox.fadeIn("slow");
				setTimeOutMsgBox(msg);
			}			
			
			$msgBoxFixed.show();
			$msgBoxDetail.show();
			if(typeof detailStr !== "undefined"  && (typeof detailStr === "string") ){
				$msgBoxDetail.unbind("click").bind("click",function(){
					msgBoxTextWidth = $msgBoxText.width();
					$msgBox.hide();	
					showDetail(msg,detailStr,msgBoxTextWidth);
				});
				$msgBoxFixed.hide();
			}else{
				$msgBoxDetail.hide();
			}
			
			
			// 开定时器检测bundleObject是否处于可operate状态
			var bundleCheckerTimer = setInterval(function(){
				try{
					if(!g_bundleObject){
						g_bundleObject = null;
						clearInterval(bundleCheckerTimer);
						return;
					}
					
					if(!g_bundleObject.isOperatable()){
						g_bundleObject = null;
						clearInterval(bundleCheckerTimer);
						if($msgBigBox){
							$msgBigBox.hide();
						}
						if($msgBox){
							$msgBox.hide();
						}
					}
				}catch(ex){
					clearInterval(bundleCheckerTimer);
					g_bundleObject = null;
				}
			}, 500);
		}catch(oE){
        	Exception.handler("MsgBox.show", oE);
    	}
	};
	
	
	exports.isExist = function(){
		try{
			if($("#"+MSGBOX_DOMID).length && $("#"+MSGBOX_DOMID).css("display") != "none"){
				return true;
			}
			if($("#"+MSGBIGBOX_DOMID).length && $("#"+MSGBIGBOX_DOMID).css("display") != "none"){
				return true;
			}
			return false;
		}catch(oE){
			Exception.handler("MsgBox.isExist",oE);
		}
	};
	
	exports.fix = function(){
		try{
			if($("#"+MSGBOX_DOMID) && $("#"+MSGBOX_DOMID).length && $("#"+MSGBOX_DOMID).css("display") != "none"){
				if($msgBoxFixed.css("display") != "none" && !fixedState){
					$msgBoxFixed.addClass("fixed");
					if(timeoutMsgBox){
						clearTimeout(timeoutMsgBox);
						timeoutMsgBox = null;
					}
					$msgBox.show();
					fixedState = true;
				}else if($msgBoxDetail.css("display") != "none" && $msgBoxText.length){
					var msgBoxTextWidth = $msgBoxText.width();
					$msgBox.hide();	
					showDetail(msgString,detailString,msgBoxTextWidth);
				}
			}
		}catch(oE){
			Exception.handler("MsgBox.fix",oE);
		}
	};
	
	exports.bundleObject = function(object){
		try{
			if(object == null){
				return;
			}
			
			if(!(object instanceof STagI)){
				alert("MsgBox.bundleObject入参【object】必须是框架标签的JS对象，请检查!");
				return;
			}
			
			g_bundleObject = object;
		}catch(ex){
			Exception.handler("MsgBox.bundleObject",oE);
		}
	};
	
	//提示框
	exports.alert = function(title,msg,fn){
		try{
			$.messager.alert(title, msg, null, fn);
		}catch(oE){
			Exception.handler("MsgBox.alert()",oE);
		}
	};
	return exports;
}());