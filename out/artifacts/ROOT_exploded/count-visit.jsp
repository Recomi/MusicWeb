<%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/9/5
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%!
    private int init = 0;
    private int response_ = 0;
    private int destory = 0;
%>
<%!
    public void jspInit(){
        init++;
    }
    public void jspDestory(){
        destory++;
    }
%>
<%
    response_++;
%>
