# Education Platform - Setup Guide

## 🎓 Welcome to the Education Monitoring Platform

This is a comprehensive web-based education monitoring system built with **Java 21**, **Servlets**, **JSP**, and **MySQL**. The platform supports three types of users: Students, Instructors, and Administrators.

---

## ✅ Current Status

- ✅ **Java Version**: Java 21 LTS (upgraded from Java 8)
- ✅ **Build Tool**: Maven 3.9.9
- ✅ **Server**: Jetty 9.4 (embedded)
- ✅ **Port**: 8090
- ✅ **Context Path**: `/education-platform`
- ✅ **Database**: MySQL 8.0+

---

## 🚀 Quick Start

### 1. Setup MySQL Database

**Option A: Using MySQL Command Line**
```powershell
# Login to MySQL
mysql -u root -p

# Run the initialization script
source C:/Users/user/education/education-platform/init-database.sql

# Or import directly
mysql -u root -p < C:/Users/user/education/education-platform/init-database.sql
```

**Option B: Using MySQL Workbench**
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. File → Run SQL Script
4. Select `init-database.sql`
5. Click "Run"

### 2. Configure Database Connection

Edit `src/main/resources/database.properties`:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/education-platform?useSSL=false&serverTimezone=UTC
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

### 3. Start the Application

```powershell
cd C:\Users\user\education\education-platform
mvn clean install jetty:run
```

### 4. Access the Application

Open your browser and navigate to:
```
http://localhost:8090/education-platform
```

---

## 👥 Default Login Credentials

### Administrator
- **Email**: `admin@education.com`
- **Password**: `admin123`

### Instructors
| Name | Email | Password |
|------|-------|----------|
| Dr. John Smith | john.smith@education.com | instructor123 |
| Prof. Sarah Johnson | sarah.johnson@education.com | instructor123 |
| Dr. Michael Brown | michael.brown@education.com | instructor123 |
| Prof. Emily Davis | emily.davis@education.com | instructor123 |

### Students
| Name | Email | Password |
|------|-------|----------|
| Alice Williams | alice.williams@student.edu | student123 |
| Bob Martinez | bob.martinez@student.edu | student123 |
| Charlie Garcia | charlie.garcia@student.edu | student123 |
| Diana Rodriguez | diana.rodriguez@student.edu | student123 |
| Eva Lopez | eva.lopez@student.edu | student123 |
| Frank Wilson | frank.wilson@student.edu | student123 |
| Grace Lee | grace.lee@student.edu | student123 |
| Henry Taylor | henry.taylor@student.edu | student123 |

---

## 📚 Features by User Type

### 👨‍💼 Administrator Dashboard
- View and manage all students
- View and manage all instructors
- View and manage all courses
- System-wide statistics
- User management (add/edit/delete)

### 👨‍🏫 Instructor Dashboard
- View assigned courses
- Manage course assignments
- Grade student submissions
- View enrolled students
- Track student performance
- Create and edit assignments

### 👨‍🎓 Student Dashboard
- View enrolled courses
- View course grades
- View assignments and due dates
- Track academic progress
- Submit assignments
- View instructor feedback

---

## 🗂️ Sample Data Included

The initialization script creates:
- **2 Administrators**
- **4 Instructors**
- **8 Students**
- **6 Courses** across different departments:
  - CS101: Introduction to Programming
  - CS201: Data Structures
  - MATH101: Calculus I
  - MATH201: Linear Algebra
  - PHYS101: Physics I
  - CHEM101: General Chemistry
- **10 Assignments** across various courses
- **Multiple Enrollments** (students enrolled in 2-3 courses each)
- **Sample Grades** for some students

---

## 🛠️ Development Commands

### Build the Project
```powershell
mvn clean install
```

### Run in Development Mode
```powershell
mvn jetty:run
```

### Build WAR File for Deployment
```powershell
mvn clean package
# WAR file will be in target/education-platform.war
```

### Stop the Server
Press `Ctrl+C` in the terminal running Jetty

---

## 🔧 Configuration Files

### Key Files to Modify

1. **Database Configuration**
   - `src/main/resources/database.properties`

2. **Server Configuration**
   - `pom.xml` (Jetty plugin configuration, port 8090)

3. **Web Application**
   - `src/main/webapp/WEB-INF/web.xml`

---

## 📊 Database Schema

### Main Tables

1. **admins** - Administrator accounts
2. **instructors** - Instructor profiles
3. **students** - Student profiles
4. **courses** - Course information
5. **enrollments** - Student-Course relationships
6. **assignments** - Course assignments
7. **grades** - Student grades and feedback

### Relationships
- Courses → Instructors (Many-to-One)
- Enrollments → Students & Courses (Many-to-Many junction)
- Assignments → Courses (Many-to-One)
- Grades → Students & Assignments (Many-to-One)

---

## 🌐 API Endpoints

### Authentication
- `GET /login` - Login page
- `POST /login` - Process login
- `GET /logout` - Logout

### Student Features
- `GET /student/dashboard` - Student dashboard
- `GET /student/courses` - View enrolled courses
- `GET /student/assignments` - View assignments
- `GET /student/grades` - View grades

### Instructor Features
- `GET /instructor/dashboard` - Instructor dashboard
- `GET /instructor/courses` - View teaching courses
- `POST /instructor/grade` - Submit grades

### Admin Features
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/students` - Manage students
- `POST /admin/students` - Add/Edit students

---

## 🐛 Troubleshooting

### Port Already in Use
```powershell
# Find process using port 8090
netstat -ano | findstr :8090

# Kill the process
Stop-Process -Id <PID> -Force
```

### Database Connection Issues
1. Verify MySQL is running
2. Check database credentials in `database.properties`
3. Ensure `education-platform` database exists
4. Check firewall settings

### Build Errors
```powershell
# Clean Maven cache
mvn clean

# Force update dependencies
mvn clean install -U
```

---

## 📝 Development Notes

### Technology Stack
- **Backend**: Java 21, Servlets 4.0, JSP 2.3
- **Frontend**: HTML5, CSS3, JSTL
- **Database**: MySQL 8.0+
- **Build**: Maven 3.9+
- **Server**: Jetty 9.4

### Project Structure
```
education-platform/
├── src/
│   ├── main/
│   │   ├── java/com/education/
│   │   │   ├── dao/          # Data Access Objects
│   │   │   ├── model/        # Entity classes
│   │   │   ├── servlet/      # Servlets
│   │   │   └── util/         # Utilities
│   │   ├── resources/
│   │   │   ├── database.properties
│   │   │   └── education-platform.sql
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   └── views/    # JSP pages
│   └── test/
├── pom.xml
├── init-database.sql
└── SETUP-GUIDE.md
```

---

## 🎯 Next Steps

1. ✅ Start the MySQL server
2. ✅ Run the initialization script
3. ✅ Update database credentials
4. ✅ Build and run the application
5. ✅ Login with sample credentials
6. ✅ Explore the features!

---

## 📞 Support

For issues or questions:
- Check the logs in the terminal
- Verify database connectivity
- Ensure port 8090 is available
- Review the troubleshooting section

---

**Happy Learning! 🎓**
