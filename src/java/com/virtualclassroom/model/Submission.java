package com.virtualclassroom.model;

import java.sql.Timestamp;

public class Submission {


private int id;
private int assignmentId;
private int studentId;
private String submissionText;
private Timestamp submittedAt;

private String studentName;
private String assignmentTitle;
private String courseName;

private Integer marks;
private String feedback;

public Submission() {
}

public Submission(int assignmentId,
                  int studentId,
                  String submissionText) {

    this.assignmentId = assignmentId;
    this.studentId = studentId;
    this.submissionText = submissionText;
}

public Submission(int id,
                  int assignmentId,
                  int studentId,
                  String submissionText,
                  Timestamp submittedAt) {

    this.id = id;
    this.assignmentId = assignmentId;
    this.studentId = studentId;
    this.submissionText = submissionText;
    this.submittedAt = submittedAt;
}

public int getId() {
    return id;
}

public void setId(int id) {
    this.id = id;
}

public int getAssignmentId() {
    return assignmentId;
}

public void setAssignmentId(int assignmentId) {
    this.assignmentId = assignmentId;
}

public int getStudentId() {
    return studentId;
}

public void setStudentId(int studentId) {
    this.studentId = studentId;
}

public String getSubmissionText() {
    return submissionText;
}

public void setSubmissionText(String submissionText) {
    this.submissionText = submissionText;
}

public Timestamp getSubmittedAt() {
    return submittedAt;
}

public void setSubmittedAt(Timestamp submittedAt) {
    this.submittedAt = submittedAt;
}

public String getStudentName() {
    return studentName;
}

public void setStudentName(String studentName) {
    this.studentName = studentName;
}

public String getAssignmentTitle() {
    return assignmentTitle;
}

public void setAssignmentTitle(String assignmentTitle) {
    this.assignmentTitle = assignmentTitle;
}

public String getCourseName() {
    return courseName;
}

public void setCourseName(String courseName) {
    this.courseName = courseName;
}

public Integer getMarks() {
    return marks;
}

public void setMarks(Integer marks) {
    this.marks = marks;
}

public String getFeedback() {
    return feedback;
}

public void setFeedback(String feedback) {
    this.feedback = feedback;
}


}
