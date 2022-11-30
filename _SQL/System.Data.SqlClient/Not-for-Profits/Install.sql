/* Script from ERWin   */
/* 2nd. December  2006 */
/* INSERT Statements are at the end of the Script to load sample Data */

CREATE TABLE Addresses (
       address_id             integer primary key NOT NULL identity,
       line_1                 NVARCHAR(80) NULL,
       line_2                 NVARCHAR(80) NULL,
       line_3                 NVARCHAR(80) NULL,
       city_town              NVARCHAR(80) NULL,
       zip_or_postcode        NVARCHAR(20) NULL,
       state_province_county  NVARCHAR(80) NULL,
       country                NVARCHAR(80) NULL,
       other_address_details  NVARCHAR(255) NULL
)
go

CREATE TABLE Appeals (
       appeal_id            integer primary key NOT NULL identity,
       organisation_id      int NOT NULL,
       appeal_from_date     datetime NULL,
       appeal_to_date       datetime NULL,
       appeal_name          NVARCHAR(80) NULL,
       appeal_target        NVARCHAR(255) NULL,
       appeal_results       NVARCHAR(255) NULL,
       appeal_description   NVARCHAR(255) NULL,
       other_details        NVARCHAR(255) NULL
)
go


/* 1 */
CREATE TABLE Event_Types (
       event_type_code        NVARCHAR(15)    NOT NULL,
       event_type_description NVARCHAR(80)     NULL
)
go

/*        eg_Appeal, Fundraiser NVARCHAR(18) NULL */


ALTER TABLE Event_Types
       ADD PRIMARY KEY (event_type_code)
go

CREATE TABLE Events (
       event_id             integer primary key NOT NULL identity,
       organisation_id      int      NOT NULL,
       event_type_code      NVARCHAR(15) NOT NULL,
       event_from_date      datetime NULL,
       event_to_date        datetime NULL,
       event_name           NVARCHAR(80) NULL,
       event_purpose        NVARCHAR(255) NULL,
       event_results        NVARCHAR(255) NULL,
       event_description    NVARCHAR(255) NULL,
       other_details        NVARCHAR(255) NULL
)
go

/*
ALTER TABLE Events
       ADD PRIMARY KEY (event_id)
--go
*/

CREATE TABLE Events_People (
       event_id             int NOT NULL,
       person_id            int NOT NULL
)
go


ALTER TABLE Events_People
       ADD PRIMARY KEY (event_id, person_id)
go


CREATE TABLE Partner_Relationships (
       organisation_id          int NOT NULL,
       partner_organisation_id  int NOT NULL,
       relationship_from_date   datetime NOT NULL,
       relationship_to_date     datetime NULL,
       relationship_description NVARCHAR(255) NULL,
       other_details            NVARCHAR(255) NULL
)
go


ALTER TABLE Partner_Relationships
       ADD PRIMARY KEY (organisation_id, partner_organisation_id, 
              relationship_from_date)
go


CREATE TABLE Organisation_Categories (
       organisation_category_code NVARCHAR(15) primary key NOT NULL,
       organisation_category_description NVARCHAR(80) NULL)
go

/* For example -  eg NVARCHARity, Partner School */

CREATE TABLE Organisations (
       organisation_id            integer primary key NOT NULL identity,
       parent_organisation_id     int NULL,
       organisation_name          NVARCHAR(80) NULL,
       address_id                 int NULL,
       organisation_phone         NVARCHAR(80) NULL,
       organisation_category_code NVARCHAR(15) NOT NULL,
       organisation_description   NVARCHAR(255) NULL,
       other_details              NVARCHAR(255) NULL
)
go

CREATE TABLE People (
       person_id            integer primary key NOT NULL identity,
       address_id           int NULL,
       organisation_id      int NULL,
       people_category_code NVARCHAR(15) NULL,
       role_code            NVARCHAR(15) NULL,
       from_date            datetime NULL,
       to_date              datetime NULL,
       first_name           NVARCHAR(80) NULL,
       middle_name          NVARCHAR(80) NULL,
       last_name            NVARCHAR(80) NULL,
       gender               NVARCHAR(1) NULL,
       date_of_birth        datetime NULL,
       other_details        NVARCHAR(255) NULL
)
go


/*
ALTER TABLE People
       ADD PRIMARY KEY (person_id)
--go
*/

/*
CREATE TABLE People_Categories (
       people_category_code NVARCHAR(15) NOT NULL,
       people_category_description NVARCHAR(80) NULL)
--go
*/
/* For example - Client_in_Coaching, Employee_with_Contract */



CREATE TABLE Roles (
       role_code        NVARCHAR(15) NOT NULL,
       role_description NVARCHAR(80) NULL)
go

/* Roles can be Client, Contact or Employee */


ALTER TABLE Roles
       ADD PRIMARY KEY (role_code)
go


CREATE TABLE People_Skills (
       person_id            int NOT NULL,
       skill_code           NVARCHAR(15) NOT NULL,
       skill_level          NVARCHAR(80) NULL)
go

/* Example - Skill Level = 5_years_experience */


ALTER TABLE People_Skills
       ADD PRIMARY KEY (person_id, skill_code)
go


CREATE TABLE Skills (
       skill_code           NVARCHAR(15) NOT NULL,
       skill_description    NVARCHAR(80) NULL)
go

/* eg Fund Raiser */

ALTER TABLE Skills
       ADD PRIMARY KEY (skill_code)
go


ALTER TABLE Appeals
       ADD FOREIGN KEY (organisation_id)
                             REFERENCES Organisations
go


ALTER TABLE Events
       ADD FOREIGN KEY (event_type_code)
                             REFERENCES Event_Types
go


ALTER TABLE Events
       ADD FOREIGN KEY (organisation_id)
                             REFERENCES Organisations
go

ALTER TABLE Events_People
       ADD FOREIGN KEY (person_id)
                             REFERENCES People
go


ALTER TABLE Events_People
       ADD FOREIGN KEY (event_id)
                             REFERENCES Events
go


ALTER TABLE Partner_Relationships
       ADD FOREIGN KEY (organisation_id)
                             REFERENCES Organisations
go


ALTER TABLE Partner_Relationships
       ADD FOREIGN KEY (partner_organisation_id)
                             REFERENCES Organisations
go


ALTER TABLE Organisation_Categories
       ADD FOREIGN KEY (organisation_category_code)
                             REFERENCES Organisation_Categories
go


ALTER TABLE Organisations
       ADD FOREIGN KEY (address_id)
                             REFERENCES Addresses
go


ALTER TABLE Organisations
       ADD FOREIGN KEY (organisation_category_code)
                             REFERENCES Organisation_Categories
go


ALTER TABLE Organisations
       ADD FOREIGN KEY (organisation_id)
                             REFERENCES Organisations
go


ALTER TABLE People
       ADD FOREIGN KEY (role_code)
                             REFERENCES Roles
go


ALTER TABLE People
       ADD FOREIGN KEY (address_id)
                             REFERENCES Addresses
go

ALTER TABLE People
       ADD FOREIGN KEY (organisation_id)
                             REFERENCES Organisations
go


ALTER TABLE People_Skills
       ADD FOREIGN KEY (skill_code)
                             REFERENCES Skills
go


ALTER TABLE People_Skills
       ADD FOREIGN KEY (person_id)
                             REFERENCES People
go


/* Finally, Load sample Reference Data */
INSERT INTO Organisation_Categories (organisation_category_code, organisation_category_description) 
VALUES                              ('Charity','Charity')
GO

INSERT INTO Organisation_Categories (organisation_category_code, organisation_category_description) 
VALUES                              ('NPO','Not For Profit')
GO

INSERT INTO Organisation_Categories (organisation_category_code, organisation_category_description) 
VALUES                              ('Partner','Partner')
GO

INSERT INTO Organisation_Categories (organisation_category_code, organisation_category_description) 
VALUES                              ('School','School')
GO

SELECT 'Organisation_Categories' As Table_Name,* FROM Organisation_Categories
GO

INSERT INTO Roles (role_code,role_description)
VALUES            ('Ambassador','UNICEF Goodwill Ambassador')
GO


INSERT INTO Roles (role_code,role_description)
VALUES            ('Client','Client')
GO

INSERT INTO Roles (role_code,role_description)
VALUES            ('Contact','Contact')
GO


INSERT INTO Roles (role_code,role_description)
VALUES            ('Staff','Full or Part-Time paid Employee')
GO

INSERT INTO Roles (role_code,role_description)
VALUES            ('Supporter','Supporter')
GO

INSERT INTO Roles (role_code,role_description)
VALUES            ('Volunteer','Volunteer')
GO

INSERT INTO Roles (role_code,role_description)
VALUES            ('Young Leader','UNICEF Young Leader')
GO

SELECT 'Roles' As Table_Name,* FROM Roles
GO

INSERT INTO Skills (skill_code,skill_description)
VALUES             ('Fundraiser','Fundraiser')
GO

INSERT INTO Skills (skill_code, skill_description)
VALUES             ('Singer'  ,'Singer'          )
GO

INSERT INTO Skills (skill_code     , skill_description)
VALUES             ('Tennis Player','Tennis Player'   )
GO

SELECT 'Skills' As Table_Name,* 
FROM    Skills
GO



/* Addresses */
/* Address Nr.1 */
INSERT INTO Addresses (line_1
                      ,line_2
                      ,line_3,city_town,zip_or_postcode,state_province_county,country,other_address_details)
VALUES                ('Unicef House,3 United Nations Plaza'
                      ,'New York, New York, 10017'
                      ,NULL  ,NULL     ,NULL           ,NULL                 ,NULL   ,NULL                 )
GO

/* Address Nr.2 */
INSERT INTO Addresses (line_1    ,line_2         ,line_3,city_town,zip_or_postcode,state_province_county,country         ,other_address_details)
VALUES                ('IG House','Palliser Road',NULL  ,'London' ,'W14 9EB'      ,NULL                 ,'United Kingdom','Executive Offices-also Addresses in New York, Monaco, etc.'                 )
GO

SELECT 'Addresses' As Table_Name,*
FROM    Addresses
GO


/* Organisations */
/* Organisation Nr.1 is UNICEF */
INSERT INTO Organisations (parent_organisation_id,organisation_category_code,address_id
                          ,organisation_name,organisation_phone,organisation_description,other_details)
VALUES                    (NULL                  ,'Charity'                 ,1
                          ,'UNICEF'         ,NULL              ,'UN Childrens Education Fund',NULL    ) 
GO

/* Organisation Nr.2 is ATP - the Association of Tennis Professionals  */
INSERT INTO Organisations (parent_organisation_id,organisation_category_code,address_id
                          ,organisation_name,organisation_phone,organisation_description,other_details)
VALUES                    (NULL                  ,'Partner'                 ,2
                          ,'ATP'         ,NULL              ,'Association of Tennis Professionals',NULL) 
GO

SELECT 'Organisations' As Table_Name,*
FROM    Organisations
GO




INSERT INTO Partner_Relationships (organisation_id,partner_organisation_id
                                  ,relationship_from_date,relationship_to_date
                                  ,relationship_description,other_details)
VALUES                            (1              ,2    
                                  ,'3-april-2005',NULL
                                  ,'Patnership to raise Funds with Roger Federer',NULL)
go

SELECT 'Partner_Relationships' As Table_Name,*
FROM    Partner_Relationships
GO


INSERT INTO People (address_id,organisation_id,role_code,from_date,to_date
                   ,first_name,middle_name,last_name,gender,date_of_birth,other_details)
VALUES             (NULL      ,1              ,'Ambassador','01/01/2005',NULL
                   ,'Angelique'   ,NULL       ,'Kidjo','M'   ,NULL,NULL)
go


INSERT INTO People (address_id,organisation_id,role_code,from_date,to_date
                   ,first_name,middle_name,last_name,gender,date_of_birth,other_details)
VALUES             (NULL      ,1              ,'Ambassador','3-April-2006',NULL
                   ,'Roger'   ,NULL       ,'Federer','M'   ,NULL,NULL)
go

INSERT INTO People (address_id,organisation_id,role_code,from_date,to_date
                   ,first_name,middle_name,last_name,gender,date_of_birth,other_details)
VALUES             (1         ,1              ,'Staff','1-May-2005',NULL
                   ,'Ann'     ,'M'        ,'Veneman','F'   ,NULL,'Executive Director')
go


SELECT 'People' As Table_Name,*
FROM    People
GO

INSERT INTO People_Skills (person_id,skill_code,skill_level)
VALUES                    (1        ,'Tennis Player','World Champion')
go

INSERT INTO People_Skills (person_id,skill_code,skill_level)
VALUES                    (2        ,'Singer'  ,'Very Popular in Africa')
go

SELECT 'People_Skills' As Table_Name,*
FROM    People_Skills
GO

INSERT INTO Event_Types (event_type_code,event_type_description            )
VALUES                  ('Fundraiser'   ,'Fund raising Event, eg Feder-Bear')
go

SELECT 'Event_Types' As Table_Name,*
FROM    Event_Types
GO


INSERT INTO Events (organisation_id,event_type_code,event_from_date,event_to_date
                   ,event_name,event_purpose,event_results
                   ,event_description, other_details)
VALUES             (1              ,'Fundraiser','8-Sep-2006',NULL
                   ,'Feder-Bear','Raise Funds for Children','Very successful'
                   ,'Roger Federer sponsors a little Teddy Bear',NULL)
go

SELECT 'Events' As Table_Name,*
FROM    Events
GO

INSERT INTO Events_People (event_id, person_id)
VALUES                    (1       ,1         )
go

SELECT 'Events_People' As Table_Name,*
FROM    Events_People
GO

