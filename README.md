<h1 align="center">Đề tài bài tập lớn: Ứng dụng Web App Airline Booking Managements </h1>

---
## 👨‍👨‍👦‍👦 Tổ đội
  Nguyễn Minh Đức - cơ trưởng 

  Nguyễn Duy Anh 

  Trần Chí Công - bếp trưởng
  
  Đỗ Văn Huy 

---

## 🛫 Hệ thống quản lý đặt vé máy bay

Ứng dụng web Java quản lý đặt vé máy bay, bao gồm các chức năng:
- Quản lý chuyến bay (thêm, sửa, xóa).
- Quản lý đặt vé cho khách hàng.
- Xem thông tin chuyến bay và đặt vé.
- Báo cáo doanh thu.
- Quản lý thông tin cá nhân 
- Quản lý thông tin người dùng
---

## 📋 Yêu cầu hệ thống

1. **Java Development Kit (JDK):** phiên bản 8 trở lên.
2. **Netbean:** IDE 
3. **XAMPP:** để quản lý Apache, MySQL và Tomcat.
4. **GITHUB/GITLAB:** source control, version control, repo storage, platform hợp tác phát triển 
5. **Trình duyệt web.**

---

## ⚙️ Hướng dẫn cài đặt và chạy ứng dụng

### **1. Cài đặt XAMPP**
- [Tải xuống XAMPP](https://www.apachefriends.org/index.html) và cài đặt.
- Sau khi cài đặt, mở **XAMPP Control Panel**:
  - Start **Apache** và **MySQL**.

### **2. Cấu hình cổng XAMPP Apache và MySQL**
#### Apache:
1. Mở file cấu hình Apache:
   ```
   C:\xampp\apache\conf\httpd.conf
   ```
2. Thay đổi cổng mặc định:(Optional incase your device have a service already run at port 80)
   - Tìm dòng `Listen 80` và đổi thành:
     ```apache
     Listen 8080
     ```
   - Tìm dòng `ServerName localhost:80` và đổi thành:
     ```apache
     ServerName localhost:8080
     ```

#### MySQL:
1. Mở file cấu hình MySQL:
   ```
   C:\xampp\mysql\bin\my.ini
   ```
2. Tìm dòng `port=3306` và đổi thành:
   ```ini
   port=3307
   ```

3. Khởi động lại Apache và MySQL từ **XAMPP Control Panel**.

### **3. Cấu hình cơ sở dữ liệu**
1. Truy cập phpMyAdmin tại:
   ```
   http://localhost:8080/phpmyadmin
   ```
2. Tạo một cơ sở dữ liệu mới:
   ```sql
   CREATE DATABASE flight_booking;
   ```
3. Import file SQL (nếu có):
   - Vào tab **Import**.
   - Chọn file `database/qlbvmb.sql` từ dự án và nhấn **Go**.
   - Hoặc tạo database và sử dụng querries ở [đây](https://github.com/Thisorp/qlbvmb1/blob/master/qlbvmb.sql)

---

### **4. Cài đặt và cấu hình Tomcat**

#### **1. Cài đặt Tomcat**
1. **Tải xuống Tomcat:**
   - Truy cập [trang web chính thức của Apache Tomcat](https://tomcat.apache.org/).
   - Chọn phiên bản phù hợp (Tomcat 9 hoặc Tomcat 10, tùy thuộc vào yêu cầu của bạn).
   - Tải file `Core` dưới dạng `.zip` hoặc `.tar.gz`.

2. **Cài đặt Tomcat:**
   - Giải nén file vừa tải về vào một thư mục, ví dụ: 
     ```
     C:\apache-tomcat-9.0.74\
     ```
   - Đảm bảo cấu trúc thư mục có các thành phần chính như:
     ```
     /bin
     /conf
     /webapps
     /logs
     ```

3. **Cấu hình biến môi trường (nếu cần):**
   - Thêm thư mục `bin` của Tomcat vào biến môi trường `PATH` để có thể chạy Tomcat từ mọi nơi:
     - **Windows:**
       ```plaintext
       PATH=C:\apache-tomcat-9.0.74\bin;%PATH%
       ```
     - **Linux/MacOS:** Thêm dòng sau vào file `.bashrc` hoặc `.zshrc`:
       ```bash
       export PATH=/path/to/apache-tomcat-9.0.74/bin:$PATH
       ```

4. **Chạy Tomcat:**
   - **Windows:** 
     Chạy file:
     ```
     startup.bat
     ```
   - **Linux/MacOS:**
     ```
     ./startup.sh
     ```
   - Kiểm tra trên trình duyệt tại `http://localhost:8080`.

#### **2. Cấu hình Tomcat**

1. **Tạo tài khoản quản trị:**
   - Mở file `conf/tomcat-users.xml` trong thư mục cài đặt Tomcat.
   - Thêm đoạn sau vào trong thẻ `<tomcat-users>`:
     ```xml
     <role rolename="manager-gui"/>
     <user username="admin" password="admin" roles="manager-gui"/>
     ```
   - Lưu file và khởi động lại Tomcat.

2. **Cho phép truy cập từ mọi IP (tùy chọn):**
   - Mở file `webapps/manager/META-INF/context.xml`.
   - Tìm và chỉnh sửa đoạn:
     ```xml
     <Valve className="org.apache.catalina.valves.RemoteAddrValve"
            allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
     ```
     - Thay `allow="..."` thành:
       ```xml
       allow=".*"
       ```
   - Lưu file và khởi động lại Tomcat.

3. **Triển khai ứng dụng web:**
   - Copy file `.war` của ứng dụng và đặt vào thư mục:
     ```
     <TOMCAT_HOME>/webapps
     ```
   - Tomcat sẽ tự động triển khai ứng dụng, có thể truy cập tại:
     ```
     http://localhost:8080/<tên_ứng_dụng>
     ```

4. **Kiểm tra logs:**
   - Nếu gặp lỗi, kiểm tra các file log trong:
     ```
     <TOMCAT_HOME>/logs/
     ```

### **5. Build và chạy dự án**
1. Clone hoặc tải về dự án từ repository:
   ```bash
   git clone https://github.com/Thisorp/qlbvmb1/
   cd ../qlbvmb1/
   ```
2. Cấu hình file `build.xml`:
   - Mở file `build.xml` và đảm bảo các giá trị như:
     ```xml
     <property name="db.url" value="jdbc:mysql://localhost:3307/qlbvmb"/>
     <property name="db.username" value="root"/>
     <property name="db.password" value=""/>
     ```

3. Build dự án với Netbeans:

4. Triển khai và chạy:
   ```bash
   ant run
   ```

---

## 🚀 Sử dụng ứng dụng
1. Mở trình duyệt và truy cập:
   ```
   http://localhost:8080/<project_name>
   ```
2. Các chức năng chính:
   - Trang chủ: Hiển thị danh sách chuyến bay.
   - Trang quản trị: Quản lý các chuyến bay và đặt vé.

---

## 📁 Cấu trúc dự án
```plaintext
|-- src/
|   |-- main/
|   |   |-- java/
|   |   |   |-- com/                             # Package chính của dự án
|   |   |       |-- controllers/                # Các servlet điều khiển
|   |   |           |-- AdminServlet.java
|   |   |           |-- AirlineServlet.java
|   |   |           |-- AirportServlet.java
|   |   |           |-- CustomerServlet.java
|   |   |           |-- FlightServlet.java
|   |   |           |-- FlightStatisticsServlet.java
|   |   |           |-- HomeServlet.java
|   |   |           |-- LoginServlet.java
|   |   |           |-- LogoutServlet.java
|   |   |           |-- SeatManagerServlet.java
|   |   |           |-- bookSeat.java
|   |   |           |-- infoBooking.java
|   |   |       |-- models/                      # Các class mô hình
|   |   |           |-- Admin.java
|   |   |           |-- Customer.java
|   |   |           |-- Database.java           # Kết nối cơ sở dữ liệu
|   |   |           |-- Flight.java
|   |   |           |-- FlightStatistics.java
|   |   |           |-- booking.java
|   |   |           |-- seat.java
|   |-- webapp/
|       |-- WEB-INF/
|       |   |-- web.xml
|       |   |-- context.xml
|       |-- css/
|       |   |-- style.css
|       |-- image/
|       |   |-- CAAV_logo1.png
|       |   |-- background.jpg
|       |-- SeatManager.jsp
|       |-- admin.jsp
|       |-- flights.jsp
|       |-- home.jsp
|       |-- ...                                 # Các file JSP khác
|-- build.xml                                   # File cấu hình Apache Ant (nếu có)
|-- database/
|   |-- flight_booking.sql                      # File cấu trúc và dữ liệu mẫu
|-- libs/
|   |-- jstl-1.2.jar                            # Thư viện JSTL
|   |-- mysql-connector.jar                     # Thư viện MySQL
|-- README.md                                   # Hướng dẫn dự án
```

---

## 🛠 Công cụ sử dụng
- **Apache Ant:** Build và triển khai dự án.
- **JSP/Servlet:** Xây dựng giao diện và xử lý logic.
- **XAMPP:** Máy chủ web và cơ sở dữ liệu.

---

## 📞 Hỗ trợ
Nếu gặp vấn đề, vui lòng liên hệ:
- Email: sircumalot47@gmail.com
- GitHub Issues: [Mở issue tại đây](https://github.com/Thisorp/qlbvmb1/issues) 

---
<h4 align="right">Kewwi Ng</h4>
