package com.virtualclassroom.model;

public class Progress {

    private int courseId;
    private String courseName;
    private int totalAssignments;
    private int submittedAssignments;
    private double percentage;

    public Progress() {
    }

    public Progress(int courseId,
                    String courseName,
                    int totalAssignments,
                    int submittedAssignments) {

        this.courseId = courseId;
        this.courseName = courseName;
        this.totalAssignments = totalAssignments;
        this.submittedAssignments = submittedAssignments;

        if (totalAssignments > 0) {
            this.percentage =
                    ((double) submittedAssignments
                    / totalAssignments) * 100;
        } else {
            this.percentage = 0;
        }
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getTotalAssignments() {
        return totalAssignments;
    }

    public void setTotalAssignments(int totalAssignments) {
        this.totalAssignments = totalAssignments;
    }

    public int getSubmittedAssignments() {
        return submittedAssignments;
    }

    public void setSubmittedAssignments(int submittedAssignments) {
        this.submittedAssignments = submittedAssignments;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }
}