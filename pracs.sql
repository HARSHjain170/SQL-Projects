Create database Course;
use Course;

Create TABLE faculties(
    id int AUTO_INCREMENT PRIMARY key,
    FullName VARCHAR(100) NOT NULL,
    dateofjoining DATE NOT NULL,
    ExperienceInYears int NOT null
);
Create TABLE Subjects(
    id int AUTO_INCREMENT PRIMARY key,
    Name_ VARCHAR(100) NOT NULL,
    Course_ VARCHAR(100) not null,
    Semester int Not NULL
);

Create TABLE TimeTable(
    id int AUTO_INCREMENT PRIMARY key
    FacultyId int,
    SubjectId int,
    LectureDateTime DATETIME not null,
    FOREIGN key (FacultyId) REFERENCES faculties(id),
    FOREIGN key (SubjectId) REFERENCES Subjects(id)
);

INSERT INTO faculties (FullName,dateofjoining,ExperienceInYears) VALUES
('Dr.prerna Agrawal','2015-09-29',9),
('Dr.Sneha Iyer','2015-09-01',6);

INSERT INTO Subjects(Name_,Course_,Semester) VALUES
('JAVA','MCA',1),
('.NET','BCA',3);

INSERT INTO TimeTable(FacultyId,SubjectId,LectureDateTime)VALUES
(1,1,'2025-10-10 10:00:00'),
(2,2,'2025-09-19 11:00:00');

-- 1
SELECT * FROM faculties where ExperienceInYears > 5;

-- 2
select * from Subjects where Course = 'mca' and Semester = 2;

---3 
select f.FullName,s.Name_ from faculties f join TimeTable t on f.id = t.FacultyId join Subjects s on s.id = t.SubjectId;

-- 4
select f.FullName , count(t.id) as total_lectures from faculties f left join TimeTable t on f.id =t.FacultyId group by f.FullName;

-- 5
select FullName from faculties where ExperienceInYears =(select max(ExperienceInYears) from faculties);

-- 6
select * from Subjects where id not in (select SubjectId from TimeTable);

-- 7    
select  count(t.id) as lec  from TimeTable t join Subjects s on t.SubjectId = s.id where s.Name_ = 'java';
--8
select AVG(ExperienceInYears) as avg_exp from faculties;
-- 9 Create a view that displays the following details for all scheduled
-- lectures: Faculty Name, Subject Name, Course, and LectureDateTime
create view lecdetails as
select f.FullName as facultyname 
s.Name_ as subject_name 
s.Course_ as Course 
t.LectureDateTime as LectureDateTime
from TimeTable t join Subjects s 
on t.SubjectId = s.id 
join t.FacultyId =f.id ;

select * from lecdetails;

