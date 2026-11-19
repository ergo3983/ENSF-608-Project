USE ensf_608_project;

-- Stored procedures, including at least one with an input parameter - 2

DROP PROCEDURE IF EXISTS InsertUser;

DELIMITER //
CREATE PROCEDURE InsertUser(
    IN username            varchar(30),
    IN password_hash       VARCHAR(64), 
    IN email               varchar(255),
    IN first_name          varchar(100),
    IN last_name           varchar(100),
    IN user_type           ENUM('Government User', 'Teacher User', 'Admin')
)
BEGIN
    INSERT INTO USERS (username, password_hash, email, first_name, last_name, user_type) VALUES
    (username, password_hash, email, first_name, last_name, user_type);
END //
DELIMITER ;

CALL InsertUser('Jack_Black', '123456', 'jack@gmail.com', 'Jack', 'Black', 'Teacher User');
-- Stored procedure to create new user


DROP PROCEDURE IF EXISTS StudentLocalityCountry;

DELIMITER //
CREATE PROCEDURE StudentLocalityCountry()
BEGIN
    SELECT DISTINCT STUDENT.*, LOCALITY.locality_name, COUNTRY.country_name
    FROM STUDENT
    LEFT JOIN class_student_takes ON 
    student.student_ID = class_student_takes.student_ID
    INNER JOIN CLASS ON
    class_student_takes.class_id = CLASS.class_ID
    INNER JOIN SCHOOL ON 
    CLASS.school_ID = SCHOOL.school_ID
    INNER JOIN LOCALITY ON 
    SCHOOL.locality_ID = LOCALITY.locality_ID
    INNER JOIN COUNTRY ON 
    LOCALITY.country_ID = COUNTRY.country_ID;
END //
DELIMITER ;

CALL StudentLocalityCountry();
-- Stored procedure to get locality and country of each student

DROP PROCEDURE IF EXISTS GetUserID;

DELIMITER //
CREATE PROCEDURE GetUserID(
    IN email varchar(255),
    OUT userID INT
)
BEGIN
    SELECT USERS.user_ID INTO userID
    FROM USERS
    WHERE USERS.email = email;
END //
DELIMITER ;

CALL GetUserID('jack@gmail.com', @t);
SELECT @t;
-- Stored procedure to retrieve user id based on email
-- User ID is needed to create references in other tables and is not something that would be known before insertion
-- Its value should also not be controlled through the front-end to prevent primary key errors or overwrites. 
