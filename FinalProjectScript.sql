CREATE TABLE Park
(
  ParkName VARCHAR NOT NULL,
  ParkLocation VARCHAR NOT NULL,
  Park_ID INT NOT NULL,
  Size INT NOT NULL,
  Established INT NOT NULL,
  PRIMARY KEY (Park_ID),
  UNIQUE (ParkName),
  UNIQUE (ParkLocation)
);

CREATE TABLE Trail
(
  Length INT NOT NULL,
  Difficulty VARCHAR NOT NULL,
  Trail_ID INT NOT NULL,
  TrailName VARCHAR NOT NULL,
  Park_ID INT NOT NULL,
  PRIMARY KEY (Trail_ID),
  FOREIGN KEY (Park_ID) REFERENCES Park(Park_ID)
);

CREATE TABLE Ranger
(
  Ranger_ID INT NOT NULL,
  IsHeadRanger INT NOT NULL,
  HeadRanger INT NOT NULL,
  HireDate DATE NOT NULL,
  LastName VARCHAR NOT NULL,
  FirstName VARCHAR NOT NULL,
  Park_ID INT NOT NULL,
  PRIMARY KEY (Ranger_ID),
  FOREIGN KEY (Park_ID) REFERENCES Park(Park_ID)
);

CREATE TABLE Visitor
(
  FirstName VARCHAR NOT NULL,
  LastName VARCHAR NOT NULL,
  Email VARCHAR NOT NULL,
  Visitor_ID INT NOT NULL,
  MembershipStatus INT NOT NULL,
  PRIMARY KEY (Visitor_ID),
  UNIQUE (Email)
);

CREATE TABLE WildLife_Species
(
  Species_ID INT NOT NULL,
  AnimalName VARCHAR NOT NULL,
  ScientificName VARCHAR NOT NULL,
  ConservationStatus VARCHAR NOT NULL,
  PRIMARY KEY (Species_ID)
);

CREATE TABLE Visit
(
  Visit_ID INT NOT NULL,
  Visitor_ID INT NOT NULL,
  Park_ID INT NOT NULL,
  PRIMARY KEY (Visit_ID),
  FOREIGN KEY (Visitor_ID) REFERENCES Visitor(Visitor_ID),
  FOREIGN KEY (Park_ID) REFERENCES Park(Park_ID)
);

CREATE TABLE Park_Species
(
  Park_ID INT NOT NULL,
  Species_ID INT NOT NULL,
  FOREIGN KEY (Park_ID) REFERENCES Park(Park_ID),
  FOREIGN KEY (Species_ID) REFERENCES WildLife_Species(Species_ID)
);
