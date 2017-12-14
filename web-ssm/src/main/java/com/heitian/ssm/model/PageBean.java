package com.heitian.ssm.model;

import java.util.List;

public class PageBean {
    //总记录数
    private int totalrecord;
    //总页数
    private int totalpage;
    //每页记录数
    private int pagesize=3;
    //当前页码
    private int pagecode;
    //当前页的数据
    private List beanList;

    private String url;
    private int startNum;
    private int endNum;

    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }

    public int getTotalrecord() {
        return totalrecord;
    }
    public void setTotalrecord(int totalrecord) {
        this.totalrecord = totalrecord;
    }
    public int getTotalpage() {
        totalpage = (totalrecord % pagesize == 0) ? (totalrecord / pagesize) : ((totalrecord / pagesize) + 1);
        return totalpage;
    }
    public void setTotalpage(int totalpage) {
        this.totalpage = totalpage;
    }
    public int getPagesize() {
        return pagesize;
    }
    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }
    public int getPagecode() {
        return pagecode;
    }
    public void setPagecode(int pagecode) {
        this.pagecode = pagecode;
    }
    public List getBeanList() {
        return beanList;
    }
    public void setBeanList(List beanList) {
        this.beanList = beanList;
    }
    public int getStartNum() {
        //开始行 = （当前页码数-1）*每页记录数
        startNum = (pagecode-1)*pagesize;
        return startNum;
    }
    public int getEndNum() {
        //结束行 = （当前页码数-1）*每页记录数+每页记录数
        endNum = (pagecode-1)*pagesize+pagesize;
        return endNum;
    }
}