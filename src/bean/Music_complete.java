package bean;

import java.io.Serializable;

public class Music_complete implements Serializable {
    private String id;                     //歌曲id
    private String name;             //歌名
    private String link;             //歌曲下载链接
    private String artists;          //歌手
//    private String duration;         //时长
    private String album;            //专辑
    private String picUrl;           //封面链接
    private String comment_num;  //评论数
    private String lyric;            //歌词

    public Music_complete(String id, String name, String link, String artists, String album, String picUrl, String comment_num, String lyric) {
        this.id = id;
        this.name = name;
        this.link = link;
        this.artists = artists;
        this.album = album;
        this.picUrl = picUrl;
        this.comment_num = comment_num;
        this.lyric = lyric;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getArtists() {
        return artists;
    }

    public void setArtists(String artists) {
        this.artists = artists;
    }

    public String getAlbum() {
        return album;
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getComment_num() {
        return comment_num;
    }

    public void setComment_num(String comment_num) {
        this.comment_num = comment_num;
    }

    public String getLyric() {
        return lyric;
    }

    public void setLyric(String lyric) {
        this.lyric = lyric;
    }
}
