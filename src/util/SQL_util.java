package util;

import java.sql.*;

public class SQL_util {
    private String driverStr = "com.mysql.jdbc.Driver";
    private String connStr = "jdbc:mysql://127.0.0.1:3306/class_web?useSSL=false";
    private String dbusername = "root";
    private String dbpassword = "qingcloud";
    private Connection conn = null;
    private Statement stmt = null;
    private PreparedStatement preStmt = null;

    public SQL_util() {
        try {
            Class.forName(driverStr);
            conn = DriverManager.getConnection(connStr, dbusername, dbpassword);
            stmt = conn.createStatement();
        }
        catch (Exception ex) {
            System.out.println("数据连接失败！");
        }
    }

    public PreparedStatement getPreparedStatement(String sql) throws SQLException {
        return conn.prepareStatement(sql);
    }

    public int executeUpdate(String s) {
        int result = 0;
        System.out.println("--更新语句:"+s+"\n");
        try {
            result = stmt.executeUpdate(s);
        } catch (Exception ex) {
            System.out.println("执行更新错误！");
        }
        return result;
    }

    public ResultSet executeQuery(String s) {
        ResultSet rs = null;
        System.out.print("--查询语句:"+s+"\n");
        try {
            rs = stmt.executeQuery(s);
        } catch (Exception ex) {
            System.out.println("ִ执行查询错误！");
        }
        return rs;
    }
    public void execQuery(String s){
        try {
            stmt.executeUpdate(s);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            System.out.println("执行插入错误！");
        }
    }

    public void close() {
        try {
            stmt.close();
            preStmt.close();
            conn.close();
        } catch (Exception e) {
        }
    }
}