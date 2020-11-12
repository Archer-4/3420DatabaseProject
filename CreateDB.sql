CREATE TABLE `client` (
  `ClientID` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `crops` (
  `CropID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` text DEFAULT NULL,
  `Name` text DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`CropID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `employed` (
  `ClientID` int(11) DEFAULT NULL,
  `EmployeeID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `Phone` varchar(50) DEFAULT NULL,
  `EmploymentStatus` varchar(50) DEFAULT NULL,
  `Salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `equipment` (
  `EquipmentNumber` int(11) NOT NULL AUTO_INCREMENT,
  `Fuel` varchar(8) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `FieldID` int(11) DEFAULT NULL,
  PRIMARY KEY (`EquipmentNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `field_info` (
  `FieldID` int(11) NOT NULL AUTO_INCREMENT,
  `Acreage` int(11) DEFAULT NULL,
  `CropID` int(11) DEFAULT NULL,
  PRIMARY KEY (`FieldID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `field_ownership` (
  `FieldID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `growing` (
  `CropID` int(11) DEFAULT NULL,
  `FieldID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `incomingdeliveries` (
  `ClientID` int(11) DEFAULT NULL,
  `In_DeliveryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `inv_ownership` (
  `StockID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `inventory` (
  `StockID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `Type` text DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`StockID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `livestock` (
  `SpeciesID` int(11) NOT NULL AUTO_INCREMENT,
  `Species` varchar(25) DEFAULT NULL,
  `Food` varchar(25) DEFAULT NULL,
  `Feed_Levels` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SpeciesID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `lsownership` (
  `SpeciesID` int(11) DEFAULT NULL,
  `clientID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `out_services` (
  `ClientID` int(11) DEFAULT NULL,
  `Out_DeliveryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `outgoingdeliveries` (
  `Out_DeliveryID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Expected_Profit` int(11) DEFAULT NULL,
  `Recipient` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;












