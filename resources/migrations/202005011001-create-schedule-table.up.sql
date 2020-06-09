CREATE TABLE schedule(
  scheduleid int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  userid int(11) NOT NULL DEFAULT 0,
  helpeeid int(11) NOT NULL DEFAULT 0,
  fromdate date,
  todate date,
  city varchar(50),
  district varchar(50),
  service varchar(50)
);
--;;
insert  into schedule(scheduleid,userid,helpeeid,fromdate,todate,city,district,service) values
(1,1,2,'2019-07-05.','2019-07-06.','London','South','Groceries'),
(2,6,2,'2019-07-06.','2019-07-07.','Paris','North','Walking the dog'),
(3,1,0,'2019-07-25.','2019-07-27.','Brussels','East','Cutting the grass'),
(4,0,6,'2019-07-10.','2019-07-11.','Amsterdam','West','Cleaning'),
(5,0,5,'2019-07-12.','2019-07-15.','Berlin','NorthEast','Walking'),
(6,6,0,'2019-07-12.','2019-07-15.','Rome','West','Groceries');
