<%-- 
    Document   : home
    Created on : Nov 26, 2024, 10:55:59 PM
    Author     : Huy pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>Giới thiệu - Website Bán Vé Máy Bay</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #FFA500;
            padding-top: 80px;
           
        }

        .navbar a.active {
            color: yellow;
            font-weight: bold;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;

            width: 100%;
            padding: 20px 100px;
            background: palevioletred;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 100;
        }

        .logo {
            font-size: 32px;
            color: white;
            
            text-decoration: none;
            font-weight: 700;
        }

        .navbar {
            display: flex;
            align-items: center;
        }

        .navbar a {
            position: relative;
            right: 120px;
            font-size: 18px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            margin-left: 40px;
        }

        .navbar a::before {
            content: ' ';
            position: absolute;
            top: 100%;
            left: 0;
            width: 0;
            height: 2px;
            background: white;
            transition: .3s;
        }

        .navbar a:hover::before {
            width: 100%;
        }

        .navbar a.active {
            color: yellow;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            min-height: 100vh;
            background: url("image\background.jpg") no-repeat;
            background-size: cover;
            background-position: center;

        }

        h2,
        h3 {
            color:palevioletred;
        }

        ul {
            padding-left: 20px;
        }

        footer {
            text-align: center;
            padding: 10px 0;
            background: palevioletred;
            color: #fff;
            margin-top: 20px;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        a {
            color:red;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        .user-options {
            display: none; /* Ẩn mặc định */
            flex-direction: column;
            background: #fff;
            position: absolute;
            top: 50px;
            right: 200px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 10px;
            border-radius: 5px;
        }

        .user-options button {
            padding: 8px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .user-options button:hover {
            background-color: #0056b3;
        }

        @media (max-width: 768px) {
            .header {
                padding: 10px 20px;
            }

                        /* Thanh ngang */
            .navbar {
                background-color: #333;
                overflow: hidden;
                padding: 10px;
                display: flex;
                justify-content: flex-start; /* Canh lề trái cho các mục trong thanh */
                align-items: center;
            }

            /* Các mục trong thanh ngang */
            .navbar-item {
                padding: 10px 20px;
                color: white;
                text-decoration: none;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.2s;
            }

            /* Khi hover vào nút */
            .navbar-item:hover {
                background-color: #e74c3c;
                transform: scale(1.1);
            }

            /* Khi nút bị active */
            .navbar-item:active {
                background-color: #c0392b;
                transform: scale(1);
            }

        }
    </style>
</head>

<body>
    <header class="header">
        <a  onclick="navigate('home')" class="logo"> <img src="image\CAAV_logo1.png" style="width: 50% ; height: 50%;" ></a>
        <nav class="navbar">
            <a  class="active" onclick="navigate('home')">Home</a>
            <a  onclick="navigate('booking')">Đặt vé</a>
            <a  onclick="navigate('airline-manager')">Airline manager</a>
            <a  onclick="navigate('airport-manager')">Airport manager</a>
            <a  onclick="navigate('account-manager')">Account manager</a>
<!--            <a onclick="navigate('customer-Information')">Customer Information</a>-->
            <a href="javascript:void(0)" id="login-link" onclick="toggleUserOptions()">Login</a>
             <div id="user-options" class="user-options">
                    <button onclick="navigate('customer-Information')">Customer Information</button>
                    <button  onclick="logout()">Đăng xuất</button>
            </div>
        </nav>
    </header>
    <div class="container" id="content">
        <h2>Chào mừng bạn đến với <strong>[Tên Website]</strong></h2>
        <p>
            Chúng tôi tự hào là đơn vị cung cấp dịch vụ đặt vé máy bay trực tuyến nhanh chóng, tiện lợi và đáng tin cậy,
            giúp bạn dễ dàng lựa chọn và đặt vé với giá cả cạnh tranh nhất.
        </p>
        <!-- Nội dung mặc định của Home -->
    </div>
    <footer>
        <p>&copy; 2024 Cục hàng không Việt Nam. All Rights Reserved.</p>
        <p>
            <a href="#">Chính sách bảo mật</a> |
            <a href="#">Điều khoản sử dụng</a>
        </p>
    </footer>


    <script>
        // Kiểm tra xem người dùng đã đăng nhập chưa khi tải trang
        window.addEventListener("DOMContentLoaded", function() {
            checkLoginStatus();
        });
        <%
            String name = (String) session.getAttribute("name");
            String role = (String) session.getAttribute("role");
        %>
        // Kiểm tra trạng thái đăng nhập và thay đổi liên kết login
        function checkLoginStatus() {
            const username = "<%= (name != null ? name : "")%>";
            const loginLink = document.getElementById('login-link');
            const userOptions = document.getElementById('user-options');
           
             if (username && username.trim() !== "") {
        loginLink.textContent = username; // Hiển thị tên người dùng
        loginLink.href = "javascript:void(0)"; // Ngăn chuyển hướng
        userOptions.style.display = 'none'; // Ẩn menu mặc định
    } else {
        loginLink.textContent = 'Login'; // Hiển thị "Login" nếu chưa đăng nhập
        loginLink.href = "LoginServlet"; // Chuyển hướng đến trang đăng nhập
        userOptions.style.display = 'none'; // Ẩn menu
    }
        }
        // Vai trò người dùng hiện tại 
        const userRole = "<%=role %>";

        // Cập nhật hiệu ứng "active" khi nhấn vào menu
        function updateActiveLink(section) {
            const links = document.querySelectorAll('.navbar a');
            links.forEach(link => {
                // Xóa lớp "active" khỏi tất cả các liên kết
                 link.classList.remove('active');

                // Kiểm tra xem liên kết có thuộc phần được nhấn không
                const linkSection = link.getAttribute('onclick');
                if (linkSection && linkSection.includes(`navigate('${section}')`)) {
                    link.classList.add('active'); // Thêm lớp "active" vào liên kết phù hợp
                    console.log('Active link updated:', link); // Log kiểm tra
                }
                    
            }); 
            
        }
        
        // Điều hướng và kiểm tra quyền truy cập
        function navigate(section) {
            const permissions = {
                customer: ["home", "booking", "customer-Information"],
                admin: ["home", "account-manager", "customer-Information"],
                airline: ["home", "airline-manager", "customer-Information"],
                airport: ["home", "airport-manager", "customer-Information"]
            };

            if (permissions[userRole].includes(section)) {
                showContent(section);
                updateActiveLink(section); // Gọi hàm cập nhật "active"
            } else {
                 alert("Bạn không có quyền truy cập vào mục này!");
            }
        }

        // Hiển thị nội dung động
        function showContent(section) {
            const content = document.getElementById('content');
            switch (section) {
                case 'home':
                    content.innerHTML = `
                    <h2>Chào mừng bạn đến với <strong>Cục hàng không Việt Nam</strong></h2>
                    <p>
                        Chúng tôi tự hào là đơn vị cung cấp dịch vụ đặt vé máy bay trực tuyến nhanh chóng, tiện lợi và đáng tin cậy,
                        giúp bạn dễ dàng lựa chọn và đặt vé với giá cả cạnh tranh nhất.
                    </p>

                    <h3>Tầm nhìn và sứ mệnh</h3>
                    <ul>
                        <li><strong>Tầm nhìn:</strong> Trở thành nền tảng đặt vé máy bay hàng đầu, mang đến trải nghiệm tốt nhất cho
                            khách hàng ở mọi nơi.</li>
                        <li><strong>Sứ mệnh:</strong> Giúp bạn hiện thực hóa giấc mơ bay với dịch vụ tối ưu, giá vé hợp lý và sự hỗ
                            trợ tận tâm.</li>
                    </ul>

                    <h3>Chúng tôi mang lại điều gì?</h3>
                    <ul>
                        <li><strong>Hệ thống tìm kiếm thông minh:</strong> So sánh giá vé từ nhiều hãng hàng không chỉ trong vài
                            giây.</li>
                        <li><strong>Đa dạng chuyến bay:</strong> Đáp ứng nhu cầu bay nội địa và quốc tế với lịch trình linh hoạt.
                        </li>
                        <li><strong>Thanh toán an toàn:</strong> Hỗ trợ nhiều phương thức thanh toán hiện đại, bảo mật cao.</li>
                        <li><strong>Hỗ trợ 24/7:</strong> Đội ngũ chăm sóc khách hàng luôn sẵn sàng giải đáp mọi thắc mắc.</li>
                    </ul>

                    <h3>Liên hệ với chúng tôi</h3>
                    <p>
                        Nếu bạn có bất kỳ câu hỏi hoặc cần hỗ trợ, hãy liên hệ với đội ngũ <strong>Cục hàng không Việt Nam</strong> qua:
                    </p>
                    <ul>
                        <li><strong>Hotline:</strong> 024.38722394</li>
                        
                        <li><strong>Địa chỉ:</strong> 119 Nguyễn Sơn – Long Biên - Hà Nội</li>
                    </ul>

                    <p>Cảm ơn bạn đã tin tưởng lựa chọn <strong>Cục hàng không Việt Nam</strong> đồng hành cùng hành trình của mình!</p>
                    `;
                    break;
                case 'booking':
                    content.innerHTML = `
                        <h2>Đặt vé máy bay</h2>
                        <p>Hãy chọn chuyến bay phù hợp với nhu cầu của bạn!</p>
                    `;
                    fetch('flights.jsp')  // Đường dẫn đến trang JSP bạn muốn tải
                    .then(response => response.text())  // Lấy nội dung trang JSP
                    .then(html => {
                    document.getElementById('content').innerHTML = html;  // Chèn nội dung vào phần content
                    })
                    .catch(error => console.error('Error loading the JSP page:', error));
                    break;
                case 'airline-manager':
                    content.innerHTML = `
                        <h2>Quản lý hãng hàng không</h2>
                        <p>Hệ thống hỗ trợ quản lý thông tin hãng hàng không hiệu quả.</p>
                    `;
                         fetch('FlightServlet')  // Đường dẫn đến trang JSP bạn muốn tải
                    .then(response => response.text())  // Lấy nội dung trang JSP
                    .then(html => {
                    document.getElementById('content').innerHTML = html;  // Chèn nội dung vào phần content
                    })
                    .catch(error => console.error('Error loading the JSP page:', error));
                    break;
                case 'airport-manager':
                    content.innerHTML = `
                        <h2>Quản lý sân bay</h2>
                        <p>Kiểm soát thông tin sân bay nhanh chóng và chính xác.</p>
                    `;
                             fetch('AirportServlet')  // Đường dẫn đến trang JSP bạn muốn tải
                    .then(response => response.text())  // Lấy nội dung trang JSP
                    .then(html => {
                    document.getElementById('content').innerHTML = html;  // Chèn nội dung vào phần content
                    })
                    .catch(error => console.error('Error loading the JSP page:', error));
                    break;
                case 'account-manager':
                    content.innerHTML = `
                        <h2>Quản lý tài khoản</h2>
                        <p>Hệ thống giúp quản lý tài khoản người dùng dễ dàng.</p>
                    `;
                                 fetch('AdminServlet')  // Đường dẫn đến trang JSP bạn muốn tải
                    .then(response => response.text())  // Lấy nội dung trang JSP
                    .then(html => {
                    document.getElementById('content').innerHTML = html;  // Chèn nội dung vào phần content
                    })
                    .catch(error => console.error('Error loading the JSP page:', error));
                    break;
                case 'customer-Information':
                    // Load Customer Information from editCustomer.jsp
                    fetch('editCustomer.jsp')  
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('content').innerHTML = html;
                    })
                    .catch(error => console.error('Error loading the JSP page:', error));
                    break;


            }
        }
        document.addEventListener("DOMContentLoaded", () => {
            showContent('home'); // Hiển thị nội dung trang Home
        });
        // Đăng xuất
        function logout() {
            fetch('LogoutServlet', { method: 'POST' }) // Gửi yêu cầu POST đến servlet xử lý đăng xuất
        .then(response => {
            if (response.ok) {
                // Nếu đăng xuất thành công, cập nhật giao diện
                
                window.location.href = 'home.jsp'; // Chuyển hướng đến trang chủ hoặc trang đăng nhập
            } else {
                alert("Có lỗi xảy ra khi đăng xuất!");
            }
        })
        .catch(error => {
            console.error('Error during logout:', error);
            alert("Có lỗi xảy ra khi đăng xuất!");
        });
        }

        // Hiển thị/ẩn các nút thông tin và đăng xuất khi nhấn vào tên người dùng
        function toggleUserOptions() {
            const username = "<%=name %>";
    const userOptions = document.getElementById('user-options');

    if (username && username.trim() !== "") {
        // Chỉ hiển thị menu nếu người dùng đã đăng nhập
        userOptions.style.display = userOptions.style.display === 'none' || userOptions.style.display === '' ? 'flex' : 'none';
    } else {
        // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
        window.location.href = "LoginServlet";
        userOptions.style.display='none';
    }
        }
        
    </script>
</body>
</html>
