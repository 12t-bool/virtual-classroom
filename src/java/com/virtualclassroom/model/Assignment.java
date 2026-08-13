package com.virtualclassroom.model;

import java.sql.Timestamp;

public class Assignment {


private int id;
private int courseId;
private String title;
private String description;
private Timestamp dueDate;

public Assignment() {
}

public Assignment(int courseId,
                  String title,
                  String description,
                  Timestamp dueDate) {

    this.courseId = courseId;
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
}

public Assignment(int id,
                  int courseId,
                  String title,
                  String description,
                  Timestamp dueDate) {

    this.id = id;
    this.courseId = courseId;
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
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

public Timestamp getDueDate() {
    return dueDate;
}

public void setDueDate(Timestamp dueDate) {
    this.dueDate = dueDate;
}


}
