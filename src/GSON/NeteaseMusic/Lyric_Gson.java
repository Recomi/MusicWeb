package GSON.NeteaseMusic;

import com.google.gson.annotations.SerializedName;

public class Lyric_Gson {
    @SerializedName("lrc")
    public Lyric lyric;
    @SerializedName("tlyric")
    public Lyric tlyric;

    //歌词类（Json）
    public class Lyric {
        @SerializedName("version")
        public int version;
        @SerializedName("lyric")
        public String lyric_str;
    }
}
