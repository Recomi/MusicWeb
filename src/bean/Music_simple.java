package bean;

import java.io.Serializable;

public class Music_simple implements Serializable {
    private int id;                     //歌曲id
    private String name;             //歌名
    private String vocalist;          //歌手
//    private String duration;         //时长
    private String album;            //专辑

    public Music_simple(int id, String name, String vocalist, String duration, String album) {
        this.id = id;
        this.name = name;
        this.vocalist = vocalist;
//        this.duration = duration;
        this.album = album;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVocalist() {
        return vocalist;
    }

    public void setVocalist(String vocalist) {
        this.vocalist = vocalist;
    }

//    public String getDuration() {
//        return duration;
//    }
//
//    public void setDuration(String duration) {
//        this.duration = duration;
//    }

    public String getAlbum() {
        return album;
    }

    public void setAlbum(String album) {
        this.album = album;
    }
}
