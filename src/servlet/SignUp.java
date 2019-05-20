package servlet;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

@WebServlet("/servlet.SignUp")
public class SignUp extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, UnsupportedEncodingException {
        resp.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String userName = req.getParameter("userName");
        String pass = req.getParameter("pass");
        int result = 0;
        try {
            result = UserDao.signupUser(userName,pass);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (result > 0 ) {
//            resp.sendRedirect("success.jsp");
            req.getRequestDispatcher("success.jsp").forward(req,resp);
        }else {
            resp.sendRedirect("servlet.Login.jsp");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
