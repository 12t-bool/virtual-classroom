package com.virtualclassroom.model;

public class Announcement {


private int id;
private int teacherId;
private int courseId;
private String title;
private String message;
private String createdAt;

public Announcement() {
}

public Announcement(
        int teacherId,
        int courseId,
        String title,
        String message) {

    this.teacherId = teacherId;
    this.courseId = courseId;
    this.title = title;
    this.message = message;
}

public Announcement(
        int id,
        int teacherId,
        int courseId,
        String title,
        String message,
        String createdAt) {

    this.id = id;
    this.teacherId = teacherId;
    this.courseId = courseId;
    this.title = title;
    this.message = message;
    this.createdAt = createdAt;
}

public int getId() {
    return id;
}

public void setId(int id) {
    this.id = id;
}

public int getTeacherId() {
    return teacherId;
}

public void setTeacherId(int teacherId) {
    this.teacherId = teacherId;
}

public int getCourseId() {
    return courseId;
}

public void setCourseId(int courseId) {
    this.courseId = courseId;
}

public String getTitle() {
    return title;
}

public void setTitle(String title) {
    this.title = title;
}

public String getMessage() {
    return message;
}

public void setMessage(String message) {
    this.message = message;
}

public String getCreatedAt() {
    return createdAt;
}

public void setCreatedAt(String createdAt) {
    this.createdAt = createdAt;
}


}
