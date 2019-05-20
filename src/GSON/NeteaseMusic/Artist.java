package GSON.NeteaseMusic;

import com.google.gson.annotations.SerializedName;

public class Artist {
    /**
     * 某个艺人信息
     * */
    @SerializedName("name")
    public String name;
    @SerializedName("id")
    public String id;
}
