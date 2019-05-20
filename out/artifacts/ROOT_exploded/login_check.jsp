<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: kermi
  Date: 2018/10/29
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% //  init
    request.setCharacterEncoding("UTF-8");
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");
    boolean flag = false;
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet rs = null;
%>
<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://127.0.0.1:3306/class_web?useSSL=false";
    String sql_user = "root";
    String sql_pass = "";
    Class.forName(driver);
    conn = DriverManager.getConnection(url,sql_user,sql_pass);
    statement = conn.prepareStatement("select * from user_info where user_name=? and password=?");
    statement.setString(1,user);
    statement.setString(2,pass);
    rs = statement.executeQuery();
    if (rs.next()) {
        flag = true;
    }
    rs.close();
    statement.close();
    conn.close();
%>
<html>
<head>
    <title>Checking password...</title>
</head>
<body>

<%  if (flag == true) { %>
    <div>servlet.Login success.</div>
<%  }else { %>
    <div>servlet.Login failed.Check your user name and password</div>
<%  }%>
</body>
</html>
