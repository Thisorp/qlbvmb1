# qlbvmb – Hệ thống quản lý bán vé máy bay

## Mô tả

Dự án web quản lý bán vé máy bay sử dụng Java Servlet, JSP, Ant, MySQL.

## Cấu trúc dự án

- `src/`: Mã nguồn Java
- `web/`: Giao diện JSP, tài nguyên tĩnh
- `build.xml`: Script build với Ant
- `qlbvmb.sql`: File khởi tạo CSDL

## Hướng dẫn sử dụng

### 1. Clone dự án về máy

```sh
git clone https://github.com/<ten_tai_khoan>/<ten_repo>.git
```

### 2. Import vào NetBeans hoặc IDE hỗ trợ Ant

- Mở NetBeans, chọn Open Project, trỏ tới thư mục dự án.

### 3. Cấu hình CSDL

- Tạo database MySQL, import file `qlbvmb.sql`.
- Cập nhật thông tin kết nối DB trong file `Database.java` nếu cần.

### 4. Build & Run

- Sử dụng lệnh Ant hoặc NetBeans để build/run:

```sh
ant clean
ant build
ant run
```

### 5. Truy cập web

- Mở trình duyệt và truy cập theo địa chỉ localhost hoặc port mà server chỉ định.

## Đóng góp

Pull request và issue luôn được chào đón!
