# SecureChatApp (JSP + MongoDB)

A secure, real-time chat application built entirely in Java using JSP and Servlets with MongoDB as the database.

---

## 🚀 Features

- 🔐 **User Registration & Login**
  - Secure authentication using hashed passwords (BCrypt)
  - Session-based access control

- 💬 **Real-Time Chat**
  - WebSocket-powered messaging
  - Multi-user broadcasting

- 🖼️ **Screenshot Detection**
  - Notifies users when the chat tab loses focus

- ⏱️ **Auto-Delete Messages**
  - Messages are deleted automatically after 24 hours (MongoDB timestamp cleanup)

- 📱 **Responsive UI**
  - Chat interface works on both desktop and mobile browsers

---

## 📦 Tech Stack

- Java (JSP + Servlets)
- MongoDB (Java Driver)
- WebSockets (javax.websocket)
- Apache Tomcat (Servlet Container)
- Maven (Dependency Management)
- BCrypt (Password hashing)

---

## 🛠️ Setup Instructions

### ✅ Prerequisites

- Java JDK 8+
- [MongoDB](https://www.mongodb.com/try/download/community) (running locally)
- [Apache Tomcat](https://tomcat.apache.org/download-90.cgi)
- [Maven](https://maven.apache.org/download.cgi)
- VS Code (optional, with Java extensions)

---

### 🧪 Run Locally

1. **Clone or download this repository**

2. **Build the WAR file**
   ```bash
   mvn clean package
   ```
3. Deploy the generated WAR (`target/SecureChatApp.war`) to your Tomcat `webapps/` directory.
4. Start Tomcat and go to `http://localhost:8080/SecureChatApp`.

### MongoDB Config
Make sure MongoDB is running at `mongodb://localhost:27017`.
You can customize the connection string in `MongoDBUtil.java`.