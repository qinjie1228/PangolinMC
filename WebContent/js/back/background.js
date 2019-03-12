window.onload=function(){
	//自适当前应屏幕分辨率
	var mb = myBrowser();
	var windowHeight = window.screen.height;
	var windowWidth = window.screen.width;
	var main = document.getElementById("main"); 
//	if ("IE" == mb) {
//	    alert("我是 IE");
//	}
	if ("FF" == mb) {
		main.style.height = windowHeight*0.901 + "px";
		main.style.width = windowWidth*0.99899 + "px";
	}
	if ("Chrome" == mb) {
		main.style.height = windowHeight*0.92 + "px";
		main.style.width = windowWidth+ "px";
	}
//	if ("Opera" == mb) {
//	    alert("我是 Opera");
//	}
//	if ("Safari" == mb) {
//	    alert("我是 Safari");
//	}
}
function myBrowser(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1;
    if (isOpera) {
        return "Opera"
    }; //判断是否Opera浏览器
    if (userAgent.indexOf("Firefox") > -1) {
        return "FF";
    } //判断是否Firefox浏览器
    if (userAgent.indexOf("Chrome") > -1){
  return "Chrome";
 }
    if (userAgent.indexOf("Safari") > -1) {
        return "Safari";
    } //判断是否Safari浏览器
    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
        return "IE";
    }; //判断是否IE浏览器
}

$(document).ready(function(){
    $('#menu').tendina({
        openCallback: function(clickedEl) {
            clickedEl.addClass('opened');
        },
        closeCallback: function(clickedEl) {
            clickedEl.addClass('closed');
        }
    });
	
	$("#menu li a.firsta").click(function(){
			var status=$(this).next("ul").css("display");
			var firstchild_a=$(this).find("i");
			var all_lis=$(this).parents("ul").find("a.firsta i");
			all_lis.removeClass("xlcddown");
			all_lis.addClass("xlcd");
				
			if(status=="none"){
				firstchild_a.removeClass("xlcd");
				firstchild_a.addClass("xlcddown");
			}else{
				firstchild_a.removeClass("xlcddown");
				firstchild_a.addClass("xlcd");	
			}
		
		});
});

$(function(){
	
	$("#menu li.menu-list>ul>li").click(function(){
		$("#menu li.menu-list>ul>li").find("a").removeClass("specialclass");
		$(this).find("a",this).addClass("specialclass");
		
	})
})
	
$(function(){
    $("#ad_setting").click(function(){
        $("#ad_setting_ul").show();
    });
    $("#ad_setting_ul").mouseleave(function(){
        $(this).hide();
    });
    $("#ad_setting_ul li").mouseenter(function(){
        $(this).find("a").attr("class","ad_setting_ul_li_a");
    });
    $("#ad_setting_ul li").mouseleave(function(){
        $(this).find("a").attr("class","");
    });
});
