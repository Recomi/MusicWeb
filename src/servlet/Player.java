package servlet;

import bean.Music_complete;
import dao.NeteaseMusicDao;
import org.json.JSONException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/servlet.Player")
public class Player extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NeteaseMusicDao dao = new NeteaseMusicDao();
        String id = "";
        Music_complete complete = null;
//        String source = "source";
        try {
            id = request.getParameter("id");
//            source = request.getParameter("source");
        }catch (Exception e) {e.printStackTrace(); }
        try {
            complete = dao.get_music_complete(id);
        } catch (JSONException e) { e.printStackTrace();}
        //
        request.setAttribute("music_complete",complete);
        System.out.println("Player : " + id);
        request.getRequestDispatcher("/Player.jsp").forward(request,response);
    }
}
