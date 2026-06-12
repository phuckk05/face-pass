# FacePass — App Chấm Công Bằng Nhận Diện Khuôn Mặt

FacePass là ứng dụng chấm công (attendance) trên di động sử dụng **nhận diện
khuôn mặt on-device** (FaceNet + ML Kit) kết hợp **Firebase** làm backend,
được xây dựng trên **Flutter** theo kiến trúc **Clean Architecture** với
**BLoC/Cubit** cho state management.

---

## 📑 Mục lục

- [Tính năng chính](#-tính-năng-chính)
- [Kiến trúc tổng quan](#-kiến-trúc-tổng-quan)
- [Công nghệ sử dụng](#-công-nghệ-sử-dụng)
- [Cấu trúc thư mục](#-cấu-trúc-thư-mục)
- [Luồng nhận diện khuôn mặt](#-luồng-nhận-diện-khuôn-mặt)
- [Quy tắc tính trạng thái chấm công](#-quy-tắc-tính-trạng-thái-chấm-công)
- [Cài đặt & chạy dự án](#-cài-đặt--chạy-dự-án)
- [Cấu hình Firebase](#-cấu-hình-firebase)
- [Model TFLite (FaceNet)](#-model-tflite-facenet)
- [Định tuyến (Routing)](#-định-tuyến-routing)
- [Quản lý State (BLoC/Cubit)](#-quản-lý-state-bloccubit)
- [Xuất báo cáo Excel](#-xuất-báo-cáo-excel)
- [Roadmap](#-roadmap)

---

## ✨ Tính năng chính

- **Đăng ký khuôn mặt nhân viên**: quét 5 góc mặt khác nhau để tạo bộ vector
  embedding đại diện cho một người.
- **Chấm công bằng khuôn mặt (Check-in / Check-out)**: nhận diện realtime qua
  camera trước, so khớp với dữ liệu đã đăng ký bằng **Cosine Similarity**.
- **Timeline chấm công**: hiển thị lịch sử check-in/check-out theo từng ngày,
  có đánh dấu trạng thái Đúng giờ / Đi trễ / Vắng mặt / Về sớm.
- **Xuất báo cáo Excel**: xuất dữ liệu chấm công ra file `.xlsx` lưu trên
  thiết bị.
- **Xử lý AI on-device**: chạy nhận diện khuôn mặt hoàn toàn offline bằng
  TensorFlow Lite (FaceNet) + Google ML Kit, không cần gửi ảnh lên server.

---

## 🏗️ Kiến trúc tổng quan

Dự án áp dụng **Clean Architecture** chia theo 3 lớp cho mỗi feature:

```
Presentation (UI + BLoC/Cubit)
        ↓
   Domain (Entities + UseCases + Repository Interfaces)
        ↓
     Data (Models + Datasources + Repository Implementations)
        ↓
      Firebase Realtime Database
```

**Luồng phụ thuộc**: Presentation → Domain ← Data
(Domain không phụ thuộc vào Data hay Presentation — tuân theo nguyên tắc
Dependency Inversion).

**Dependency Injection**: dùng `get_it` để khởi tạo và inject
datasource → repository → usecase → bloc tại `main.dart`.

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
|---|---|
| Ngôn ngữ | Dart / Flutter |
| State management | `flutter_bloc` (Bloc + Cubit) + `freezed` |
| Camera | `camera` (CameraController + CameraPreview) |
| Phát hiện khuôn mặt | `google_mlkit_face_detection` |
| Nhận diện khuôn mặt | `tflite_flutter` + model **FaceNet** (`.tflite`) |
| Xử lý ảnh | `image` (crop, resize khuôn mặt) |
| Xử lý song song | `compute` + `RootIsolateToken` (background isolate) |
| Backend / Database | `firebase_core` + Firebase Realtime Database |
| Định tuyến | `go_router` |
| Dependency Injection | `get_it` |
| Model JSON | `freezed_annotation` + `json_serializable` |
| Xuất Excel | `excel`, `path_provider`, `permission_handler` |

---

## 📁 Cấu trúc thư mục

```
lib/
├── main.dart                     # Khởi tạo Firebase, DI (get_it), đăng ký BLoC
├── core/
│   ├── router/
│   │   └── router_app.dart       # Định tuyến bằng go_router
│   └── utils/
│       ├── camera_utils.dart     # Cosine similarity, isolate nhận diện, format ngày giờ
│       └── excel_services.dart   # Xuất file báo cáo Excel
└── features/
    └── face_verification/
        ├── data/
        │   ├── datasource/remote/        # Giao tiếp Firebase
        │   │   ├── faces_datasource.dart
        │   │   ├── users_datasource.dart
        │   │   └── attendance_datasource.dart
        │   ├── models/                   # FaceEmbeddingModel, UserModel, AttendanceModel (Freezed)
        │   └── repositories/             # Triển khai cụ thể repository
        ├── domain/
        │   ├── entities/                 # User, FaceEmbedding, Attendance (entity thuần)
        │   ├── repositories/             # Interface (abstract class)
        │   └── usecase/                  # RegisterFaceUseCase, RegisterUserUseCase,
        │                                  # RegistedFace, PushAttendance
        └── presentasion/
            ├── blocs/
            │   ├── recognizing_face/     # Xử lý quét & so khớp khuôn mặt
            │   ├── recognized_faces/     # Danh sách embedding đã đăng ký
            │   ├── register_user/        # Đăng ký người dùng mới
            │   └── attendance/           # Lịch sử chấm công
            ├── cubit/
            │   └── camera_process_cubit.dart  # Trạng thái camera (ready/processing)
            ├── screens/
            │   ├── home_screen.dart
            │   ├── camera_screen.dart     # Màn hình quét/chấm công
            │   └── timeline_screen.dart   # Lịch sử chấm công dạng timeline
            └── widgets/
                ├── camera_cus.dart         # CameraPreview full màn hình
                ├── face_oval_cus.dart      # Khung oval hướng dẫn đặt mặt
                ├── corner_painter_cus.dart # Vẽ 4 góc khung quét
                ├── date_chip_cus.dart
                ├── live_chip_cus.dart
                ├── timeline_cus.dart       # Item timeline chấm công
                └── buttom_pannel_cus.dart  # Panel nút Scan / Check
```

---

## 🧠 Luồng nhận diện khuôn mặt

```
┌──────────────┐   takePicture()   ┌────────────────────┐
│ CameraScreen │ ────────────────► │  Ảnh JPEG tạm (path) │
└──────────────┘                   └─────────┬──────────┘
                                              │ compute(isolate)
                                              ▼
                          ┌──────────────────────────────────┐
                          │ CameraUtils.recognizeIsolate       │
                          │ 1. ML Kit FaceDetector              │
                          │    → tìm bounding box khuôn mặt    │
                          │ 2. Crop + resize ảnh về 160x160     │
                          │ 3. Chuẩn hoá pixel (-128)/128        │
                          │ 4. Interpreter.run() → FaceNet      │
                          │    → vector embedding 128 chiều     │
                          └─────────────────┬──────────────────┘
                                            ▼
                          List<double> embedding (128-d)
```

### Đăng ký khuôn mặt (5 lần quét)

`RecognizingFaceBloc` thu thập **5 embedding** liên tiếp
(`vector1`…`vector5`) cho cùng một người:

1. `CreateTempFaceEmbedding` — tạo `FaceEmbedding` tạm với 5 vector rỗng.
2. Mỗi lần chụp → `ProcessingFaceEvent` với `embedding` mới.
   - Lần đầu (`index == 1`) → lưu trực tiếp vào `vector1`.
   - Các lần sau → so sánh **cosine similarity** giữa embedding mới và
     `vector1`; nếu `similarity > 0.8` thì coi là cùng một khuôn mặt và
     lưu vào `vector{index}`.
3. Khi đủ 5 vector → emit `RecognizingFaceState.success` và bắn
   `AddRecognizedFaceEvent` để `RecognizedFacesBloc` lưu lên Firebase.

### Chấm công (Check-in/Check-out)

1. Camera chụp ảnh → tính embedding qua isolate.
2. So sánh embedding mới với **toàn bộ embedding đã đăng ký** trong
   `RecognizedFacesBloc` bằng cosine similarity.
3. Nếu tìm được người khớp (similarity vượt ngưỡng) → bắn
   `PushAttendance` usecase để ghi lại bản ghi chấm công
   (`Attendance`) lên Firebase, kèm `type` (checkIn/checkOut) và
   `status` được tính tự động.

---

## 📊 Quy tắc tính trạng thái chấm công

Entity `Attendance` có 2 enum quan trọng:

```dart
enum AttendanceType { checkIn, checkOut }
enum AttendanceStatus { onTime, late, absent, early }
```

| Trạng thái | Điều kiện |
|---|---|
| `onTime` (Đúng giờ) | Check-in trong khung giờ quy định (mặc định mốc **08:00**) |
| `late` (Đi trễ) | Check-in sau **08:00**; số phút trễ tính bằng `CameraUtils.calculateLateTime()` |
| `early` (Về sớm) | Check-out trước giờ quy định |
| `absent` (Vắng mặt) | Không có bản ghi check-in trong ngày |

`CameraUtils` cung cấp các hàm hỗ trợ:

```dart
CameraUtils.formatDateTime(dateTime); // "08:15:00 15/06/2026"
CameraUtils.formatTime(dateTime);     // "08:15:00"
CameraUtils.calculateLateTime(dateTime); // "15 phút"
```

---

## 🚀 Cài đặt & chạy dự án

### Yêu cầu

- Flutter SDK ≥ 3.22 (Dart SDK ≥ 3.3.0)
- Android Studio / Xcode (build native)
- Tài khoản Firebase (Realtime Database)

### Các bước

```bash
# 1. Clone dự án
git clone <repo-url>
cd facepass

# 2. Cài dependency
flutter pub get

# 3. Generate code (freezed, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Cấu hình Firebase (xem mục dưới)

# 5. Chạy app
flutter run
```

### Quyền cần cấp (Android)

`android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
    android:maxSdkVersion="28"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

---

## 🔥 Cấu hình Firebase

1. Tạo project trên [Firebase Console](https://console.firebase.google.com/).
2. Bật **Realtime Database** (chọn region gần nhất).
3. Thêm app Android/iOS, tải `google-services.json` (Android) hoặc
   `GoogleService-Info.plist` (iOS) vào đúng thư mục:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
4. Cấu trúc dữ liệu Realtime Database tham khảo:

```
facepass-db/
├── users/
│   └── {userId}/
│       ├── id
│       ├── name
│       ├── department
│       ├── avatarUrl
│       └── createdAt
├── faces/
│   └── {faceId}/
│       ├── id
│       ├── userId
│       ├── vector1..vector5   (List<double>, 128 chiều mỗi vector)
│       └── registeredAt
└── attendances/
    └── {attendanceId}/
        ├── id
        ├── userId
        ├── checkedAt
        ├── type        # checkIn | checkOut
        ├── status      # onTime | late | absent | early
        └── similarity
```

> ⚠️ Khi đọc dữ liệu từ Realtime Database, luôn cast `snapshot.value` về
> `Map<Object?, Object?>` rồi convert key sang `String` trước khi gọi
> `fromJson` — Firebase trả về `_Map<Object?, Object?>`, cast trực tiếp
> sang `Map<String, dynamic>` sẽ lỗi runtime.

---

## 🤖 Model TFLite (FaceNet)

- Đặt file model tại: `assets/models/facenet.tflite`
- Khai báo trong `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/models/facenet.tflite
```

- **Input**: ảnh khuôn mặt đã crop, resize `160x160x3`, chuẩn hoá pixel
  về khoảng `[-1, 1]` bằng công thức `(pixel - 128) / 128`.
- **Output**: vector embedding **128 chiều** (`List<double>`).
- So khớp 2 khuôn mặt bằng **Cosine Similarity**
  (`CameraUtils.cosineSimilarity`), ngưỡng khớp khuyến nghị: **> 0.8**.
- Inference được chạy trong **background isolate** (`compute` +
  `RootIsolateToken` + `BackgroundIsolateBinaryMessenger`) để không làm
  giật UI khi xử lý ảnh.

---

## 🧭 Định tuyến (Routing)

Sử dụng `go_router`, định nghĩa tại `lib/core/router/router_app.dart`:

| Route | Path | Mô tả |
|---|---|---|
| `home` | `/home` | Màn hình chính |
| `camera` | `/camera:index` | Màn hình quét khuôn mặt (đăng ký hoặc chấm công, phân biệt qua `index`) |
| `timeline` | `/timeline` | Lịch sử chấm công dạng timeline |

Điều hướng:

```dart
context.goNamed('camera', pathParameters: {'index': '0'});
context.goNamed('timeline');
```

---

## 🧩 Quản lý State (BLoC/Cubit)

| Bloc/Cubit | Vai trò |
|---|---|
| `RecognizingFaceBloc` | Quản lý quá trình quét 5 vector khuôn mặt, so sánh similarity giữa các lần quét |
| `RecognizedFacesBloc` | Danh sách embedding đã đăng ký, dùng để so khớp khi chấm công |
| `UserBloc` | Đăng ký / lấy thông tin người dùng |
| `AttendanceBloc` | Lấy & ghi lịch sử chấm công (`FetchAttendancesEvent`, `PushAttendance`) |
| `CameraProcessCubit` | Trạng thái camera: `isCameraReady`, `isProcessing` |

Tất cả state đều dùng **Freezed sealed classes** với pattern
`when` / `maybeWhen` để xử lý UI theo từng trạng thái (initial, processing,
success, failed...).

---

## 📤 Xuất báo cáo Excel

`core/utils/excel_services.dart` cung cấp hàm xuất danh sách `Attendance`
ra file `.xlsx`:

- Convert từng `Attendance` → `Map<String, dynamic>` với header tiếng Việt
  (`Mã NV`, `Ngày`, `Thời gian`, `Loại`, `Trạng thái`).
- Sort theo `checkedAt` tăng dần trước khi xuất.
- File lưu tại thư mục **Download** của thiết bị (Android), đọc lại bằng
  package `excel` để hiển thị preview ngay trong app (`DataTable`) nếu cần.

```dart
final path = await ExcelExportService.exportAttendance(
  data: records,
  fileName: 'attendance_report',
);
```
