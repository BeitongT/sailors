-- drop sailors table if you have already created sailor table 
SET foreign_key_checks = 0;
drop table if exists sailors cascade;
SET foreign_key_checks = 1;

--create three tables
create table sailors(
	sid numeric(9,0) primary key,
	sname varchar(30),
	rating numeric(2,0),
	age numeric(4,1)
	);
create table reserves(
	sid numeric(9,0),
	bid numeric(3,0),
	day varchar(30),
	primary key(sid,bid,day),
	foreign key(sid) references sailors(sid),
	foreign key(bid) references Boats(bid)
	);
create table Boats(
	bid numeric(3,0) primary key,
	bname varchar(10),
	color varchar(10)
	);


--add data into table
--*****************************************
--remember to change the file address
--*****************************************
LOAD DATA LOCAL INFILE 'sailors2.txt' INTO TABLE sailors
    FIELDS TERMINATED BY ',' ENCLOSED BY '"';
LOAD DATA LOCAL INFILE 'reserves.txt' INTO TABLE reserves
    FIELDS TERMINATED BY ',' ENCLOSED BY '"';
LOAD DATA LOCAL INFILE 'boat.txt' INTO TABLE Boats
    FIELDS TERMINATED BY ',' ENCLOSED BY '"';

--test code
--find sailors who have reserved boat 101
SELECT S.sname
FROM Sailors S
WHERE S.sid IN (SELECT R.sid
FROM Reserves R WHERE R.bid=101);

-- For each blue boat, find number of reservations for this boat
SELECT B.bid, COUNT(*) AS rcount FROM Boats B, Reserves R
WHERE R.bid=B.bid AND B.color='blue' GROUP BY B.bid;