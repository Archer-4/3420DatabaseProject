-- CLIENT --
INSERT INTO client (ClientID,name,address,Phone) VALUES 
(1,'Ogle','8018 Sachs Lane','627-690-4132'),
(2,'Grosvenor','14 Memorial Place','926-343-5481'),
(3,'Espinola','638 Stang Junction','784-219-6469'),
(4,'Klaas','24855 Lakewood Terrace','977-896-4852'),
(5,'Cutridge','59 Carberry Junction','379-454-4020'),
(6,'Landy','983 Prairieview Place','588-931-8658'),
(7,'Thirsk','20 Towne Way','804-980-7201'),
(8,'Reimer','586 Golf Point','620-232-8011'),
(9,'Wahncke','917 Oxford Parkway','392-260-0175'),
(10,'Rosser','505 Continental Point','287-103-5208'),
(11,'Otto','016 Fair Oaks Plaza','543-837-7330'),
(12,'Softley','708 Karstens Place','569-191-3898'),
(13,'Booty','964 Lotheville Plaza','544-218-2251'),
(14,'Laban','1 Blackbird Pass','317-681-2131'),
(15,'Le Guin','581 6th Lane','106-539-3500'),
(16,'Tunder','80978 Del Sol Way','728-338-3598'),
(17,'MacLice','7937 Ronald Regan Center','714-147-3709'),
(18,'Hamberstone','20 Spohn Court','347-221-3131'),
(19,'McGonnell','815 Meadow Valley Pass','556-834-2812'),
(20,E'D\'Angeli','7 Becker Circle','177-228-0927');

-- CROPS --
INSERT INTO CROPS (CropID,cropType,Name,Amount) VALUES 
(1,'Vegetable','Carrot',895),
(2,'Vegetable','Corn',4300),
(3,'Nut','Pistachio',1135),
(4,'Nut','Almond',1159),
(5,'Fruit','Strawberry',499),
(6,'Fruit','Grape',1646),
(7,'Grain','Wheat',921),
(8,'Fruit','Tomato',1890),
(9,'Vegetable','Spinach',502),
(10,'Vegetable','Broccoli',1408),
(11,'Vegetable','Lettuce',71);

-- EMPLOYEES --
INSERT INTO employees (EmployeeID, ClientID, name, Phone, EmploymentStatus, Salary) VALUES
(1, 1, 'Pringell', '704-265-4575', 'Office Assistant I', 112931),
(2, 1, 'Toppin', '684-718-2582', 'Software Consultant', 50227),
(3, 1, 'Durman', '595-932-7972', 'Human Resources Manager', 50392),
(4, 1, 'Loker', '378-884-7214', 'Analog Circuit Design Manager', 60723),
(5, 1, 'Dartnall', '420-158-1899', 'Analyst Programmer', 133337),
(6, 1, 'Hurich', '816-413-5218', 'VP Quality Control', 131983),
(7, 1, 'Logsdail', '322-102-0217', 'Accounting Assistant I', 74941),
(8, 1, 'Gonin', '242-318-8383', 'Safety Technician IV', 155305),
(9, 1, 'Friedank', '812-722-6036', 'Mechanical Systems Engineer', 57639),
(10, 1, 'Wannell', '283-276-9150', 'Structural Analysis Engineer', 107481),
(11, 2, 'Lattimore', '858-974-7830', 'Teacher', 135289),
(12, 2, 'Knapper', '742-617-3137', 'Desktop Support Technician', 88140),
(13, 3, 'Hallor', '497-463-2914', 'Compensation Analyst', 183641),
(14, 4, 'Salery', '731-734-6116', 'Systems Administrator II', 157722),
(15, 4, 'Anthoine', '724-358-6102', 'Financial Analyst', 73168),
(16, 4, 'O''Crevan', '622-412-4752', 'Physical Therapy Assistant', 108541),
(17, 4, 'Woolbrook', '172-946-4606', 'Systems Administrator III', 78837),
(18, 4, 'Degoix', '262-542-2006', 'Assistant Professor', 127801),
(19, 4, 'Adess', '817-821-1441', 'Financial Advisor', 150208),
(20, 5, 'Redholls', '927-810-9644', 'Developer IV', 191720),
(21, 5, 'Yates', '299-149-2457', 'Accountaint I', 156976),
(22, 5, 'Broadley', '270-623-4451', 'Staff Scientist', 94392),
(23, 5, 'Ianilli', '361-387-0632', 'Senior Financial Analyst', 182972),
(24, 5, 'Ure', '210-642-9989', 'Librarian', 80075),
(25, 6, 'Malitrott', '209-620-2042', 'Junior Executive', 150967),
(26, 7, 'Yoseloff', '962-909-0698', 'Automation Specialist III', 177180),
(27, 7, 'Arnholdt', '301-273-3478', 'Budget/Accounting Analyst II', 183687),
(28, 8, 'Alps', '901-607-7414', 'Statistician II', 67379),
(29, 9, 'Sprasen', '630-233-9915', 'Quality Engineer', 54432),
(30, 10, 'Sylvester', '114-704-9652', 'Health Coach IV', 71401),
(31, 12, 'Padmore', '516-429-2190', 'Help Desk Operator', 157715),
(32, 12, 'Benes', '157-725-4946', 'Software Consultant', 143112),
(33, 13, 'Bleacher', '724-485-4650', 'General Manager', 180491),
(34, 13, 'Dury', '895-551-2998', 'Speech Pathologist', 55739),
(35, 13, 'Hens', '377-622-4216', 'Technical Writer', 62109),
(36, 13, 'Giraudot', '160-535-0825', 'Editor', 110210),
(37, 14, 'Vedeniktov', '171-506-2369', 'Clinical Specialist', 197459),
(38, 14, 'Bernhardi', '197-320-2802', 'Assistant Media Planner', 144271),
(39, 14, 'MacCollom', '525-414-5955', 'Librarian', 149405),
(40, 15, 'Grishankov', '964-993-4720', 'Help Desk Operator', 140741),
(41, 15, 'Crookshanks', '534-450-5432', 'Chief Design Engineer', 117338),
(42, 15, 'Dodgson', '887-822-4162', 'Business Systems Development Analyst', 92718),
(43, 16, 'Maginot', '160-693-3997', 'Accountaint IV', 184829),
(44, 17, 'Coneley', '363-387-6456', 'Developer III', 195040),
(45, 18, 'Buff', '905-166-1346', 'Accountant Assistant IV', 185153),
(46, 18, 'Jersh', '732-947-1152', 'Teacher', 108489),
(47, 19, 'Burder', '696-415-0811', 'Structural Analysis Engineer', 121225),
(48, 20, 'Jiruch', '661-466-9039', 'VP Quality Control', 170745),
(49, 20, 'Blick', '917-709-7538', 'Chemical Engineer', 154451),
(50, 13, 'Giacobazzi', '877-991-9020', 'Chemical Engineer', 97112),
(51, 12, 'Headley', '371-659-3495', 'Accountant I', 51770),
(52, 14, 'Stang-Gjertson', '534-578-7994', 'Cost Accountaint', 49026),
(53, 17, 'Meriton', '642-129-9755', 'Research Associate', 132357),
(54, 9, 'LeLouche', '704-945-8756', 'Ruler of the World', 999999),
(55, 3, 'O''Currine', '258-790-4222', 'Senior Sales Associate', 62951),
(56, 4, 'Have', '179-865-7614', 'Senior Editor', 49174),
(57, 8, 'Tezure', '975-700-6389', 'Structural Analysis Egnineer', 45146),
(58, 11, 'Iacolvo', '361-135-7530', 'Web Developer II', 49853),
(59, 15, 'Zoomback', '389-873-8030', 'Actuary', 150710),
(60, 6, 'Lakenden', '162-259-6999', 'Engineer II', 141294);





-- FIELD INFO --
INSERT INTO  field_info (FieldID,ClientID,Acreage,CropID) VALUES 
(1,12,289,1),
(2,5,615,2),
(3,5,820,3),
(4,7,817,4),
(5,9,410,5),
(6,10,268,6),
(7,9,916,7),
(8,10,708,8),
(9,12,409,9),
(10,11,532,10),
(11,18,967,11),
(12,14,660,1),
(13,19,839,1),
(14,17,607,2),
(15,20,168,3),
(16,6,437,4),
(17,20,400,5),
(18,16,865,6),
(19,2,784,5),
(20,3,566,4);

-- INVENTORY --
INSERT INTO Inventory (StockID,ClientID,Name,Category,Amount) VALUES 
(1,1,'Cut_grass','Feed',6546),
(2,2,'Corn','Feed',7002),
(3,3,'Hay','Feed',2133),
(4,4,'Wheat','Feed',3445),
(5,5,'Cereal_grains','Feed',4192),
(6,6,'Tractors','Equipment',4),
(7,7,'Hoses','Equipment',100),
(8,8,'Cutters','Equipment',45),
(9,9,'Harvesters','Equipment',40),
(10,10,'Mowers','Equipment',35);

-- LIVESTOCK --
INSERT INTO livestock(SpeciesID,ClientID,Species,Food,Feed_Levels) VALUES
(1,7,'Cow','Grasses','good'),
(2,8,'Pig','Corn','good'),
(3,3,'Chicken','Grains','good'),
(4,5,'Horse','Hay','good'),
(5,7,'Sheep','Grasses','low');

-- OUTGOING DELIVERIES --
INSERT INTO outgoingdeliveries (Out_DeliveryID,ClientID,DeliveryDate,Expected_Profit,Recipient) VALUES 
(1,19,'2021-02-21',1137,'Quatz'),
(2,12,'2021-02-21',136,'Twitternation'),
(3,3,'2020-01-28',948,'Blogpad'),
(4,2,'2020-07-27',1566,'Trunyx'),
(5,14,'2020-11-11',1972,'Kazio'),
(6,15,'2021-03-16',112,'Innojam'),
(7,2,'2019-12-29',1058,'Quatz'),
(8,14,'2020-10-20',634,'InnoZ'),
(9,13,'2020-12-11',512,'Shufflebeat'),
(10,10,'2020-12-07',1523,'Fiveclub'),
(11,18,'2020-04-04',409,'Photospace'),
(12,12,'2019-10-28',189,'Riffpath'),
(13,9,'2020-06-25',1569,'Gabtype'),
(14,2,'2020-05-23',800,'Rooxo'),
(15,6,'2019-11-21',1497,'Wordify'),
(16,8,'2020-08-07',458,'Jabbertype'),
(17,3,'2019-11-18',439,'Brainverse'),
(18,20,'2020-07-19',746,'Jabberstorm'),
(19,13,'2020-08-10',1087,'Devify'),
(20,1,'2020-12-19',986,'Zoombox');


-- EQUIPMENT --
INSERT INTO Equipment (EquipmentNumber,EquipmentType, Fuel,Status,Brand,FieldID) VALUES 
(1,'Town Car','Diesel','Good','BMW',1),
(2,'Irigation System','Electric','Good','Pontiac',2),
(3,'SUV','Petrol','Good','Mazda',3),
(4,'Toyota Hilux','Diesel','Good','Toyota',4),
(5,'DUKW Vehicle','Diesel','Good','GMC',6),
(6,'Cow-Milker','Electric','Good','Pontiac',6),
(7,'ATV','Diesel','Needs Repair','Mitsubishi',7),
(8,'Das Gutenmahdrescher','Electric','Good','Volkswagen',7),
(9,'M60A1 MBT','Diesel','Good','Chrysler',8),
(10,'Lift','Electric','Good','Mazda',8),
(11,'TV-8','Electric','Good','Chrysler',9),
(12,'A ferrari? Why does a farm have a Ferrari?','Electric','Good','Ferrari',10),
(13,'Cow Milker','Electric','Good','Pontiac',10),
(14,'Leisure Vehicle','Electric','Good','Nissan',11),
(15,'Combine Harvester','Diesel','Good','Toyota',12),
(16,'Tractor','Petrol','Good','Volkswagen',13),
(17,'Tractor','Petrol','Good','Mercury',15),
(18,'Follow Truck','Diesel','Good','Chrysler',16),
(19,'Combine Harvester','Diesel','Good','Scion',17),
(20,'Transport Car','Electric','Good','Ford',18);

-- GROWING -- 
INSERT INTO Growing (CropID, FieldID) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 8),
(2, 9),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(4, 16),
(5, 13),
(5, 14),
(5, 15),
(6, 14),
(6, 18),
(7, 19),
(7, 1),
(8, 1),
(6, 3),
(9, 12),
(10, 11),
(11,12),
(11,13),
(11, 14),
(11, 15);

-- LIVESTOCK OWNERSHIP --
--Had to change "StockID" to "SpeciesID"
--insert into LSOwnership (SpeciesID, clientID) values (1, 1);
--insert into LSOwnership (SpeciesID, clientID) values (2, 2);
--insert into LSOwnership (SpeciesID, clientID) values (3, 3);
--insert into LSOwnership (SpeciesID, clientID) values (4, 4);
--insert into LSOwnership (SpeciesID, clientID) values (5, 5);
--insert into LSOwnership (SpeciesID, clientID) values (1, 6);
--insert into LSOwnership (SpeciesID, clientID) values (2, 7);
--insert into LSOwnership (SpeciesID, clientID) values (3, 8);
--insert into LSOwnership (SpeciesID, clientID) values (4, 9);
--insert into LSOwnership (SpeciesID, clientID) values (5, 10);
--insert into LSOwnership (SpeciesID, clientID) values (1, 11);
--insert into LSOwnership (SpeciesID, clientID) values (2, 12);
--insert into LSOwnership (SpeciesID, clientID) values (3, 13);
--insert into LSOwnership (SpeciesID, clientID) values (4, 14);
--insert into LSOwnership (SpeciesID, clientID) values (5, 15);
--insert into LSOwnership (SpeciesID, clientID) values (1, 16);
--insert into LSOwnership (SpeciesID, clientID) values (2, 17);
--insert into LSOwnership (SpeciesID, clientID) values (3, 18);
--insert into LSOwnership (SpeciesID, clientID) values (4, 19);
--insert into LSOwnership (SpeciesID, clientID) values (5, 20);
--insert into LSOwnership (SpeciesID, clientID) values (1, 2);
--insert into LSOwnership (SpeciesID, clientID) values (3, 4);
--insert into LSOwnership (SpeciesID, clientID) values (5, 4);
--insert into LSOwnership (SpeciesID, clientID) values (5, 6);
--insert into LSOwnership (SpeciesID, clientID) values (4, 19); Removed for repeat value
--insert into LSOwnership (SpeciesID, clientID) values (5, 18);
--insert into LSOwnership (SpeciesID, clientID) values (3, 14);
--insert into LSOwnership (SpeciesID, clientID) values (2, 4);
--insert into LSOwnership (SpeciesID, clientID) values (5, 13);
--insert into LSOwnership (SpeciesID, clientID) values (3, 12);

--INCOMING DELIVERIES --
INSERT INTO IncomingDeliveries (In_DeliveryID,ClientID,DeliveryDate,Stock_levels,Supplier) VALUES 
(1,2, '2020-10-28', 888, 'Fiveclub'),
(2,3, '2020-04-09', 1437, 'Youspan'),
(3,4, '2020-11-23', 608, 'Skiba'),
(4,5, '2019-10-18', 1087, 'Youfeed'),
(5,6, '2019-11-21', 412, 'Skilith'),
(6,7, '2020-05-21', 1637, 'Twitterbridge'),
(7,8, '2021-02-02', 883, 'Plambee'),
(8,9, '2020-09-23', 998, 'Voomm'),
(9,10, '2020-02-24', 287, 'Camido'),
(10,11, '2020-11-12', 416, 'Abatz'),
(11,12, '2020-09-15', 323, 'Tagopia'),
(12,13, '2020-10-02', 455, 'Innojam'),
(13,14, '2021-01-13', 1884, 'Voonder'),
(14,15, '2020-09-12', 295, 'Yambee'),
(15,16, '2021-01-05', 1381, 'Twinte'),
(16,17, '2020-03-31', 1882, 'Tazzy'),
(17,18, '2020-11-07', 1616, 'Thoughtbeat'),
(18,19, '2020-07-17', 687, 'Jabbersphere'),
(19,20, '2021-01-15', 209, 'Tazz'),
(20,1, '2020-03-26', 937, 'Viva');
