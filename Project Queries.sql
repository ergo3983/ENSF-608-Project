-- ENSF 608 Group 8: SQL Queries
-- SDG 4: Quality Education
-- Hyunseong Jeon, Changgun Yee, Eric Godin, Hamza Itani, Sobia Khan

USE ensf_608_project;


-- INSERT Operations
INSERT INTO USERS (user_ID, username, password_hash, email, first_name, last_name, user_type) VALUES
(7, 'Taylor_S', 'abcdefg', 'taylor.s@gmail.com', 'Taylor', 'Swift', 'Teacher User');
-- Create a new user called Taylor who can access and update the database as a teacher

INSERT INTO TEACHER_USER (teacher_ID, qualification, hire_date, school_id) VALUES
(7, 'Teaching License', '2020-09-20', 1);
-- Add user Taylor to the teacher_user table so that her school and qualifications can be recorded and she can access
-- and update student records.


-- UPDATE Operations
UPDATE GUARDIAN_PHONE
SET phone_number = '15872221111'
WHERE student_Id = 3 AND phone_number = '15871112222';
-- Replace an old phone number for student named Max with updated guardian contact phone number

UPDATE TEACHER_USER
SET qualification = "Masters in Education"
WHERE teacher_ID = 2;
-- Update teacher qulaifications when teacher updates their qualifications


-- DELETE Operations
DELETE FROM GOVERNMENT_USER 
WHERE government_id = 1;
-- Delete government user when they no longer work for the government

DELETE FROM CLASS 
WHERE class_id = 3 and school_id = 2;
-- Remove a class when it is no longer offered at the school


-- Basic SELECT Queries  using filtering conditions (WHERE, LIKE, IN, BETWEEN, AND, OR, etc.) - 4
SELECT CLASS.*
FROM CLASS
WHERE CLASS.teacher_ID = 2;
-- USE CASE: Teacher viewing list of classes they are teaching for the year
-- Get all classes a specific teacher (Sobia) teaches

SELECT LITERACY.*
FROM LITERACY
WHERE LITERACY.score <= 50
AND LITERACY.class_id = 2;
-- View literacy scores in a specific range for a specific 
-- USE CASE: Figure out which students failed - need more help, need to reattempt the exam

SELECT GOALS.*
FROM GOALS
WHERE GOALS.goal_status IN ('In Progress', 'Pending');
-- 5.	What are the goals that are being worked on and their current progress?

-- SELECT queries using ORDER BY, DISTINCT, or LIMIT - 2

-- Get top 5 students in a country in a subjet- offer scholarships (Order By and Limit)


SELECT FUNDING.*
FROM FUNDING 
WHERE FUNDING.school_id IS NULL
ORDER BY FUNDING.amount DESC;
-- Find all funding that hasn't already been awarded and list it by the total amount offered
-- USE CASE: Apply for funding that will have the largest impact


-- SELECT queries using aggregate functions (COUNT, SUM, AVG, MIN, MAX) - 3
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, COUNT(ATTENDANCE.attendance) AS Num_Absences
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date > '2025-09-01'
AND ATTENDANCE.attendance = 'absent'
GROUP BY ATTENDANCE.student_ID;
-- Get the number of times each student absent from the start of the school year in a specific school
-- USE CASE: Calculate attendance and if some student are missing too much school

-- SELECT MAX(LITERACY.score), LITERACY.student_ID
-- FROM LITERACY
-- INNER JOIN CLASS ON
-- LITERACY.class_id = class.class_id
-- INNER JOIN SCHOOL ON 
-- class.school_id = school.school_id
-- WHERE school.locality_id = 1
-- AND LITERACY.assessed_on >= '2026-01-01'
-- GROUP BY LITERACY.student_ID;
-- Select max literacy score of each student from this year in locality=1

-- SELECT queries using GROUP BY, including at least one with HAVING - 2
SELECT AVG(LITERACY.score) AS score, school.school_name
FROM LITERACY
LEFT JOIN CLASS ON
literacy.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
INNER JOIN lOCALITY ON
school.locality_id = school.locality_id
WHERE locality.country_id = 1 
GROUP BY school.school_name
ORDER BY score DESC;
-- 2.	Which schools have the lowest average literacy scores in a country?

SELECT class_id, COUNT(student_id) AS Num_Students
FROM CLASS_STUDENT_TAKES
WHERE class_student_takes.joined_on >= '2026-09-01'
GROUP BY class_id
HAVING Num_Students < 5;
-- Find the classes that have less than 5 students enrolled in them for the current school year
-- These localities may need additional resources to promote education and help enrolling students 


-- SELECT queries using INNER JOIN - 3
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, ATTENDANCE.absence_reason
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date = '2025-09-02'
AND ATTENDANCE.attendance = 'absent';
-- Get students that were absent on a specific date
-- USE CASE: Contacting parents of students who are absent often

-- Show a teacher's action items and the students receiving support
SELECT
    A.title AS activity,
    CONCAT(U.first_name, ' ', U.last_name) AS teacher,
    CONCAT(S.first_name, ' ', S.last_name) AS student
FROM ACTIONITEM AS A
INNER JOIN TEACHER_USER AS T
    ON A.teacher_ID = T.teacher_ID
INNER JOIN USERS AS U
    ON T.teacher_ID = U.user_ID
INNER JOIN STUDENT AS S
    ON A.student_ID = S.student_ID
WHERE A.teacher_ID = 4;

-- SELECT queries using LEFT JOIN or RIGHT JOIN - 2
SELECT COUNTRY.country_name, COUNTRY_STATISTICS.adult_literacy_rate 
FROM COUNTRY
LEFT JOIN country_statistics ON
COUNTRY_STATISTICS.country_id = COUNTRY.country_ID;
-- Literacy rate for a country - include countries without statistics because this is important info on if these countries
-- need more resources from the UN 


-- SELECT queries combining JOINs, aggregate functions, filtering, or grouping - 1
SELECT AVG(LITERACY.score), school.locality_id
FROM LITERACY
INNER JOIN CLASS ON
LITERACY.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
INNER JOIN locality ON 
school.locality_id = locality.locality_id
WHERE LITERACY.score IN (SELECT MAX(LITERACY.score)
                        FROM LITERACY
                        GROUP BY LITERACY.student_ID)  
AND LOCALITY.country_id = 1                      
GROUP BY SCHOOL.locality_id;
-- USE CASE: What is the literacy rate for a particular area?
-- Literacy rate among kids in every locality in a country using only their best score



-- 3.	What is the attendance ratio for boys vs girls in a locality?


-- 4.	Which schools in this country received the most funding?


-- 5.	What are the goals that are being worked on and their current progress?

