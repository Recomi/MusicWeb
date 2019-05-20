package servlet;

import GSON.NeteaseMusic.Search.SearchSong;
import GSON.NeteaseMusic.Search.Songs;
import dao.NeteaseMusicDao;
import org.json.JSONException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/servlet.Search")
public class Search extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NeteaseMusicDao dao = new NeteaseMusicDao();    //dao工具
        String search_str = "null"; //搜索关键字
        String page = "1";  //当前想进入的页 码
        String max_pages = "1";  //分页页码上限（默认为1）
        SearchSong searchSong = null;
        List<Songs> songsList = null;
        String offset = "0";    //以第几条歌曲-1开始检索 >> 即当前页码显示的第一条歌曲的总序号 （初始为0）
        int count_songs = 0;    //搜索到的歌曲总数量
        int page_max_songs = 20;  //网易官方API每次搜索最多只提供20首歌曲
        //
        try {   //获取搜索关键字
            search_str = request.getParameter("s_text");
        }catch (Exception e) {
            //当出现异常时（缺少s_text参数），默认为"null"关键字
        }
        try {   //获取当前想进入的页码
            page = request.getParameter("page");
        }catch (Exception e3) {
        }
        //空指针时，page默认值为"1"
        if (page == null)
            page = "1";
        System.out.println("搜索：当前访问页码为" + page);
        // 网易云音乐API参数之一 >> 以第几条歌曲-1开始检索
        offset = String.valueOf(
                (Integer.parseInt(page) - 1) * 20    // 注：全部搜索结果的第一条歌曲的offset是0
        );
        //获取歌曲信息
        try {
            searchSong = (SearchSong) dao.search(search_str,NeteaseMusicDao.SEARCH_TYPE_SONG,offset);
            songsList = searchSong.songs;
            count_songs = Integer.parseInt(searchSong.songCount);
        } catch (JSONException | NullPointerException e2) {  }
        // 分页页码上限
        max_pages = String.valueOf(
                (int) Math.ceil((double) count_songs / page_max_songs)
        );
        System.out.println("Count Search : " + count_songs);
        request.setAttribute("SongsList",songsList);
        request.setAttribute("count_all",count_songs);
        request.setAttribute("max_pages",max_pages);
        request.getRequestDispatcher("Search.jsp").forward(request,response);
    }
}
