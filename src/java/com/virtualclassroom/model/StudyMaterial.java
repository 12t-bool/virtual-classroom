package com.virtualclassroom.model;

public class StudyMaterial {

private int id;
private int courseId;
private String title;
private String description;
private String fileUrl;

public StudyMaterial() {
}

public StudyMaterial(int courseId,
                     String title,
                     String description,
                     String fileUrl) {

    this.courseId = courseId;
    this.title = title;
    this.description = description;
    this.fileUrl = fileUrl;
}

public StudyMaterial(int id,
                     int courseId,
                     String title,
                     String description,
                     String fileUrl) {

    this.id = id;
    this.courseId = courseId;
    this.title = title;
    this.description = description;
    this.fileUrl = fileUrl;
}

public int getId() {
    return id;
}

public void setId(int id) {
    this.id = id;
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

public String getDescription() {
    return description;
}

public void setDescription(String description) {
    this.description = description;
}

public String getFileUrl() {
    return fileUrl;
}

public void setFileUrl(String fileUrl) {
    this.fileUrl = fileUrl;
}

}
