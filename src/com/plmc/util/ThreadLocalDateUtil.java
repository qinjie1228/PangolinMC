package com.plmc.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ThreadLocalDateUtil {
    private static final String date_format = "yyyy-MM-dd HH:mm:ss";
    private static ThreadLocal<DateFormat> threadLocal = new ThreadLocal<DateFormat>(); 
 
    public static DateFormat getDateFormat()   
    {  
        DateFormat df = threadLocal.get();  
        if(df==null){  
            df = new SimpleDateFormat(date_format);  
            threadLocal.set(df);  
        }  
        return df;  
    }  
 
    public static String formatDate(Date date) throws ParseException {
        return getDateFormat().format(date);
    }
 
    public static Date parse(String strDate) throws ParseException {
        return getDateFormat().parse(strDate);
    } 
    
    public static long dateCalculate(Date dateMinuend, Date dateSubtrahend) throws ParseException {
    	String dateMinuendStr = getDateFormat().format(dateMinuend);
        String dateSubtrahendStr = getDateFormat().format(dateSubtrahend);
        
        Date dateMinuendDate = getDateFormat().parse(dateMinuendStr);
        Date dateSubtrahendDate = getDateFormat().parse(dateSubtrahendStr);
		return dateMinuendDate.getTime() - dateSubtrahendDate.getTime();
    	
    }
}