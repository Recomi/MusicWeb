package servlet;

import bean.User;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.*;

@WebServlet("/servlet.Login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, UnsupportedEncodingException {
        resp.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String userName = req.getParameter("userName");
        String pass = req.getParameter("pass");
        boolean flag = false;
        try {
            flag = UserDao.checkPassword(userName,pass);
        }catch (SQLException e) {
            e.printStackTrace();
        }
        if (flag) {
            User user = new User();
            user.setUserName(userName);
            req.getSession().setAttribute("user",user);
            req.getSession().setAttribute("userName",userName);
            resp.sendRedirect("index.jsp");
        }
        else
            resp.sendRedirect("Login.jsp");
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
