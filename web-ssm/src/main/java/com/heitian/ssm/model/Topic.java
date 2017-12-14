package com.heitian.ssm.model;

public class Topic {
    private int TopicId;
    private String TopicName;
    private String TopicType;
    private String TopicInfo;
    private String PublishDate;
    private String TopicMan;

    public int getTopicId() {
        return TopicId;
    }

    public void setTopicId(int topicId) {
        TopicId = topicId;
    }

    public String getTopicName() {
        return TopicName;
    }

    public void setTopicName(String topicName) {
        TopicName = topicName;
    }

    public String getTopicType() {
        return TopicType;
    }

    public void setTopicType(String topicType) {
        TopicType = topicType;
    }

    public String getTopicInfo() {
        return TopicInfo;
    }

    public void setTopicInfo(String topicInfo) {
        TopicInfo = topicInfo;
    }

    public String getPublishDate() {
        return PublishDate;
    }

    public void setPublishDate(String publishDate) {
        PublishDate = publishDate;
    }

    public String getTopicMan() {
        return TopicMan;
    }

    public void setTopicMan(String topicMan) {
        TopicMan = topicMan;
    }
}
