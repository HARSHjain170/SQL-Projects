CREATE TABLE Faculties (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    DateOfJoining DATE NOT NULL,
    ExperienceInYears INT CHECK (ExperienceInYears >= 0)
);

CREATE TABLE Subjects (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name_ VARCHAR(100) NOT NULL,
    Course VARCHAR(100) NOT NULL,
    Semester INT NOT NULL
);
CREATE TABLE TimeTable (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    FacultyId INT NOT NULL,
    SubjectId INT NOT NULL,
    LactureDateTime DATETIME NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id),
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id)
);
INSERT INTO Faculties (FullName, DateOfJoining, ExperienceInYears) VALUES
('Dr. Amit Sharma', '2015-06-01', 9),
('Prof. Neha Patel', '2018-07-15', 6),
('Dr. Rahul Mehta', '2020-01-10', 4),
('Prof. Sneha Iyer', '2014-03-20', 11),
('Dr. Karan Verma', '2019-08-05', 5);

INSERT INTO Subjects (Name_, Course, Semester) VALUES
('Java', 'MCA', 2),
('DBMS', 'MCA', 2),
('Python', 'MCA', 1),
('Operating Systems', 'MCA', 3),
('Web Technologies', 'BCA', 4);

INSERT INTO TimeTable (FacultyId, SubjectId, LactureDateTime) VALUES
(1, 1, '2025-01-10 10:00:00'),
(1, 2, '2025-01-11 11:00:00'),
(2, 1, '2025-01-12 09:00:00'),
(4, 4, '2025-01-13 12:00:00'),
(2, 2, '2025-01-14 10:30:00');



-- 2
select * from Faculties where ExperienceInYears >5;
+----+------------------+---------------+-------------------+
| Id | FullName         | DateOfJoining | ExperienceInYears |
+----+------------------+---------------+-------------------+
|  1 | Dr. Amit Sharma  | 2015-06-01    |                 9 |
|  2 | Prof. Neha Patel | 2018-07-15    |                 6 |
|  4 | Prof. Sneha Iyer | 2014-03-20    |                11 |
+----+------------------+---------------+-------------------+
3 rows in set (0.00 sec)
-- 3
select * from Subjects where Course='MCA' and Semester=2;
+----+-------+--------+----------+
| Id | Name_ | Course | Semester |
+----+-------+--------+----------+
|  1 | Java  | MCA    |        2 |
|  2 | DBMS  | MCA    |        2 |
+----+-------+--------+----------+
2 rows in set (0.00 sec)
-- 4
select f.FullName,s.Name_ 
from Faculties f join TimeTable t on f.Id=t.FacultyId 
join Subjects s on s.Id=t.SubjectId;

+------------------+-------------------+
| FullName         | Name_             |
+------------------+-------------------+
| Dr. Amit Sharma  | Java              |
| Dr. Amit Sharma  | DBMS              |
| Prof. Neha Patel | Java              |
| Prof. Neha Patel | DBMS              |
| Prof. Sneha Iyer | Operating Systems |
+------------------+-------------------+

--5 
select f.FullName,count(t.Id) as counted_lec from Faculties f left join TimeTable t on t.FacultyId = f.Id group by f.FullName;
select f.FullName ,count(t.Id) as total_lectures from faculties f left join TimeTable t on f.id =t.FacultyId group by f.FullName;
+------------------+-------------+
| FullName         | counted_lec |
+------------------+-------------+
| Dr. Amit Sharma  |           2 |
| Prof. Neha Patel |           2 |
| Dr. Rahul Mehta  |           0 |
| Prof. Sneha Iyer |           1 |
| Dr. Karan Verma  |           0 |
+------------------+-------------+
5 rows in set (0.00 sec)

--6
select FullName from Faculties where ExperienceInYears = (select max(ExperienceInYears) from Faculties);
+------------------+
| FullName         |
+------------------+
| Prof. Sneha Iyer |
+------------------+
1 row in set (0.01 sec)
-- 7 List all Subjects that are not yet assigned to any faculty in the TimeTable
select * from Subjects where Id not in (select SubjectId from TimeTable);
+----+------------------+--------+----------+
| Id | Name_            | Course | Semester |
+----+------------------+--------+----------+
|  3 | Python           | MCA    |        1 |
|  5 | Web Technologies | BCA    |        4 |
+----+------------------+--------+----------+
2 rows in set (0.01 sec)
-- 8 Count the total number of lectures scheduled for the subject "Java".
SELECT COUNT(t.Id) AS total_lectures FROM TimeTable t JOIN Subjects s ON t.SubjectId = s.Id WHERE s.Name_ = 'Java';
SELECT COUNT(Id) AS total_lectures 
FROM TimeTable 
WHERE SubjectId = (SELECT Id FROM Subjects WHERE Name_ = 'Java')
+-----------------+
| count(SubjectId) |
+-----------------+
|               2 |
+-----------------+
-- 9 Find the average years of experience of all faculties in the database.
SELECT AVG(ExperienceInYears) AS average_experience FROM Faculties;
+--------------------+
| average_experience |
+--------------------+
|             7.0000 |
+--------------------+
1 row in set (0.00 sec)
-- 10 Create a view that displays the following details for all scheduled
-- lectures: Faculty Name, Subject Name, Course, and LectureDateTime.
create view lecdetails as 
select f.FullName as facultyname,
s.Name_ as subject_name,
s.Course,
t.LactureDateTime 
from TimeTable t join faculties f on t.FacultyId = f.id join Subjects s on s.id = t.SubjectId;
 select * from lecdetails;
+------------------+-------------------+--------+---------------------+
| facultyname      | subject_name      | Course | LactureDateTime     |
+------------------+-------------------+--------+---------------------+
| Dr. Amit Sharma  | Java              | MCA    | 2025-01-10 10:00:00 |
| Dr. Amit Sharma  | DBMS              | MCA    | 2025-01-11 11:00:00 |
| Prof. Neha Patel | Java              | MCA    | 2025-01-12 09:00:00 |
| Prof. Sneha Iyer | Operating Systems | MCA    | 2025-01-13 12:00:00 |
| Prof. Neha Patel | DBMS              | MCA    | 2025-01-14 10:30:00 |
+------------------+-------------------+--------+---------------------+
5 rows in set (0.01 sec)