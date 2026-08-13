# 🎓 Virtual Classroom

A web-based **Virtual Classroom Management System** developed using **Java, JSP, Servlets, MySQL, HTML, CSS, JavaScript, and Apache Tomcat**.

The application provides separate dashboards and features for **students and teachers**, making it easier to manage courses, assignments, study materials, announcements, and student progress.

## ✨ Features

### 👨‍🎓 Student

* Student registration and login
* Student dashboard
* Browse available courses
* Enroll in courses
* View enrolled courses
* Access study materials
* View and submit assignments
* Track assignment progress
* View announcements
* Manage profile
* Change password
* Forgot/reset password functionality

### 👨‍🏫 Teacher

* Teacher login
* Teacher dashboard
* Create and manage courses
* Edit and delete courses
* Upload study materials
* Create assignments
* Review student submissions
* Post announcements
* Manage profile

## 🛠️ Technologies Used

* **Java**
* **JSP (JavaServer Pages)**
* **Java Servlets**
* **MySQL**
* **JDBC**
* **HTML5**
* **CSS3**
* **JavaScript**
* **Apache Tomcat**
* **NetBeans IDE**

## 🗂️ Project Structure

```text
VirtualClassroom/
│
├── src/
│   └── com.virtualclassroom/
│       ├── controller/
│       ├── dao/
│       ├── model/
│       └── util/
│
├── web/
│   ├── student/
│   ├── teacher/
│   ├── login.jsp
│   ├── register.jsp
│   ├── profile.jsp
│   └── index.html
│
├── nbproject/
├── build.xml
└── README.md
```

## 🔐 User Roles

The system supports three roles:

* **Student**
* **Teacher**
* **Admin**

Users are redirected to the appropriate dashboard according to their role after login.

## 🗄️ Database

The application uses **MySQL** for storing:

* User accounts
* Courses
* Enrollments
* Assignments
* Submissions
* Study materials
* Announcements

Database communication is handled using **JDBC and DAO classes**.

## 🚀 How to Run

1. Clone the repository.
2. Open the project in **NetBeans IDE**.
3. Configure the MySQL database.
4. Update the database connection settings in `DBConnection`.
5. Add the required MySQL JDBC connector.
6. Configure **Apache Tomcat**.
7. Build and run the project.
8. Open the application in your browser.

## 🎯 Purpose

This project was developed to practice and demonstrate **Java web development, MVC architecture, Servlets, JSP, JDBC, database management, authentication, session handling, and CRUD operations**.

## 👩‍💻 Developer

**Tasneem Khanum**

GitHub: [12t-bool](https://github.com/12t-bool)
