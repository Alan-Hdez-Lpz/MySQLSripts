-- 1
CREATE DATABASE StudentRecords;
USE StudentRecords;
-- 2
CREATE TABLE Students (
studentId INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR (50),
age INT,
email VARCHAR(100)
);
-- 3
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (1,'Alan','Hernandez', 29,'alan@hotmail.com');
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (2,'Omar','Lopez', 23,'omar@hotmail.com');
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (3,'Jose','Villegas', 25,'jose@gmail.com');
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (4,'Leticia','Gonzalez', 27,'leticia@hotmail.com');
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (5,'Erick','Hernandez', 22,'erick@gmail.com');

/*A Database is an organized collection of structured data, it stores data using tables and identifiers 
to create realtionships between tables.
The Databases are essential for managing information because they helps to update information 
if its necessary and show information according queries. 
Some examples are the database in a school when you have tables like Students, Teachers, Courses 
and we can manage the information to know the students that take a course and the teacher for those students*/

INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (6,'Ariel','Lopez', 25,'ariel@gmail.com');
INSERT INTO Students (studentId, firstName, lastName, age, email)
VALUES (7,'Ignacio','Hernandez', 23,'ignacio@hotmail.com');
SELECT * FROM Students;
UPDATE Students SET age = 21 WHERE studentId = 1;
SELECT * FROM Students;

/*Answer Question 1: The name, lastname and email mustbe varchar because they have leters and 
studentId and age can be varchar or int but is vetter int because we can add an auto increment for the sutdentId 
and compare the ages between the students is easier.
Answer Question 2: Some benefits of using databases is that you apply the queries to manage the information easier 
and also make the backup and restore of the information is easier*/