USE ensf_608_project;
SHOW TABLES;

SELECT CONCAT(STUDENT.first_name, ' ', STUDENT.last_name) AS "Student Name", ACTIONITEM.item_description AS "Action items", ACTIONITEM.item_status AS "Action item status"
FROM ACTIONITEM
RIGHT JOIN STUDENT ON 
STUDENT.student_id = ACTIONITEM.student_id
WHERE STUDENT.enrollment_status = TRUE AND STUDENT.disability_status != ''; 