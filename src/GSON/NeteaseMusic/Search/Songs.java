package GSON.NeteaseMusic.Search;

import GSON.NeteaseMusic.Album;
import GSON.NeteaseMusic.Artist;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class Songs {
    @SerializedName("name")
    public String name;
    @SerializedName("id")
    public String id;
    @SerializedName("ar")
    public List<Artist> artists;
    @SerializedName("al")
    public Album album;
}