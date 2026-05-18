create table faculties(
    F_id int primary key AUTO_INCREMENT,
    FullName VARCHAR(50) NOT NULL,
    DateOfJoining DATE NOT NULL,
    ExperienceInYears int NOT NULL
);
create table Subjects(
    S_id int primary key AUTO_INCREMENT,
    Name_ VARCHAR(50) NOT NULL,
    course VARCHAR(15) NOT NULL,
    Semester int NOT NULL
);

create table TimeTable(
    T_id int primary key AUTO_INCREMENT,
    faculty_id int NOT NULL,
    Subject_Id int not NULL,
    lec_d_T DATETIME NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES  faculties(F_id),
    foreign key (Subject_Id) REFERENCES Subjects(S_id)
);

insert into faculties(FullName,DateOfJoining,ExperienceInYears) VALUES
('Dr. Amit Sharma', '2015-06-01', 9),
('Prof. Neha Patel', '2018-07-15', 6),
('Dr. Rahul Mehta', '2020-01-10', 4),
('Prof. Sneha Iyer', '2014-03-20', 11),
('Dr. Karan Verma', '2019-08-05', 5);

INSERT INTO Subjects(Name_,course,Semester) VALUES
('Java', 'MCA', 2),
('DBMS', 'MCA', 2),
('Python', 'MCA', 1),
('Operating Systems', 'MCA', 3),
('Web Technologies', 'BCA', 4);
INSERT INTO TimeTable(faculty_id,Subject_Id,lec_d_T) VALUES
(1, 1, '2025-01-10 10:00:00'),
(1, 2, '2025-01-11 11:00:00'),
(2, 1, '2025-01-12 09:00:00'),
(4, 4, '2025-01-13 12:00:00'),
(2, 2, '2025-01-14 10:30:00');

-- 1
SELECT * from faculties WHERE ExperienceInYears > 5;
-- done
--2 
select * from Subjects where Course = 'MCA' and Semester = 2;
-- done 
--3 
select f.FullName ,s.Name_ 
from faculties f JOIN TimeTable t
 on f.F_id = t.faculty_id 
 JOIN Subjects s on s.S_id = t.Subject_Id;
 -- 4 
SELECT f.FullName , count(lec_d_T) as counting lecture  FROM faculties f left join TimeTable t  on f.F_id = t.faculty_id  group by  f.FullName; 

 -- 5
 SELECT FullName FROM faculties WHERE ExperienceInYears = (SELECT max(ExperienceInYears) from faculties);
-- done
 -- 6 
 select Name_ from Subjects where S_id not in (SELECT Subject_Id from TimeTable);
-- done
-- 7 
SELECT count(S_id) as total_lectures from Subjects s JOIN  TimeTable t ON s.S_id = t.Subject_Id where s.Name_ = 'JAVA'; 
-- done 
-- 8
SELECT avg(ExperienceInYears) as average_experience FROM faculties;
--done
--9
create view scheduled as 
select f.FullName ,s.Name_,s.course, t.lec_d_T FROM TimeTable t JOIN faculties f on t.faculty_id = f.F_id join Subjects s on s.S_id = t.Subject_Id ; 
SELECT * FROM scheduled;