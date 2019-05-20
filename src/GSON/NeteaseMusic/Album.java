package GSON.NeteaseMusic;

import com.google.gson.annotations.SerializedName;

//专辑信息，包含封面图片在内
public class Album {
    @SerializedName("name")
    public String name;
    @SerializedName("id")
    public String id;
    @SerializedName("picUrl")
    public String picUrl;
}