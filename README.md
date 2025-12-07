# 📚 Education Monitoring Platform

A comprehensive web-based education management system built with Java, JSP, Servlets, and MySQL. This platform enables students, instructors, and administrators to manage courses, assignments, grades, and enrollments efficiently.

## 🎯 Features

### **Student Features**
- ✅ Login and authentication
- ✅ View enrolled courses
- ✅ View assignments with due dates
- ✅ View grades and feedback
- ✅ Track academic progress

### **Instructor Features**
- ✅ Login and authentication
- ✅ View assigned courses
- ✅ Create and manage assignments
- ✅ Grade student submissions
- ✅ Provide feedback to students
- ✅ View enrolled students

### **Admin Features**
- ✅ Login and authentication
- ✅ Manage students (CRUD operations)
- ✅ Manage instructors (CRUD operations)
- ✅ Manage courses (CRUD operations)
- ✅ View system statistics
- ✅ Monitor platform activity

## 🏗️ Technology Stack

- **Backend**: Java 8+, Servlets 4.0
- **Frontend**: JSP, HTML5, CSS3
- **Database**: MySQL 8.0
- **Build Tool**: Maven 3.8+
- **Server**: Apache Tomcat 9.0+
- **Libraries**: JSTL 1.2, MySQL Connector 8.0.33

## 📁 Project Structure

```
education-platform/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── education/
│       │           ├── dao/              # Data Access Objects
│       │           │   ├── AdminDAO.java
│       │           │   ├── AssignmentDAO.java
│       │           │   ├── CourseDAO.java
│       │           │   ├── EnrollmentDAO.java
│       │           │   ├── GradeDAO.java
│       │           │   ├── InstructorDAO.java
│       │           │   └── StudentDAO.java
│       │           ├── model/            # Entity Classes
│       │           │   ├── Admin.java
│       │           │   ├── Assignment.java
│       │           │   ├── Course.java
│       │           │   ├── Enrollment.java
│       │           │   ├── Grade.java
│       │           │   ├── Instructor.java
│       │           │   └── Student.java
│       │           ├── servlet/          # Servlet Controllers
│       │           │   ├── AdminServlet.java
│       │           │   ├── InstructorServlet.java
│       │           │   ├── LoginServlet.java
│       │           │   ├── LogoutServlet.java
│       │           │   └── StudentServlet.java
│       │           └── util/             # Utility Classes
│       │               └── DBConnection.java
│       ├── resources/
│       │   ├── database.properties       # Database configuration
│       │   └── education-platform.sql    # Database schema
│       └── webapp/
│           └── WEB-INF/
│               ├── views/                # JSP Pages
│               │   ├── admin/
│               │   │   ├── dashboard.jsp
│               │   │   └── students.jsp
│               │   ├── instructor/
│               │   │   └── dashboard.jsp
│               │   ├── student/
│               │   │   ├── assignments.jsp
│               │   │   ├── courses.jsp
│               │   │   ├── dashboard.jsp
│               │   │   └── grades.jsp
│               │   ├── error.jsp
│               │   └── login.jsp
│               └── web.xml               # Web application config
└── pom.xml                               # Maven configuration
```

## 🚀 Installation & Setup

### Prerequisites

1. **JDK 8 or higher** - [Download here](https://www.oracle.com/java/technologies/downloads/)
2. **Apache Tomcat 9.0+** - [Download here](https://tomcat.apache.org/download-90.cgi)
3. **MySQL 8.0+** - [Download here](https://dev.mysql.com/downloads/mysql/)
4. **Maven 3.8+** - [Download here](https://maven.apache.org/download.cgi)

### Step 1: Database Setup

1. Open MySQL Command Line or MySQL Workbench
2. Create the database:
   ```sql
   CREATE DATABASE `education-platform`;
   USE `education-platform`;
   ```
3. Import the SQL file:
   ```sql
   SOURCE path/to/education-platform/src/main/resources/education-platform.sql;
   ```
   Or import via phpMyAdmin/MySQL Workbench

### Step 2: Configure Database Connection

Edit `src/main/resources/database.properties`:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/education-platform?useSSL=false&serverTimezone=UTC
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

### Step 3: Build the Project

Open terminal in project directory and run:

```bash
mvn clean package
```

This will create a WAR file in `target/education-platform.war`

### Step 4: Deploy to Tomcat

**Option 1: Manual Deployment**
1. Copy `target/education-platform.war` to Tomcat's `webapps` folder
2. Start Tomcat server
3. Access: `http://localhost:8080/education-platform`

**Option 2: IDE Deployment (Eclipse/IntelliJ)**
1. Add Tomcat server to your IDE
2. Right-click project → Run on Server
3. Select Tomcat server and finish

## 👥 Demo Credentials

### Student Login
- **Email**: alice.w@student.edu
- **Password**: student123

### Instructor Login
- **Email**: john.smith@edu.com
- **Password**: instructor123

### Admin Login
- **Email**: admin@edu.com
- **Password**: admin123

## 📊 Database Schema

### Tables
- **admin** - Administrator accounts
- **student** - Student accounts and profiles
- **instructor** - Instructor accounts and profiles
- **course** - Course information
- **assignment** - Assignment details
- **enrollment** - Student-Course relationships
- **grade** - Assignment grades and feedback

### Key Relationships
- Courses are taught by Instructors (1:N)
- Students enroll in Courses (N:M)
- Assignments belong to Courses (N:1)
- Grades link Students and Assignments (N:M)

## 🔄 Application Flow

### User Authentication Flow
```
1. User opens application → Login page
2. User selects role (Student/Instructor/Admin)
3. User enters credentials
4. System validates credentials
5. Success → Redirect to role-specific dashboard
6. Failure → Display error message
```

### Student Workflow
```
Login → Dashboard → View Courses → View Assignments → View Grades → Logout
```

### Instructor Workflow
```
Login → Dashboard → Manage Courses → Create Assignments → Grade Submissions → Logout
```

### Admin Workflow
```
Login → Dashboard → Manage Students/Instructors/Courses → View Reports → Logout
```

## 🛠️ Development

### Adding New Features

1. **Create Model Class** (if needed)
   - Add to `src/main/java/com/education/model/`

2. **Create DAO Class**
   - Add to `src/main/java/com/education/dao/`
   - Implement CRUD operations

3. **Create/Update Servlet**
   - Add to `src/main/java/com/education/servlet/`
   - Handle HTTP requests

4. **Create JSP View**
   - Add to `src/main/webapp/WEB-INF/views/`
   - Design user interface

### Building for Production

```bash
# Clean and build
mvn clean package

# Skip tests
mvn clean package -DskipTests

# Run with specific profile
mvn clean package -P production
```

## 🐛 Troubleshooting

### Database Connection Issues
- Verify MySQL is running
- Check `database.properties` credentials
- Ensure database exists and tables are created

### Tomcat Deployment Issues
- Check Tomcat logs: `catalina.out`
- Verify Tomcat is running on port 8080
- Clear Tomcat work directory

### Build Issues
- Clean Maven cache: `mvn dependency:purge-local-repository`
- Update project: `mvn clean install -U`

## 📝 API Endpoints

### Login
- `GET /login` - Display login page
- `POST /login` - Process login

### Student
- `GET /student/dashboard` - Student dashboard
- `GET /student/courses` - View courses
- `GET /student/assignments` - View assignments
- `GET /student/grades` - View grades

### Instructor
- `GET /instructor/dashboard` - Instructor dashboard
- `GET /instructor/courses` - View courses
- `GET /instructor/assignments` - Manage assignments
- `POST /instructor/add-assignment` - Create assignment
- `POST /instructor/grade-assignment` - Grade submission

### Admin
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/students` - Manage students
- `GET /admin/instructors` - Manage instructors
- `GET /admin/courses` - Manage courses
- `POST /admin/add-student` - Add student
- `POST /admin/delete-student` - Delete student

## 🔒 Security Notes

⚠️ **Important**: This is a demo application. For production use:
- Implement password hashing (BCrypt)
- Add CSRF protection
- Use HTTPS
- Implement session management
- Add input validation and sanitization
- Use prepared statements (already implemented)

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Author

Created as a comprehensive education management system demonstration.

## 🤝 Contributing

Feel free to fork, modify, and use this project for learning purposes.

## 📞 Support

For issues and questions:
- Check the troubleshooting section
- Review the database schema
- Verify configuration files

---

**Happy Learning! 📚🎓**
