create table voter_master(
    voter_id int primary key AUTO_INCREMENT,
    voter_Name varchar(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    age VARCHAR(10) NOT NULL,
    city varchar(100) NOT NULL,
    registration_date DATE NOT NULL
);
create table vote_master(
    vote_id int primary key AUTO_INCREMENT,
    Voter_id int,
    candidate_Name varchar(100) NOT NULL,
    party_Name VARCHAR(100) NOT NULL,
    voting_date DATE NOT NULL,
    booth_location varchar(100) NOT NULL,
    FOREIGN key (voter_id) REFERENCES voter_master(voter_id)
);
insert  into voter_master(voter_Name,gender,age,city,registration_date) VALUES
('Amit Sharma', 'Male', 28, 'Delhi', '2024-01-15'),
('Neha Verma', 'Female', 34, 'Mumbai', '2023-11-10'),
('Rahul Singh', 'Male', 22, 'Jaipur', '2024-03-05'),
('Priya Patel', 'Female', 41, 'Ahmedabad', '2022-08-20'),
('Karan Mehta', 'Male', 30, 'Pune', '2023-06-12');
insert into vote_master(Voter_id,candidate_Name,party_Name,voting_date,booth_location) VALUES
(1, 'Rahul Kumar', 'Indian National Congress', '2024-04-19', 'Delhi North'),
(2, 'Anita Desai', 'Bharatiya Janata Party', '2024-04-19', 'Mumbai Central'),
(3, 'Suresh Yadav', 'Aam Aadmi Party', '2024-04-20', 'Jaipur East'),
(4, 'Pooja Mehta', 'Bharatiya Janata Party', '2024-04-20', 'Ahmedabad West'),
(5, 'Vikram Singh', 'Indian National Congress', '2024-04-21', 'Pune City');

--1 
SELECT * from voter_master order by voter_Name desc;

--2 
update vote_master set booth_location='mumbai central' WHERE candidate_Name ='Rahul Kumar';
--3 
select * from voter_master where voter_Name like 'A_________a';
--4
select party_Name,count(vote_id)as counted_voting from vote_master group by party_Name;
--5
select * from voter_master where city not in ('mumbai','delhi');
-- 6 
alter table vote_master add voting_time time;
-- 7 
select W.vote_id,v.voter_Name  from voter_master v join vote_master w on v.voter_id = w.Voter_id;
-- 8
select * from vote_master WHERE voting_date < '2024-04-20';
-- 9
create view voter as 
select * from voter_master where gender='female';
select * from voter;
--10
select * from vote_master where party_Name ='Indian National Congress';
