# Struts 2 Employee Management Application

A modern, high-performance **Employee Management System** built on **Java 8**, **Struts 2.5**, **Spring 5.3**, **Hibernate 5.6**, and **PostgreSQL**. The interface boasts a premium, dark-mode glassmorphic theme with interactive components and real-time visualization charts.

---

## 🚀 Key Features
1. **Interactive Dashboard**: Provides high-level metrics (Total Employees, Active Staff, Inactive Staff, and Average Salary) alongside a dynamic department distribution doughnut chart powered by **Chart.js**.
2. **Employee Directory**: Displays all registered employee records in a structured data table with custom name/email profile columns, status badges, and formatted salary localization.
3. **Advanced Filtering**: Live search by name/email and filters for department and status utilizing Java 8 Stream APIs.
4. **Comprehensive CRUD**: Add, edit, view details, and delete employee records with automated client-side confirmation and auto-fading notifications.
5. **Auto-seeding Database**: Auto-generates schemas and pre-populates PostgreSQL with 10 seed employees on first launch via a transactional initializer.

---

## 🛠️ Tech Stack
- **Runtime Environment**: Java 8 (JDK 1.8)
- **Web Controller**: Struts 2 (version `2.5.33`)
- **Dependency Injection & TX**: Spring Framework (version `5.3.29`)
- **ORM & Database Provider**: Hibernate Core (version `5.6.15.Final`) & PostgreSQL (version `42.6.0`)
- **Web Server**: Apache Tomcat 9 (or Jetty Maven Plugin)
- **Styling & Interactivity**: Vanilla CSS3 (Custom Dark Theme with Glassmorphism) & Vanilla JavaScript (Intl API, Chart.js)

---

## ⚙️ Database Configuration

Before starting the application, ensure you have a running PostgreSQL instance and create the database:

1. **Create Database**:
   Log into your PostgreSQL CLI (or use pgAdmin) and run:
   ```sql
   CREATE DATABASE employee_db;
   ```

2. **Configure Connection**:
   Database connection settings are located in [src/main/resources/db.properties](file:///c:/ramu/Project_Assignment/RapidX/FreddeMac_Project_RapidX/Research_Analysis/Java8Applications/struts2_application/src/main/resources/db.properties):
   ```properties
   db.driver=org.postgresql.Driver
   db.url=jdbc:postgresql://localhost:5432/employee_db
   db.username=postgres
   db.password=postgres
   db.dialect=org.hibernate.dialect.PostgreSQL9Dialect
   ```
   *Modify `db.username` and `db.password` if your database credentials differ.*

---

## 📦 How to Build the Project

Ensure your terminal environment has `JAVA_HOME` pointed to a JDK 8 installation. Compile and package the project into a `.war` file by running:

```bash
# Windows PowerShell
$env:JAVA_HOME="C:\ramu\softwares\jdk-8"
mvn clean package
```

The resulting package will be generated at:
`target/struts2-employee-app.war`

---

## 🏃 How to Run the Application

You can run the application using either **Apache Tomcat** or the **Jetty Maven Plugin**:

### Option A: Deploying to Apache Tomcat 9 (Recommended)
1. **Copy WAR file**:
   Copy the generated WAR archive to your Tomcat `webapps` folder:
   ```bash
   Copy-Item -Path "target\struts2-employee-app.war" -Destination "C:\ramu\tomcat-9.0.79\webapps\" -Force
   ```
2. **Start Tomcat**:
   Launch Tomcat from your console:
   ```bash
   $env:CATALINA_HOME="C:\ramu\tomcat-9.0.79"
   $env:JAVA_HOME="C:\ramu\softwares\jdk-8"
   C:\ramu\tomcat-9.0.79\bin\catalina.bat run
   ```
3. **Access URL**:
   Open your browser and navigate to:
   **[http://localhost:8080/struts2-employee-app/](http://localhost:8080/struts2-employee-app/)**

---

### Option B: Running via Jetty Maven Plugin
If you wish to run the app quickly using Maven without copying files:
1. **Run Jetty**:
   ```bash
   $env:JAVA_HOME="C:\ramu\softwares\jdk-8"
   mvn jetty:run
   ```
2. **Access URL**:
   Open your browser and navigate to:
   **[http://localhost:8080/](http://localhost:8080/)**
