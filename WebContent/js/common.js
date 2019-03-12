/*验证码*/
var code; //在全局 定义验证码
function createCode() {
  code = "";
  var codeLength = 6;//验证码的长度  
  var checkCode = document.getElementById("identifyCode");
  var selectChar = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');//所有候选组成验证码的字符，当然也可以用中文的  
  
  for (var i = 0; i < codeLength; i++) {
    var charIndex = Math.floor(Math.random() * 36);
    code += selectChar[charIndex];
  }
  if (checkCode) {
    checkCode.className = "code";
    checkCode.value = code;
  }
}




/*年月日*/
 $(function(){ 
    $.ms_DatePicker({ 
            YearSelector: ".sel_year", 
            MonthSelector: ".sel_month", 
            DaySelector: ".sel_day" 
    }); 
}); 

(function($){ 
$.extend({ 
ms_DatePicker: function (options) { 
   var defaults = { 
         YearSelector: "#sel_year", 
         MonthSelector: "#sel_month", 
         DaySelector: "#sel_day", 
         FirstText: "--", 
         FirstValue: 0 
   }; 
   var opts = $.extend({}, defaults, options); 
   var $YearSelector = $(opts.YearSelector); 
   var $MonthSelector = $(opts.MonthSelector); 
   var $DaySelector = $(opts.DaySelector); 
   var FirstText = opts.FirstText; 
   var FirstValue = opts.FirstValue; 
 
   // 初始化 
   var str = "<option value=\"" + FirstValue + "\">"+FirstText+"</option>"; 
   $YearSelector.html(str); 
   $MonthSelector.html(str); 
   $DaySelector.html(str); 
 
   // 年份列表 
   var yearNow = new Date().getFullYear(); 
   var yearSel = $YearSelector.attr("rel"); 
   for (var i = yearNow; i >= 1900; i--) { 
        var sed = yearSel==i?"selected":""; 
        var yearStr = "<option value=\"" + i + "\" " + sed+">"+i+"</option>"; 
        $YearSelector.append(yearStr); 
   } 
 
    // 月份列表 
    var monthSel = $MonthSelector.attr("rel"); 
    for (var i = 1; i <= 12; i++) { 
        var sed = monthSel==i?"selected":""; 
        var monthStr = "<option value=\"" + i + "\" "+sed+">"+i+"</option>"; 
        $MonthSelector.append(monthStr); 
    } 
 
    // 日列表(仅当选择了年月) 
    function BuildDay() { 
        if ($YearSelector.val() == 0 || $MonthSelector.val() == 0) { 
            // 未选择年份或者月份 
            $DaySelector.html(str); 
        } else { 
            $DaySelector.html(str); 
            var year = parseInt($YearSelector.val()); 
            var month = parseInt($MonthSelector.val()); 
            var dayCount = 0; 
            switch (month) { 
                 case 1: 
                 case 3: 
                 case 5: 
                 case 7: 
                 case 8: 
                 case 10: 
                 case 12: 
                      dayCount = 31; 
                      break; 
                 case 4: 
                 case 6: 
                 case 9: 
                 case 11: 
                      dayCount = 30; 
                      break; 
                 case 2: 
                      dayCount = 28; 
                      if ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) { 
                          dayCount = 29; 
                      } 
                      break; 
                 default: 
                      break; 
            } 
                     
            var daySel = $DaySelector.attr("rel"); 
            for (var i = 1; i <= dayCount; i++) { 
                var sed = daySel==i?"selected":""; 
                var dayStr = "<option value=\"" + i + "\" "+sed+">" + i + "</option>"; 
                $DaySelector.append(dayStr); 
             } 
         } 
      } 
      $MonthSelector.change(function () { 
         BuildDay();       
      }); 
      $YearSelector.change(function () { 
      	BuildDay();
         var year=new Date().getFullYear();
         var age=year-$(".sel_year").val();
         $("#age").val(age);

      }); 
      if($DaySelector.attr("rel")!=""){ 
         BuildDay(); 
      } 
   } // End ms_DatePicker 
}); 
})(jQuery); 