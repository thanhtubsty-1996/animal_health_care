
# Animal Health App Blueprint

## 1. Tổng quan

Ứng dụng này là một công cụ quản lý phòng khám thú y, giúp nhân viên phòng khám theo dõi và quản lý thông tin khách hàng, thú cưng, lịch hẹn và các quy trình khám bệnh. Ứng dụng được xây dựng bằng Flutter, hướng tới một giao diện người dùng sạch sẽ, hiện đại và dễ sử dụng trên cả nền tảng di động và web.

## 2. Kiến trúc và Công nghệ

- **Kiến trúc nền tảng**: Clean Architecture, phân tách rõ ràng 3 lớp: Presentation, Domain, và Data.
- **State Management**: `flutter_bloc` và `bloc` là giải pháp chính cho việc quản lý trạng thái của các tính năng. `provider` được sử dụng để cung cấp BLoCs và các services khác xuống cây widget.
- **Dependency Injection**: `get_it` và `injectable` được sử dụng để tự động hóa việc đăng ký và cung cấp các lớp phụ thuộc.
- **Điều hướng (Routing)**: `go_router` cho việc quản lý điều hướng khai báo, hỗ trợ deep linking.
- **Giao tiếp mạng**: `dio` là HTTP client chính.
- **Dữ liệu hiện tại**: Dữ liệu đang được giả lập (mocked) trong lớp `AnimalHealthApi`.

## 3. Thiết kế và Phong cách (Style & Design)

### 3.1. Hệ thống Theme

- **Framework**: `flex_color_scheme` được sử dụng để tạo theme một cách nhanh chóng và linh hoạt, dựa trên Material 3.
- **Màu sắc chủ đạo (Seed Color)**: `Color(0xFF2E7D32)` (xanh lá cây đậm), tạo cảm giác tin cậy, tự nhiên và liên quan đến sức khỏe.
- **Quản lý trạng thái Theme**: `provider` và `ChangeNotifier` (`ThemeProvider`).

### 3.2. Typography

- **Font chữ**: `google_fonts` (`Poppins` cho tiêu đề, `Open Sans` cho nội dung).

### 3.3. Component Styling

- **AppBar**: Trong suốt, tích hợp với hiệu ứng 3D Drawer.
- **Card**: Bo góc tròn (`borderRadius: 16.0`), đổ bóng tinh tế để tạo chiều sâu.
- **3D Drawer**: Giao diện điều hướng chính với hiệu ứng 3D tùy chỉnh.

## 4. Kiến trúc Thư mục và Định hướng Tính năng

Cấu trúc thư mục của ứng dụng, đặc biệt là trong lớp `presentation`, được tổ chức theo **ngữ cảnh và tính năng** để phản ánh rõ ràng luồng nghiệp vụ và tạo điều kiện cho việc mở rộng trong tương lai.

```
lib/
└── presentation/
    ├── bloc/                 # BLoCs cho các tính năng
    ├── screens/
    │   ├── clinic/           # Module chức năng cho "Phòng khám"
    │   │   ├── clinic_screen.dart
    │   │   ├── customers/      # Tính năng con: Quản lý Khách hàng
    │   │   │   ├── customer_detail_screen.dart
    │   │   │   ├── customer_list_screen.dart
    │   │   │   └── ...
    │   │   └── medical_examination/ # Tính năng con: Khám bệnh (dự định)
    │   │       └── medical_examination_screen.dart
    │   ├── dashboard_screen.dart # Màn hình tổng quan
    │   ├── pet/                  # Module chức năng: Quản lý Thú cưng
    │   │   └── pet_screen.dart
    │   ├── settings/             # Module chức năng: Cài đặt
    │   │   └── settings_screen.dart
    │   └── main_layout.dart      # Layout chính chứa Drawer và body
    ├── theme/                  # Theme và style
    └── widgets/                # Các widget tái sử dụng
```

**Định hướng chính:**

-   **Module `clinic`**: Là trung tâm của ứng dụng, nơi nhân viên phòng khám thực hiện các nghiệp vụ chính.
-   **Tính năng lồng nhau**: Các tính năng được tổ chức theo cấu trúc cây (ví dụ: `pet` nằm trong `customer`) để phản ánh mối quan hệ trong thực tế (thú cưng thuộc về một khách hàng).
-   **Khả năng mở rộng**: Dễ dàng thêm các module chức năng mới (ví dụ: `inventory`, `billing`) hoặc các vai trò người dùng mới (ví dụ: `customer_portal`) trong tương lai.

## 5. Lịch sử Tiến hóa Giao diện

1.  **Backdrop Tùy chỉnh**: Bị loại bỏ do vấn đề hiệu năng.
2.  **`Drawer` Tiêu chuẩn**: Bị loại bỏ do quá đơn điệu.
3.  **3D Drawer Tùy chỉnh**: Được giữ lại, cân bằng giữa thẩm mỹ và hiệu năng.
4.  **Dashboard Timeline**: Bị loại bỏ do không đạt yêu cầu thẩm mỹ.
5.  **Dashboard Grid**: Phiên bản hiện tại, hiện đại và tập trung vào dữ liệu.
