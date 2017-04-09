
var LoadingMaskLayer = (function(){
	
	var count = 0;
	var domID = StringUtil.getUUID();

	var UI = (function(){
		var $layer = null;
		
		function show(){
			if( !$("#"+domID).length ){
				$layer = $("<div id=\""+domID+"\" class=\"dw-loadingmasklayer\"></div>").appendTo("body");
			}
			
			$layer.show();
		}
		
		function hide(){
			if( !$("#"+domID).length ){
				return;
			}
			$layer.hide();
		}
		
		return {
			show: show,
			hide: hide
		}
	}());

	/**
	 * 显示
	 */
	function show(){
		try{
			
			if( count < 0 ){
				alert("LoadingMaskLayer状态异常，计数器【count】为负值!");
				return;
			}
			
			if( count == 0 ){
				UI.show();
			}
			
			count++;
		}catch(oE){
			Exception.handler("LoadingMaskLayer.show", oE);
		}
	}
	
	/**
	 * 隐藏
	 */
	function hide(){
		try{
			if(count <= 0){
				return;
			}
			
			count--;
			
			if(count == 0){
				UI.hide();
			}
		}catch(oE){
			Exception.handler("LoadingMaskLayer.hide", oE);
		}
	}
	
	return {
		show: show,
		hide: hide
	};
	
}());