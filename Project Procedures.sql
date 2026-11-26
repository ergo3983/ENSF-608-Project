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



