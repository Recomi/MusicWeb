package dao;

import GSON.NeteaseMusic.Detail;
import GSON.NeteaseMusic.Lyric_Gson;
import GSON.NeteaseMusic.Search.SearchSong;
import bean.Music_complete;
import com.google.gson.Gson;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import util.StringUtil;

import java.io.IOException;

public class NeteaseMusicDao {
    public static final int SEARCH_TYPE_SONG = 1;
    public static final int SEARCH_TYPE_ALBUM = 10;
    public static final int SEARCH_TYPE_VOCALIST= 100;
    public static final int SEARCH_TYPE_SONGLIST = 1000;
    public static final int SEARCH_TYPE_USER = 1002;
    public static final int SEARCH_TYPE_MV = 1004;
    public static final int SEARCH_TYPE_LYRICS = 1006;
    public static final int SEARCH_TYPE_ANCHOR_STATION = 1009;

    private OkHttpClient client;

    public NeteaseMusicDao() {
        client = new OkHttpClient();
    }

    public static void main(String [] args) throws IOException, JSONException {
//        NeteaseMusicDao dao  = new NeteaseMusicDao();
//        Detail detail = dao.get_music_info("446512251");
//        System.out.println(detail.name);
//        GSON.NeteaseMusic.Song song = dao.get_music_link("27843535");
//        System.out.println(song.url);
//        SearchSong search_song = (SearchSong) dao.search("yongjiu",SEARCH_TYPE_SONG);
//        System.out.println(search_song.songs.get(0).name);
    }

    public Object search(String search_text, int search_type,String offset) throws IOException, JSONException {
        Request request = new Request.Builder()
                .url("https://api.imjad.cn/cloudmusic/?type=search&search_type=" + search_type
                        + "&s=" + search_text
                        + "&offset=" + offset )
                .build();
        Response response = client.newCall(request).execute();
        String result = response.body().string();
        switch (search_type) {
            case SEARCH_TYPE_SONG:
                JSONObject json_resullt = new JSONObject(result).getJSONObject("result");
                SearchSong searchSong = new Gson().fromJson(json_resullt.toString(),SearchSong.class);
                return searchSong;
        }
        return null;
    }

    public Music_complete get_music_complete(String song_id) throws IOException, JSONException {
        String link = get_music_link(song_id);
        Detail detail = get_music_detail(song_id);
        StringBuffer artists_str = new StringBuffer("");
        for (int i = 0 ; i <= detail.artists.size() -1 ; i++) {
            if ( i <= detail.artists.size() -1)
                artists_str.append(detail.artists.get(i));
            else
                artists_str.append(detail.artists.get(i)).append("/");
        }
        String album = detail.album.name;
        String picUrl = detail.album.picUrl;
        String lyric_unicode = get_music_lyric(song_id);
        String lyric_str = get_music_lyric(song_id);
        Music_complete complete = new Music_complete(
            detail.id,detail.name,link,artists_str.toString(),album,picUrl,"999+",lyric_str
        );
        return complete;
    }

    public Detail get_music_detail(String song_id) throws IOException, JSONException {
        Request request = new Request.Builder()
                .url("https://api.imjad.cn/cloudmusic/?type=detail&id=" + song_id)
                .build();
        Response response = client.newCall(request).execute();
        String result = response.body().string();
        JSONObject result_json = new JSONObject(result);
        JSONArray songs_array = result_json.getJSONArray("songs");
        String gson_str = songs_array.getJSONObject(0).toString();
        Detail detail = new Gson().fromJson(gson_str , Detail.class);
        return detail;
    }

    public String get_music_link(String song_id) throws IOException, JSONException {
        Request request = new Request.Builder()
                .url("https://api.imjad.cn/cloudmusic/?type=song&id=" + song_id)
                .build();
        Response response = client.newCall(request).execute();
        String result = response.body().string();
        JSONObject result_json = new JSONObject(result);
        JSONArray songs_array = result_json.getJSONArray("data");
        String gson_str = songs_array.getJSONObject(0).toString();
        GSON.NeteaseMusic.Song song = new Gson().fromJson(gson_str , GSON.NeteaseMusic.Song.class);
        return song.url;
    }

    public String get_music_lyric(String song_id) throws IOException {
        Request request = new Request.Builder()
                .url("https://api.imjad.cn/cloudmusic/?type=lyric&id=" + song_id)
                .build();
        Response response = client.newCall(request).execute();
        String result = response.body().string();
        JSONObject result_json = null;
        try {
            result_json = new JSONObject(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        boolean is_nolyric = false;         //是否是纯音乐
        boolean is_uncollected = false;    //是否没有收录歌词
        //纯音乐，无歌词
        try {
            is_nolyric = result_json.getBoolean("nolyric");
        } catch (JSONException e) { }
        if (is_nolyric)
            return "纯音乐，无歌词";
        //歌词未收录
        try {
            is_uncollected = result_json.getBoolean("uncollected");
        } catch (JSONException e) { }
        if (is_uncollected)
            return "暂时没有歌词";
        // default
        String gson_str = result_json.toString();
        Lyric_Gson lyric_gson = new Gson().fromJson(gson_str , Lyric_Gson.class);
        //歌词文本，同时将unicode转译String
        String lyric_str =  StringUtil.unicodeStr2String(lyric_gson.lyric.lyric_str);
        if (lyric_str.equals(""))
            lyric_str = "暂时没有歌词";
        return lyric_str;
    }
}
