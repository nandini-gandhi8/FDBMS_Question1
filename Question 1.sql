create database movieticketsystem;
use movieticketsystem;

create table place
(
 place_id int(4) PRIMARY KEY,
 place_name varchar(30) NOT NULL,
 place_state varchar(20) 
);

insert into place values( 110, 'Vasant Kunj', 'New Delhi' );
insert into place values( 111, 'Saket', 'New Delhi' );
insert into place values( 112, 'Gurgaon', 'Haryana' );
insert into place values( 113, 'Noida', 'Uttar Pradesh' );
insert into place values( 114, 'Faridabad', 'Haryana' );
insert into place values( 115, 'Greater Noida', 'UP');

Start transaction;

insert into place values( 116, 'Ghaziabad', 'UP');
insert into place values( 117, 'Vasant Vihar', 'New Delhi');

SAVEPOINT placedata;

create table theater
(
 theater_id int(4) PRIMARY KEY,
 theater_name varchar(20) NOT NULL,
 theater_location VARCHAR(30) NOT NULL,
 theater_screen int(2) CHECK (theater_screen >=1),
 place_id int(4),
 FOREIGN KEY (place_id) REFERENCES place(place_id)
);

insert into theater values( 310, 'PVR Sahara', 'New Delhi', 4, 110 );
insert into theater values( 311, 'Carnival Cinemas', 'New Delhi', 6, 111 );
insert into theater values( 312, 'INOX Dreamz', 'Haryana', 2, 112 );
insert into theater values( 313, 'PVR Cinemas', 'Uttar Pradesh', 3, 113 );
insert into theater values( 314, 'SRS Cinemas', 'Haryana', 2, 114 );


create table screen
(
 screen_id int(2) PRIMARY KEY,
 screen_seats int(3) NOT NULL CHECK (screen_seats >= 1),
 tiers ENUM('Executive', 'Premium', 'Arena'),
 theater_id int(4),
 FOREIGN KEY (theater_id) REFERENCES theater(theater_id)
);

insert into screen values (510, 40, 'Executive', 310);
insert into screen values (511, 80, 'Premium', 311);
insert into screen values (512, 40, 'Executive', 312);
insert into screen values (513, 30, 'Arena', 313);
insert into screen values (514, 80, 'Premium', 314);


create table user
(
 user_id INT(8) PRIMARY KEY,
 user_fname varchar(255),
 user_lname varchar(255),
 user_mobile char(10) NOT NULL UNIQUE,
 user_email  varchar(255) NOT NULL UNIQUE
);

insert into user values (710, 'Virat', 'Kohli', 8588022525, 'viratkohli@gmail.com');
insert into user values (711, 'Rahul', 'Dravid', 9711474723, 'rahul@gmail.com');
insert into user values (712, 'Mahender', 'Singh', 9650897823, 'singhmahen@gmail.com');
insert into user values (713, 'Anurag', 'Thakur', 7857234352, 'anuragthakur@gmail.com');
insert into user values (714, 'Pankaj', 'Singh', 7239834244, 'pankajsingh@gmail.com');


create table payment
(
 payment_id INT(8) PRIMARY KEY,
 payment_amount decimal(10,2),
 payment_date DATE,
 payment_time TIME,
 user_id INT(8),
 FOREIGN KEY (user_id) REFERENCES user(user_id)
);


insert into payment values (800020, 1200, '2022-02-10', '12:40:10', 710);
insert into payment values (800021, 1030, '2022-02-15', '01:21:34', 711);
insert into payment values (800022, 1700, '2022-02-27', '14:23:23', 712);
insert into payment values (800023, 1050, '2022-03-02', '12:03:01', 713);
insert into payment values (800024, 1650, '2022-03-11', '11:02:10', 714);


create table ticket
(
 ticket_id INT(8) PRIMARY KEY,
 ticket_cost int(5),
 ticket_screenno int(2),
 FOREIGN KEY (ticket_screenno) REFERENCES screen(screen_id),
 ticket_seatno INT(3),
 ticket_showdate DATE,
 payment_id INT(8),
 FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

insert into ticket values (600021, 1200, 510, 21, '2022-02-11', 800020 );
insert into ticket values (600022, 1030, 511, 43, '2022-02-16', 800021 );
insert into ticket values (600023, 1700, 512, 32, '2022-02-27', 800022 );
insert into ticket values (600024, 1050, 513, 13, '2022-03-02', 800023 );
insert into ticket values (600025, 1650, 514, 34, '2022-03-12', 800024 );


create table movie
(
 movie_id int(5) PRIMARY KEY,
 movie_name varchar(50),
 movie_release_date DATE,
 movie_director varchar(50),
 movie_actor varchar(50),
 movie_languages varchar(255),
 screen_id int(2),
 FOREIGN KEY (screen_id) REFERENCES screen(screen_id)
);

insert into movie values( 910, 'The Batman', '2022-01-02', 'Matt Reeves', 'Ben Affleck', 'English, Hindi', 510 );
insert into movie values( 911, 'Morbius', '2022-01-15', 'Daniel Espinosa', 'Jared Leto', 'English, Hindi', 511 );
insert into movie values( 912, 'Atrangi Re', '2022-01-25', 'Aanand L. Rai', 'Dhanush', 'English, Hindi, Tamil', 512 );
insert into movie values( 913, 'Drishyam 2', '2022-02-24', 'Jeethu Joseph', 'Mohanlal', 'English, Hindi, Telugu', 513 );
insert into movie values( 914, 'Pushpa Raj', '2022-02-07', 'Sukumar', 'Allu Arjun', 'Tamil, Telugu', 514 );




CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin' ;
grant  select  on  *.*  to  'admin'@'localhost'  ;

CREATE USER 'movieissuer'@'localhost' IDENTIFIED BY 'movieissuer' ;
GRANT select, insert, update, delete   ON movieticketsystem.movie  TO 'movieissuer'@'localhost' ;

CREATE USER 'userlogin'@'localhost' IDENTIFIED BY 'userlogin' ;
GRANT select   ON movieticketsystem.ticket  TO 'userlogin'@'localhost' ;









