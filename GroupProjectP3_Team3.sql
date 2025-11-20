--GROUP 3
--Eric Bonifacic (lead)
--Benjamin Incollingo
--Dylan Brown
--Brian Jordan


--Clean up
DROP TABLE PARK_SPECIES;
DROP TABLE VISIT;
DROP TABLE WILDLIFE_SPECIES;
DROP TABLE VISITOR;
DROP TABLE RANGER;
DROP TABLE TRAIL;
DROP TABLE PARK;


--Tables
CREATE TABLE PARK
(
  Park_ID NUMBER NOT NULL,
  ParkName VARCHAR2(20) NOT NULL,
  ParkLocation VARCHAR2(50) NOT NULL,
  SizeOfPark NUMBER NOT NULL,
  DateEstablished NUMBER NOT NULL,
  
  CONSTRAINT park_pk PRIMARY KEY (Park_ID),
  CONSTRAINT park_name_uq UNIQUE (ParkName),
  CONSTRAINT park_location_uq UNIQUE (ParkLocation)
);


CREATE TABLE TRAIL
(
  Trail_ID NUMBER NOT NULL,
  TrailName VARCHAR2(50) NOT NULL,
  Length NUMBER NOT NULL,
  Difficulty VARCHAR2(10) NOT NULL,
  Park_ID NUMBER NOT NULL,

  CONSTRAINT trail_pk PRIMARY KEY (Trail_ID),
  CONSTRAINT trail_park_fk FOREIGN KEY (Park_ID) REFERENCES PARK (Park_ID)
);


CREATE TABLE RANGER
(
  Ranger_ID NUMBER NOT NULL,
  FirstName VARCHAR2(15) NOT NULL,
  LastName VARCHAR2(15) NOT NULL,
  HireDate DATE NOT NULL,
  Park_ID NUMBER NOT NULL,
  isHeadRanger NUMBER NOT NULL,

  CONSTRAINT ranger_pk PRIMARY KEY (Ranger_ID),
  CONSTRAINT ranger_park_fk FOREIGN KEY (Park_ID) REFERENCES PARK (Park_ID)
);


CREATE TABLE VISITOR
(
  Visitor_ID NUMBER NOT NULL,
  FirstName VARCHAR2(15) NOT NULL,
  LastName VARCHAR2(15) NOT NULL,
  Email VARCHAR2(25) NOT NULL,
  MembershipStatus NUMBER NOT NULL,

  CONSTRAINT visitor_pk PRIMARY KEY (Visitor_ID),
  CONSTRAINT visitor_email_uq UNIQUE (Email)
);


CREATE TABLE WILDLIFE_SPECIES
(
  Species_ID NUMBER NOT NULL,
  AnimalName VARCHAR2(50) NOT NULL,
  ScientificName VARCHAR2(50) NOT NULL,
  ConservationStatus VARCHAR2(20) NOT NULL,

  CONSTRAINT species_pk PRIMARY KEY (Species_ID)
);


CREATE TABLE VISIT
(
  Visit_ID NUMBER NOT NULL,
  Visitor_ID NUMBER NOT NULL,
  Park_ID NUMBER NOT NULL,

  CONSTRAINT visit_pk PRIMARY KEY (Visit_ID),
  CONSTRAINT visit_visitor_fk FOREIGN KEY (Visitor_ID) REFERENCES VISITOR (Visitor_ID),
  CONSTRAINT visit_park_fk FOREIGN KEY (Park_ID) REFERENCES PARK (Park_ID)
);


CREATE TABLE PARK_SPECIES
(
  Park_ID NUMBER NOT NULL,
  Species_ID NUMBER NOT NULL,

  CONSTRAINT park_species_park_fk FOREIGN KEY (Park_ID) REFERENCES PARK (Park_ID),
  CONSTRAINT park_species_species_fk FOREIGN KEY (Species_ID) REFERENCES WILDLIFE_SPECIES (Species_ID)
);


--Indexes and Sequences
CREATE INDEX trail_difficulty_ix ON TRAIL (Difficulty);
CREATE INDEX visitor_membership_ix ON VISITOR (MembershipStatus);
CREATE INDEX ranger_park_ix ON RANGER (Park_ID);

CREATE SEQUENCE park_id_seq START WITH 101;
CREATE SEQUENCE trail_id_seq START WITH 201;
CREATE SEQUENCE ranger_id_seq START WITH 301;
CREATE SEQUENCE visitor_id_seq START WITH 401;
CREATE SEQUENCE species_id_seq START WITH 501;
CREATE SEQUENCE visit_id_seq START WITH 601;


--Insterting data
INSERT INTO PARK VALUES (park_id_seq.NEXTVAL, 'Yellowstone', 'Montana', 5000, 1955);
INSERT INTO PARK VALUES (park_id_seq.NEXTVAL, 'Grand Teton', 'Wyoming', 3200, 1972);


INSERT INTO TRAIL VALUES (trail_id_seq.NEXTVAL, 'Mammoth Terraces', 2.2, 'Easy', 101);
INSERT INTO TRAIL VALUES (trail_id_seq.NEXTVAL, 'Teton Crest Trail', 40, 'Hard', 102);


INSERT INTO RANGER VALUES (ranger_id_seq.NEXTVAL, 'Paul', 'Blart', DATE '2021-05-10', 101, 1);
INSERT INTO RANGER VALUES (ranger_id_seq.NEXTVAL, 'The', 'Rock', DATE '2020-03-14', 102, 0);


INSERT INTO VISITOR VALUES (visitor_id_seq.NEXTVAL, 'George', 'Washington', 'gwash@yahoo.com', 1);
INSERT INTO VISITOR VALUES (visitor_id_seq.NEXTVAL, 'Dennis', 'Richie', 'richthekid@aol.com', 0);


INSERT INTO WILDLIFE_SPECIES VALUES (species_id_seq.NEXTVAL, 'Bald Eagle', 'Haliaeetus leucocephalus', 'Protected');
INSERT INTO WILDLIFE_SPECIES VALUES (species_id_seq.NEXTVAL, 'Black Bear', 'Ursus americanus', 'Least Concern');


INSERT INTO VISIT VALUES (visit_id_seq.NEXTVAL, 401, 101);
INSERT INTO VISIT VALUES (visit_id_seq.NEXTVAL, 402, 102);


INSERT INTO PARK_SPECIES VALUES (101, 501);
INSERT INTO PARK_SPECIES VALUES (102, 502);

COMMIT;


--Query Examples
--Calculates how many total visitor visits each park has
SELECT p.ParkName,
       COUNT(v.Visit_ID) AS NumVisits
FROM PARK p
LEFT JOIN VISIT v ON p.Park_ID = v.Park_ID
GROUP BY p.ParkName;

--Computes the total trail mileage in each park 
SELECT p.ParkName,
       SUM(t.Length) AS TotalTrailMiles
FROM PARK p
JOIN TRAIL t ON p.Park_ID = t.Park_ID
GROUP BY p.ParkName;
