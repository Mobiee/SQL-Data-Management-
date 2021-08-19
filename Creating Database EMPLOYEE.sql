-- Creating Database EMPLOYEE:
CREATE DATABASE EMPLOYEE;

	-- CREATING TABLE employee
CREATE TABLE employee (
      EMPNO int(11) NOT NULL,
      ENAME varchar(30) NOT NULL,
      JOB varchar(30) NOT NULL,
      MGRNO int(11) DEFAULT NULL,
      HIREDATE DATE  NOT NULL,
      SAL int(11) NOT NULL CHECK (SAL >= 1000 AND SAL <= 10000),
      COMM int(11) DEFAULT NULL,
      DEPTNO int(11) DEFAULT NULL,
      PRIMARY KEY (EMPNO) ,
FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO));


-- Creating DEPT table:
      CREATE TABLE DEPT (
      DEPTNO int(15) NOT NULL,
      DNAME varchar(30) NOT NULL,
      LOCATION varchar(30) NOT NULL,
      PRIMARY KEY(DEPTNO)
);


-- Inserting values into DEPT Table
INSERT INTO DEPT (DEPTNO, DNAME, LOCATION) VALUES (10, 'CONSULTING', 'ADELAIDE'),
(20, 'SALES', 'ADELAIDE'),
     (30, 'MARKETING', 'SYDNEY'),
     (40, 'EDUCATION', 'MELBOURNE');



-- Inserting values into Employee Table
INSERT INTO `employee` (`EMPNO`, `ENAME`, `JOB`, `MGRNO`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`)
 VALUES(7369, 'ANNE', 'PROGRAMMER', 7902, '2016-12-17', 1200, NULL, 20),
 (7499, 'JIM', 'SALESMAN', 7698, '2013-02-20', 1600, 1000, 30), 
 (7521, 'JILL', 'SALESMAN', 7698, '2015-02-22', 2300, 500, 30), 
 (7566, 'DEAN', 'TRAINER', 7839, '2017-04-02', 3200, NULL, 40),
  (7654, 'MIKE', 'SALESMAN', 7698, '2012-09-28', 3300, 3500, 30), 
  (7698, 'LARRY', 'TRAINER', 7839, '2015-05-01', 3000, NULL, 30), 
  (7782, 'RICHARD', 'TRAINER', 7839, '2015-06-09', 4200, NULL, 10), 
  (7788, 'KIM', 'ANALYST', 7566, '2016-12-09', 3000, NULL, 20), 
  (7839, 'ALAN', 'TRAINER', NULL, '2013-11-17', 5000, NULL, 10), 
  (7844, 'JEAN', 'SALESMAN', 7698, '2013-09-08', 1500, NULL, 30), 
  (7876, 'ADAM', 'PROGRAMMER', 7788, '208-01-12', 3100, NULL, 20),
   (7900, 'JAMES', 'PROGRAMMER', 7698, '2015-12-03', 3500, NULL,30),
    (7902, 'HARRY', 'ANALYST', 7566, '2017-12-03', 3000, NULL, 40), 
    (7934, 'TIM', 'PROGRAMMER', 7782, '2018-01-23', 4500, NULL, 10);



   -- Finding employees (ENAME) whose job (JOB) is either ANALYST or PROGRAMMER.
	SELECT ENAME
	FROM employee
	WHERE JOB='ANALYST' OR JOB='PROGRAMMER'


	-- Find employees (ENAME) whose salary (SAL) is higher than their manager’s salary.
SELECT E.EMPNO, E.ENAME
FROM employee E
INNER JOIN employee Manager ON Manager.EMPNO = E.MGRNO
     WHERE E.SAL > Manager.SAL


     -- Find departments (DNAME) in which all employees earn more than 4000.
    SELECT E.ENAME , E.SAL ,D.DNAME
     FROM employee E , DEPT D
     WHERE E.SAL>4000 AND
     D.DEPTNO=E.DEPTNO


-- Find the department with the largest number of employees. Show DNAME, DEPTNO, and the number of employees.
SELECT d.DEPTNO, d.DNAME, count(e.EMPNO) AS EMPT_COUNT FROM DEPT d inner join employee e on d.DEPTNO = e.DEPTNO
     group by d.DEPTNO, d. DNAME order by EMPT_COUNT
     DESC limit 1;


-- Create a view MANAGERS for employees who manage other employees. Include all EMP columns.
Where MGRNO
CREATE VIEW MANAGERS AS
SELECT Manager.EMPNO AS MAGRNO ,Manager.ENAME as Manager_Name,Manager.JOB, emp.ENAME as Emp_Name ,Manager.HIREDATE,Manager.SAL,Manager.COMM,Manager.DEPTNO FROM employee AS emp, employee AS Manager
           WHERE emp.MGRNO = Manager.EMPNO
         ORDER BY Manager.ENAME, emp.ENAME;
CREATE VIEW MANAGERS AS
SELECT EMPNO,ENAME,JOB,MGRNO,HIREDATE,SAL,COMM,DEPTNO
FROM employee
IS NOT NULL