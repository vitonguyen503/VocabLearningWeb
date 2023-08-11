package com.h503.vocablearningwebsite.model;

public class Sets {
    private int id;
    private String username;
    private String title;
    private String content;

    public Sets(int id, String title) {
        this.id = id;
        this.title = title;
    }

    public Sets(int id, String username, String title, String content) {
        this.id = id;
        this.username = username;
        this.title = title;
        this.content = content;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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
}
