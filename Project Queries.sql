USE ensf_608_project;
SHOW TABLES;

SELECT * FROM USERS WHERE username="sobiakhan2";

-- 1.	What is the literacy rate for a particular area?

-- Literacy rate for a country
SELECT COUNTRY.adult_literacy_rate, COUNTRY.country_name 
FROM COUNTRY;

-- Literacy rate among kids in a locality using only their best score
SELECT AVG(LITERACY.score)
FROM LITERACY
WHERE LITERACY.score IN (SELECT MAX(LITERACY.score)
                FROM LITERACY
                INNER JOIN CLASS_STUDENT_TAKES ON
                literacy.student_id = CLASS_STUDENT_TAKES.student_id
                INNER JOIN CLASS ON
                CLASS_STUDENT_TAKES.class_id = class.class_id
                INNER JOIN SCHOOL ON 
                class.school_id = school.school_id
                WHERE school.locality_id = 1
                GROUP BY LITERACY.student_ID);

-- Select max literacy score of each student in locality=1
SELECT MAX(LITERACY.score), LITERACY.student_ID
FROM LITERACY
INNER JOIN CLASS_STUDENT_TAKES ON
literacy.student_id = CLASS_STUDENT_TAKES.student_id
INNER JOIN CLASS ON
CLASS_STUDENT_TAKES.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
WHERE school.locality_id = 1
GROUP BY LITERACY.student_ID;

-- Get locality from literacy -> class -> school (locality)

-- 2.	Which schools have the lowest average literacy scores in a country?
-- 3.	What is the attendance ratio for boys vs girls in a locality?
-- 4.	Which schools in this country received the most funding?
-- 5.	What are the goals that are being worked on and their current progress?

