-- ==========================================================
-- CHƯƠNG 7: STORED PROCEDURES
-- ==========================================================

DELIMITER //
CREATE PROCEDURE sp_register_member(IN p_full_name VARCHAR(120), IN p_email VARCHAR(100), IN p_phone VARCHAR(20))
BEGIN
    DECLARE v_new_id INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
    START TRANSACTION;
    IF EXISTS (SELECT 1 FROM member WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;
    INSERT INTO member (full_name, email, phone) VALUES (p_full_name, p_email, p_phone);
    SET v_new_id = LAST_INSERT_ID();
    INSERT INTO member_level_history (member_id, level_id) VALUES (v_new_id, 1);
    COMMIT;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_assign_trainer(IN p_session_id BIGINT, IN p_trainer_id INT, IN p_role VARCHAR(20))
BEGIN
    DECLARE v_status VARCHAR(20);
    SELECT status INTO v_status FROM session WHERE session_id = p_session_id;
    IF v_status != 'SCHEDULED' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid session status';
    END IF;
    INSERT INTO session_trainer (session_id, trainer_id, trainer_role) VALUES (p_session_id, p_trainer_id, p_role);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_cancel_training_session(IN p_session_id BIGINT, IN p_reason VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
    START TRANSACTION;
    UPDATE session SET status = 'CANCELLED', notes = p_reason WHERE session_id = p_session_id;
    UPDATE attendance SET status = 'CANCELLED' WHERE session_id = p_session_id;
    COMMIT;
END //
DELIMITER ;