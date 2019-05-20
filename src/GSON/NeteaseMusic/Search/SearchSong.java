package GSON.NeteaseMusic.Search;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class SearchSong {
    @SerializedName("songs")
    public List<Songs> songs;
    @SerializedName("songCount")
    public String songCount;
}
