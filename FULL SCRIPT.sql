CREATE DATABASE IF NOT EXISTS petcare_db;
USE petcare_db;

-- 1. Bảng danh mục cấp độ
CREATE TABLE training_levels (
    level_id INT PRIMARY KEY,
    level_name VARCHAR(50)
);

-- 2. Bảng thành viên
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    join_date DATE
);

-- 3. Bảng buổi huấn luyện
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    session_date DATE
);

-- 4. Bảng điểm danh (Bảng cốt lõi để test)
CREATE TABLE session_attendance (
    session_id INT,
    member_id INT,
    attended_at TIMESTAMP,
    PRIMARY KEY (session_id, member_id),
    FOREIGN KEY (session_id) REFERENCES sessions(session_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);
-- Chèn cấp độ và thành viên mẫu số 1005
INSERT INTO training_levels VALUES (1, 'Puppy Start');
INSERT INTO members VALUES (1005, 'Trần Thị Chinh', '2026-01-01');

-- Chèn buổi học mẫu số 101
INSERT INTO sessions VALUES (101, '2026-07-02');

-- Chèn một dòng điểm danh ban đầu để làm gốc cho lệnh UPDATE
INSERT INTO session_attendance VALUES (101, 1005, '2026-07-02 08:00:00');
-- Tạo bảng hứng log tự động
CREATE TABLE IF NOT EXISTS attendance_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT,
    member_id INT,
    action_type VARCHAR(20),
    old_attended_at TIMESTAMP,
    new_attended_at TIMESTAMP,
    changed_by VARCHAR(100),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Nạp Trigger vào hệ thống
DELIMITER $$
CREATE TRIGGER trg_au_attendance_audit
AFTER UPDATE ON session_attendance
FOR EACH ROW
BEGIN
    IF NEW.attended_at > NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ (BR08): Thời gian điểm danh thực tế không thể vượt quá thời gian hiện tại!';
    END IF;

    IF NOT (OLD.attended_at <=> NEW.attended_at) THEN
        INSERT INTO attendance_audit (session_id, member_id, action_type, old_attended_at, new_attended_at, changed_by)
        VALUES (NEW.session_id, NEW.member_id, 'UPDATE', OLD.attended_at, NEW.attended_at, USER());
    END IF;
END$$
DELIMITER ;
UPDATE session_attendance 
SET attended_at = '2026-07-02 08:30:00' 
WHERE session_id = 101 AND member_id = 1005;

-- Xem kết quả bảng Audit xem trigger tự ghi dòng log nào chưa:
SELECT * FROM attendance_audit;
UPDATE session_attendance 
SET attended_at = '2027-12-31 23:59:59' 
WHERE session_id = 101 AND member_id = 1005;
-- Tạo chỉ mục hỗn hợp đón đầu bộ lọc WHERE và ORDER BY
CREATE INDEX idx_sa_member_session ON session_attendance (member_id, session_id);
USE petcare_db;

-- Chạy phân tích Execution Plan
EXPLAIN 
SELECT sa.member_id, sa.session_id, sa.attended_at
FROM session_attendance sa
WHERE sa.member_id = 1005
ORDER BY sa.session_id DESC;