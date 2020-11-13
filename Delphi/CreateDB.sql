CREATE TABLE client (
  ClientID int primary key,
  name varchar(50) DEFAULT NULL,
  address varchar(50) DEFAULT NULL,
  Phone varchar(15) DEFAULT NULL
);
--Replaced "Type" with "CropType"
CREATE TABLE crops (
  CropID int primary key,
  CropType text DEFAULT NULL,
  Name text DEFAULT NULL,
  Amount int DEFAULT NULL
);

CREATE TABLE employees (
  EmployeeID int primary key,
  name varchar(20) DEFAULT NULL,
  Phone varchar(50) DEFAULT NULL,
  EmploymentStatus varchar(50) DEFAULT NULL,
  Salary int DEFAULT NULL
);

CREATE TABLE employed (
  ClientID int DEFAULT NULL,
  EmployeeID int DEFAULT NULL,
  primary key (ClientID, EmployeeID),
  foreign key (ClientID) references client,
  foreign key (EmployeeID) references employees
);

CREATE TABLE field_info (
  FieldID int primary key,
  Acreage int DEFAULT NULL,
  CropID int,
  foreign key (CropID) references crops
);

CREATE TABLE equipment (
  EquipmentNumber int primary key,
  Fuel varchar(8) DEFAULT NULL,
  Status varchar(50) DEFAULT NULL,
  Brand varchar(50) DEFAULT NULL,
  FieldID int,
  foreign key (FieldID) references field_info
);

CREATE TABLE field_ownership (
  FieldID int,
  ClientID int,
  primary key (FieldID, ClientID),
  foreign key (FieldID) references field_info,
  foreign key (ClientID) references client
);

CREATE TABLE growing (
  CropID int,
  FieldID int,
  primary key (CropID, FieldID),
  foreign key (CropId) references crops,
  foreign key (FieldID) references field_info
);

CREATE TABLE incomingdeliveries (
    In_DeliveryID int primary key,
    DeliveryDate date,
    Stock_levels int,
    Supplier varchar(30)
);

CREATE TABLE in_services (
    ClientID int,
    In_DeliveryID int,
    primary key (ClientID, In_DeliveryID),
    foreign key (ClientID) references client,
    foreign key (In_DeliveryID) references incomingdeliveries
);
--Had to change "Type" to "Category"
CREATE TABLE inventory (
  StockID int primary key,
  Name text DEFAULT NULL,
  Category text DEFAULT NULL,
  Amount int DEFAULT NULL
);

CREATE TABLE inv_ownership (
  StockID int,
  ClientID int,
  primary key (StockID, ClientID),
  foreign key (StockId) references inventory,
  foreign key (ClientId) references client
);

CREATE TABLE livestock (
  SpeciesID int primary key,
  Species varchar(25) DEFAULT NULL,
  Food varchar(25) DEFAULT NULL,
  Feed_Levels varchar(45) DEFAULT NULL
);

CREATE TABLE lsownership (
  SpeciesID int,
  clientID int,
  primary key (SpeciesID, clientID),
  foreign key (SpeciesID) references livestock,
  foreign key (clientID) references client
);

--Changed Date to DeliveryDate
CREATE TABLE outgoingdeliveries (
  Out_DeliveryID int primary key,
  DeliveryDate date DEFAULT NULL,
  Expected_Profit int DEFAULT NULL,
  Recipient varchar(50) DEFAULT NULL
);

CREATE TABLE out_services (
  ClientID int,
  Out_DeliveryID int,
  primary key (ClientID, Out_DeliveryID),
  foreign key (ClientID) references client,
  foreign key (Out_DeliveryID) references outgoingdeliveries
);












