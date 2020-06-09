CREATE TABLE user(
  userid int(11) NOT NULL AUTO_INCREMENT,
  firstname varchar(50) NOT NULL,
  lastname varchar(50) NOT NULL,
  username varchar(50) NOT NULL,
  password varchar(50) NOT NULL,
  email varchar(50) NOT NULL,
  role varchar(10) NOT NULL,
  picture varchar(50) NOT NULL,
  PRIMARY KEY (userid)
);
--;;
insert into user(userid,firstname,lastname,username,password,email,role,picture) values
(1,'John','Smith','john','123','johnsmith@gmail.com','admin','profile1.png'),
(2,'George','Martin','george','123','georgemartin@gmail.com','user','profile2.png'),
(3,'Thomas','Lucas','thomas','123','tomluc@gmail.com','user','profile3.png'),
(4,'Abigail','Smith','abigail','123','abigail@gmail.com','user','profile4.png'),
(5,'Bruce','Lompart','bruce','123','bruce@gmail.com','user','profile5.png'),
(6,'User','User','user','user','user@gmail.com','user','profile1.png'),
(7,'Admin','Admin','admin','admin','admin@gmail.com','admin','profile1.png');
