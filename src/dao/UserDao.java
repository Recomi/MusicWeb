package dao;

import bean.User;
import util.SQL_util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    public static boolean whether_userName_exists(String userName) throws SQLException {
        SQL_util sqlUtil = new SQL_util();
        PreparedStatement statement = sqlUtil.getPreparedStatement("select * from user_info where user_name=?");
        statement.setString(1, userName);
        ResultSet resultSet = statement.executeQuery();
        sqlUtil.close();
        return resultSet.next();
    }

    public static boolean checkPassword(String userName,String password) throws SQLException {
        SQL_util sqlUtil = new SQL_util();
        PreparedStatement statement = sqlUtil.getPreparedStatement("select * from user_info where user_name=? and password=?");
        statement.setString(1, userName);
        statement.setString(2, password);
        sqlUtil.close();
        ResultSet resultSet = statement.executeQuery();
        return resultSet.next();
    }
    public static User getUserInfo() {
        return null;
    }

    public static int signupUser(String userName,String password) throws SQLException {
        SQL_util sqlUtil = new SQL_util();
        PreparedStatement statement = sqlUtil.getPreparedStatement(
                "insert into user_info (user_name, password, email, real_name, school, student_id, age, birthday, sex) " +
                        "  values " +
                        "  (?,?,null,null,null,null,null,null,null) "
        );
        statement.setString(1, userName);
        statement.setString(2, password);
        int result = statement.executeUpdate();
        sqlUtil.close();
        return result;
    }
}
