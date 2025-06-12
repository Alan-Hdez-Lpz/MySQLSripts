-- Step 1
CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;
CREATE TABLE Departments (
departmentId INT PRIMARY KEY,
departmentName VARCHAR(100)
);
CREATE TABLE Employees (
employeeId INT PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
age INT,
email VARCHAR(100) UNIQUE,
departmentId INT,
FOREIGN KEY(departmentId) REFERENCES Departments(departmentId)
);
CREATE TABLE Projects (
projectId INT PRIMARY KEY,
projectName VARCHAR(100),
projectBudget DECIMAL,
managerId INT,
FOREIGN KEY(managerId) REFERENCES Employees(employeeId)
);
-- Step 2
INSERT INTO Departments (departmentId, departmentName) VALUES
(1,'Human Resources'),
(2,'Engineering'),
(3,'Marketing');
INSERT INTO Employees (employeeId, firstName, lastName, age, email, departmentId) VALUES
(1,'Alice','Johnson',30,'alice.johnson@example.com',1),
(2,'Bob','Smith',45,'bob.smith@example.com',2),
(3,'Omar','Lopez',35,'omar.lopez@example.com',3),
(4,'Alan','Hernandez',29,'alan.hernandez@example.com',2),
(5,'Adam','Klimczak',35,'adam.klimczak@example.com',3);
INSERT INTO Projects (projectId, projectName, projectBudget, managerId) VALUES
(101,'Website Redesign',5000.00,2),
(102,'Mobile app creation',7000.00,4),
(103,'New product presentation',5500.00,5);

SELECT Employees.firstName, Employees.lastName, Departments.departmentName
FROM Employees
INNER JOIN Departments ON Employees.departmentId = Departments.departmentId;

SELECT Projects.projectName, Employees.firstName, Employees.lastName
FROM Projects
INNER JOIN Employees ON Projects.managerId = Employees.employeeId;

SELECT Employees.firstName, Employees.lastName, Departments.departmentName
FROM Employees
INNER JOIN Departments ON Employees.departmentId = Departments.departmentId
WHERE Employees.age > 40 AND Departments.departmentName = 'Engineering';

CREATE VIEW EmployeeDetails AS
SELECT Employees.employeeId, Employees.firstName, Employees.lastName, Departments.departmentName
FROM Employees
INNER JOIN Departments ON Employees.departmentId = Departments.departmentId;

CREATE VIEW ActiveProjects AS
SELECT Projects.projectName, Projects.projectBudget, Employees.firstName, Employees.lastName
FROM Projects
INNER JOIN Employees ON Projects.managerId = Employees.employeeId
WHERE Projects.projectBudget > 1000.00;

SELECT * FROM EmployeeDetails;
SELECT * FROM ActiveProjects;
-- Step 3
/*The approach of design the database tables and choosing constraints was organize the information
and create the relationships between tables. Joins helped to get the information between tables and
the views helped to create virtual tables to get the information about queries. I did not have a challenge. */