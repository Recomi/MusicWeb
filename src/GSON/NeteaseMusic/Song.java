package GSON.NeteaseMusic;

import com.google.gson.annotations.SerializedName;

public class Song {
    /**
     *
     * 网易云音乐歌曲的简要信息——主要用作爬取下载地址
     * 对应api ：https://api.imjad.cn/cloudmusic/?type=song& +  song_id
     *
     * */
    @SerializedName("id")
    public String id;
    @SerializedName("url")
    public String url;
    @SerializedName("br")
    public String tone_quality;
    @SerializedName("size")
    public String size;
    @SerializedName("md5")
    public String md5;
    @SerializedName("code")
    public String result_code;
    @SerializedName("type")
    public String type;
}
