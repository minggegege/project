package com.heitian.ssm.model;

import java.util.Date;

public class News {
    private int NewsId;
    private String NewsName;
    private String NewsType;
    private String NewsInfo;
    private Date ReleaseDate;
    private String NewsMan;

    public int getNewsId() {
        return NewsId;
    }

    public void setNewsId(int newsId) {
        NewsId = newsId;
    }

    public String getNewsName() {
        return NewsName;
    }

    public void setNewsName(String newsName) {
        NewsName = newsName;
    }

    public String getNewsType() {
        return NewsType;
    }

    public void setNewsType(String newsType) {
        NewsType = newsType;
    }

    public String getNewsInfo() {
        return NewsInfo;
    }

    public void setNewsInfo(String newsInfo) {
        NewsInfo = newsInfo;
    }

    public Date getReleaseDate() {
        return ReleaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        ReleaseDate = releaseDate;
    }

    public String getNewsMan() {
        return NewsMan;
    }

    public void setNewsMan(String newsMan) {
        NewsMan = newsMan;
    }

}
