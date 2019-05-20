package GSON.NeteaseMusic;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

public class Detail implements Serializable {
    /**
     *
     * 网易云音乐歌曲的整体详细信息
     * 对应api ：https://api.imjad.cn/cloudmusic/?type=detail&id=  +  song_id
     *
     * */
    @SerializedName("name")
    public String name;                         //歌曲名
    @SerializedName("id")
    public String id;                               //歌曲id
    @SerializedName("ar")
    public List<Artist> artists;           //该歌曲的艺人列表
    @SerializedName("al")
    public Album album;                      //专辑
}
