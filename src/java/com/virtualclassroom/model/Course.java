package com.virtualclassroom.model;

public class Course {

    private int id;
    private String courseName;
    private String description;
    private int teacherId;

    // Empty constructor
    public Course() {
    }

    // Constructor for creating a new course
    public Course(String courseName,
                  String description,
                  int teacherId) {

        this.courseName = courseName;
        this.description = description;
        this.teacherId = teacherId;
    }

    // Constructor with ID
    public Course(int id,
                  String courseName,
                  String description,
                  int teacherId) {

        this.id = id;
        this.courseName = courseName;
        this.description = description;
        this.teacherId = teacherId;
    }

    // Get ID
    public int getId() {
        return id;
    }

    // Set ID
    public void setId(int id) {
        this.id = id;
    }

    // Get course name
    public String getCourseName() {
        return courseName;
    }

    // Set course name
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    // Get description
    public String getDescription() {
        return description;
    }

    // Set description
    public void setDescription(String description) {
        this.description = description;
    }

    // Get teacher ID
    public int getTeacherId() {
        return teacherId;
    }

    // Set teacher ID
    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }
}