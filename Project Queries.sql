USE ensf_608_project;

-- Basic SELECT Queries  using filtering conditions (WHERE, LIKE, IN, BETWEEN, AND, OR, etc.) 
-- Get classes Sobia teaches
-- USE CASE: Viewing classes
SELECT CLASS.*
FROM CLASS
WHERE CLASS.teacher_ID = 2;

-- Get students that were absent on a specific date
-- USE CASE: Contacting parents of students who are absent often
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, ATTENDANCE.absence_reason
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date = '2025-09-02'
AND ATTENDANCE.attendance = 'absent';

-- View student scores for a specific class
-- Use Case: Teacher viewing student scores for standardized exam
SELECT LITERACY.* 
FROM LITERACY
WHERE LITERACY.class_id = 2;

-- View literacy scores in a specific range
-- USE CASE: Figure out which students failed - need more help, need to reattempt the exam
SELECT LITERACY.*
FROM LITERACY 
WHERE LITERACY.score <= 50;

-- SELECT queries using aggregate functions (COUNT, SUM, AVG, MIN, MAX) 

-- Get the number of times each student absent from the start of the school year in a specific school
-- USE CASE: Calculate attendance and if some student are missing too much school
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, COUNT(ATTENDANCE.attendance) AS Num_Absences
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date > '2025-09-01'
AND ATTENDANCE.attendance = 'absent'
GROUP BY ATTENDANCE.student_ID;


-- 1.	What is the literacy rate for a particular area?

-- Literacy rate for a country - include countries without statistics
SELECT COUNTRY.country_name, COUNTRY_STATISTICS.adult_literacy_rate 
FROM COUNTRY
LEFT JOIN country_statistics ON
COUNTRY_STATISTICS.country_id = COUNTRY.country_ID;

-- Literacy rate among kids in every locality in a country using only their best score
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

-- Select max literacy score of each student from this year in locality=1
SELECT MAX(LITERACY.score), LITERACY.student_ID
FROM LITERACY
INNER JOIN CLASS ON
LITERACY.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
WHERE school.locality_id = 1
AND LITERACY.assessed_on >= '2026-01-01'
GROUP BY LITERACY.student_ID;

-- 2.	Which schools have the lowest average literacy scores in a country?
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

-- 3.	What is the attendance ratio for boys vs girls in a locality?


-- 4.	Which schools in this country received the most funding?


-- 5.	What are the goals that are being worked on and their current progress?

