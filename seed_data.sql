-- ==========================================================
-- CHƯƠNG 8: STORED FUNCTIONS
-- ==========================================================

DELIMITER //
CREATE FUNCTION fn_RemainingSeat(p_session_id BIGINT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_remaining INT;
    SELECT (c.capacity - COUNT(a.member_id)) INTO v_remaining
    FROM session s JOIN course c ON s.course_id = c.course_id
    LEFT JOIN attendance a ON s.session_id = a.session_id
    WHERE s.session_id = p_session_id;
    RETURN COALESCE(v_remaining, 0);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_TotalTrainingHour(p_trainer_id INT, p_month INT, p_year INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_sum DECIMAL(5,2);
    -- Cần bổ sung điều kiện lọc tháng/năm vào WHERE
    SELECT SUM(duration) INTO v_sum FROM session WHERE trainer_id = p_trainer_id; 
    RETURN COALESCE(v_sum, 0.00);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_CurrentLevel(p_pet_id INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_lvl VARCHAR(100);
    -- Cần bổ sung điều kiện JOIN và lọc theo pet_id
    SELECT name INTO v_lvl FROM training_level ORDER BY date DESC LIMIT 1; 
    RETURN COALESCE(v_lvl, 'Puppy Start');
END //
DELIMITER ;