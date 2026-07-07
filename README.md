#  TÀI LIỆU DỰ ÁN: HỆ THỐNG QUẢN LÝ CÂU LẠC BỘ HUẤN LUYỆN THÚ CƯNG (PETCARE TRAINING CLUB)

Dưới đây là sơ đồ cấu trúc và danh mục các file tài liệu, mã nguồn SQL thuộc dự án Báo cáo cuối kỳ của Nhóm 12.

---

##  1. Tài liệu & Thiết kế hệ thống
* **`Báo cáo cuối kỳ.pdf`**: File báo cáo chi tiết nội dung đồ án, lý thuyết và kết quả thực hiện.
* **`Sơ đồ ERD.mwb`**: File thiết kế mô hình thực thể mối quan hệ (ERD) trên phần mềm MySQL Workbench.
* **`Pet_care_training_club.mwb`**: File thiết kế cấu trúc các bảng vật lý của cơ sở dữ liệu.

---

##  2. Mã nguồn Cơ sở dữ liệu (SQL Scripts)
* **`FULL SCRIPT.sql`**: Bản script đầy đủ bao gồm toàn bộ quá trình khởi tạo cấu trúc và dữ liệu cho hệ thống.
* **`PetCareTrainingClub.sql`**: Mã nguồn khởi tạo các bảng (Tables) và ràng buộc dữ liệu chính.
* **`seed_data.sql`**: File chứa dữ liệu mẫu (Insert) phục vụ cho việc chạy thử nghiệm hệ thống.
* **`routines.sql`**: Nơi lưu trữ các thủ tục (Stored Procedures), hàm (Functions) và Trigger của dự án.
* **`Test.sql`**: File chứa các câu lệnh truy vấn, test case kiểm tra chức năng hệ thống.
* **`PetCareTrainingClub_Backup.sql`**: Bản sao lưu (Backup) dự phòng của toàn bộ cơ sở dữ liệu.

---

##  3. Hướng dẫn cài đặt & Sử dụng
1. Tải và cài đặt phần mềm **MySQL Workbench**.
2. Mở file `Pet_care_training_club.mwb` để xem cấu trúc sơ đồ trực quan.
3. Chạy file `FULL SCRIPT.sql` trong MySQL để tự động tạo toàn bộ cơ sở dữ liệu và nạp dữ liệu mẫu.
# Bao-cao-cuoi-ky-Nhom-12
Github đề tài " Thiết kế và triển khai cơ sở dữ liệu quản lý câu lạc bộ huấn luyện thú cưng PETCARE TRAINING CLUB"
# PetCare Training Club Database Management System
## Introduction
PetCare Training Club Database Management System là dự án môn Database Systems nhằm xây dựng cơ sở dữ liệu quản lý hoạt động của câu lạc bộ huấn luyện thú cưng. Hệ thống hỗ trợ quản lý thành viên, huấn luyện viên, lớp học, buổi huấn luyện, điểm danh và quá trình thăng cấp.
## Project Objectives
Quản lý thành viên và huấn luyện viên.
Quản lý cấp độ và yêu cầu huấn luyện.
Quản lý lớp học và buổi huấn luyện.
Theo dõi điểm danh và lịch sử thăng cấp.
Hỗ trợ thống kê và báo cáo.
## Database Model
Hệ thống gồm 9 bảng, chia thành 3 nhóm:

Training: TrainingLevel, TrainingRequirement
Members: Members, Trainer, MemberLevel
Activities: TrainingClass, TrainingSession, Attendance, SessionTrainer
 Main Features
Member Management
Trainer Management
Training Management
Attendance Tracking
Level Progress Tracking
Statistical Reporting
 Database Components
Database Schema

## Thiết kế cơ sở dữ liệu với 9 bảng và đầy đủ khóa chính, khóa ngoại.

Views
Hỗ trợ thống kê và báo cáo dữ liệu.
Stored Procedures
Tự động hóa các nghiệp vụ chính.
Stored Functions
Thực hiện các phép tính và thống kê.
Triggers
Tự động xử lý các quy tắc nghiệp vụ.
Secondary Indexes
Tối ưu hiệu suất truy vấn.
SQL Query Pack
Bao gồm các truy vấn phục vụ:
Member Statistics
Trainer Statistics
Attendance Reports
Training Reports
Business Analytics
Deployment
Create Database
Execute Schema
Import Seed Data
Create Views
Create Procedures & Functions
Create Triggers
Run SQL Queries
## Testing
The database has been tested for:

Schema
Constraints
SQL Queries
Views
Procedures
Functions
Triggers
# Team

Course: Database Systems

Project: PetCare Training Club Database Management System

Group: Group 12
