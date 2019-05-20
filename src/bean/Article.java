package bean;

import java.io.Serializable;
import java.sql.Date;

public class Article implements Serializable {
    private long id;
    private String title = null;
    private String content = null;
    private Date releaseDate = null;
    private Date editDate = null;
    private String author = null;

    public Article() {
    }

    public Article(long id, String title, String content, Date releaseDate, Date editDate, String author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.releaseDate = releaseDate;
        this.editDate = editDate;
        this.author = author;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Date getEditDate() {
        return editDate;
    }

    public void setEditDate(Date editDate) {
        this.editDate = editDate;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
