<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page autoFlush="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/9/5
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%--<%= new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds()%>--%>
<%
    // 获取当前时间
    Calendar calendar = new GregorianCalendar();
    String am_pm;
    int hour = calendar.get(Calendar.HOUR);
    int minute = calendar.get(Calendar.MINUTE);
    int second = calendar.get(Calendar.SECOND);
    if(calendar.get(Calendar.AM_PM) == 0)
        am_pm = "AM";
    else
        am_pm = "PM";
    String CT = hour+":"+ minute +":"+ second +" "+ am_pm;
    out.println(CT + "\n");
%>