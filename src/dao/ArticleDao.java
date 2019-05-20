package dao;

import bean.Article;
import util.SQL_util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

public class ArticleDao {
    public static final String ID = "threadId";
    public static final String AUTHOR = "user_name";
    public static final String TITLE = "title";
    public static final String CONTENT = "content";
    public static final String RELEASE_DATETIME = "releaseDateTime";
    public static final String EDIT_DATETIME = "editDateTime";
    public static final String[] ALL = new String[]{
        ID,
        AUTHOR,
        TITLE,
        CONTENT,
        RELEASE_DATETIME,
        EDIT_DATETIME
    };
    public static final int STRING = 0;
    public static final int DATE = 1;
    public static final int INT = 2;

    private SQL_util sqlUtil;

    public SQL_util getSqlUtil() {
        return sqlUtil;
    }

    public ArticleDao() {
        sqlUtil = new SQL_util();
    }

    public static ArrayList<Article> getArticles() throws SQLException {
        ArrayList<Article> articles = new ArrayList<>();
        ArticleDao articleDao = new ArticleDao();
        //
        ArrayList ids = articleDao.get(ID,INT);
        ArrayList authors = articleDao.get(AUTHOR,STRING);
        ArrayList titles = articleDao.get(TITLE,STRING);
        ArrayList contents = articleDao.get(CONTENT,STRING);
        ArrayList releases = articleDao.get(RELEASE_DATETIME,DATE);
        ArrayList edits = articleDao.get(EDIT_DATETIME,DATE);
        //
        for(int i = 0; i < articleDao.get(ID,INT).size() ; i++) {
            articles.add(new Article(
                    (int) ids.get(i),
                    (String) titles.get(i),
                    (String) contents.get(i),
                    (Date) releases.get(i),
                    (Date) edits.get(i),
                    (String) authors.get(i)
            ));
        }
        System.out.println(articles);
        return articles;
    }

    public ArrayList get(String columnLabel,int type) throws SQLException {
        ArrayList<Object> objects = new ArrayList<Object>();
        ResultSet resultSet = sqlUtil.executeQuery("select " + columnLabel + " from article_table");
        while (resultSet.next()) {
            switch (type) {
                case STRING:
                    objects.add(resultSet.getString(columnLabel));
                    break;
                case DATE:
                    objects.add(resultSet.getDate(columnLabel));
                    break;
                case INT:
                    objects.add(resultSet.getInt(columnLabel));
                    break;
            }
        }
        resultSet.close();
        return objects;
    }

    public Article getAriicleById(int id) throws SQLException {
        Article article = null;
        PreparedStatement statement = sqlUtil.getPreparedStatement(
                "select * from article_table where threadId=?;"
        );
        statement.setInt(1,id);
        ResultSet result = statement.executeQuery();
        if (result.next()) {
            article = new Article(
                    id,
                    result.getString(TITLE),
                    result.getString(CONTENT),
                    result.getDate(RELEASE_DATETIME),
                    result.getDate(EDIT_DATETIME),
                    result.getString(AUTHOR)
            );
        }
        statement.close();
        result.close();
        return article;
    }

    public int count(String columnLabel) throws SQLException {
        int count = 0;
        ResultSet result = sqlUtil.executeQuery("select count(" + columnLabel + ") 'count' from article_table;");
        if (result.next()) {
            count = result.getInt("count");
        }
        return count;
    }

    public void close() {
        sqlUtil.close();
    }
}
