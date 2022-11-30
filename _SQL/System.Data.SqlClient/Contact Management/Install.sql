/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          contact_management_dezign.dez                   */
/* Project name:          Contact Management                              */
/* Author:                Barry Williams                                  */
/* Script type:           Database creation script                        */
/* Created on:            2006-11-17 22:35                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Customers"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customers] (
    [customer_id] INTEGER IDENTITY (1,1) NOT NULL,
    [organisation_or_person] NVARCHAR(8),
    [organisation_name] NVARCHAR(255),
    [first_name] NVARCHAR(255),
    [last_name] NVARCHAR(255),
    [date_became_customer] DATETIME,
    [other_customer_details] NVARCHAR(255),
    CONSTRAINT [PK_Customers] PRIMARY KEY ([customer_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Addresses"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Addresses] (
    [address_id] INTEGER IDENTITY (1,1) NOT NULL,
    [line_1] NVARCHAR(80),
    [line_2] NVARCHAR(80),
    [line_3] NVARCHAR(80),
    [city] NVARCHAR(80),
    [zip_postcode] NVARCHAR(20),
    [state_province_county] NVARCHAR(50),
    [country] NVARCHAR(80),
    [other_address_details] NVARCHAR(255),
    CONSTRAINT [PK_Addresses] PRIMARY KEY ([address_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer_Addresses"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customer_Addresses] (
    [customer_id] INTEGER NOT NULL,
    [address_id] INTEGER NOT NULL,
    [date_address_from] DATETIME NOT NULL,
    [date_address_to] DATETIME,
    [other_details] NVARCHAR(255),
    CONSTRAINT [PK_Customer_Addresses] PRIMARY KEY ([customer_id], [address_id], [date_address_from])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Contacts"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Contacts] (
    [contact_id] INTEGER IDENTITY (1,1) NOT NULL,
    [customer_id] INTEGER NOT NULL,
    [status_code] NVARCHAR(15) NOT NULL,
    [email_address] NVARCHAR(255),
    [web_site] NVARCHAR(255),
    [salutation] NVARCHAR(40),
    [contact_name] NVARCHAR(255),
    [job_title] NVARCHAR(255),
    [department] NVARCHAR(40),
    [work_phone] NVARCHAR(40),
    [cell_mobile_phone] NVARCHAR(40),
    [fax_number] NVARCHAR(40),
    [other_contact_details] NVARCHAR(255),
    CONSTRAINT [PK_Contacts] PRIMARY KEY ([contact_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Contact_Status"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Contact_Status] (
    [status_code] NVARCHAR(15) NOT NULL,
    [status_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Contact_Status] PRIMARY KEY ([status_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Activity_Types"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Activity_Types] (
    [activity_type_code] NVARCHAR(15) NOT NULL,
    [activity_type_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Activity_Types] PRIMARY KEY ([activity_type_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Contact_Activities"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Contact_Activities] (
    [activity_id] INTEGER IDENTITY (1,1) NOT NULL,
    [contact_id] INTEGER NOT NULL,
    [activity_type_code] NVARCHAR(15) NOT NULL,
    [outcome_code] NVARCHAR(15) NOT NULL,
    [date_activity] DATETIME,
    [other_details] NVARCHAR(255),
    CONSTRAINT [PK_Contact_Activities] PRIMARY KEY ([activity_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Activity_Outcomes"                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Activity_Outcomes] (
    [outcome_code] NVARCHAR(15) NOT NULL,
    [outcome_description] NVARCHAR(80),
    CONSTRAINT [PK_Ref_Activity_Outcomes] PRIMARY KEY ([outcome_code])
)
GO


/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */
ALTER TABLE [Customer_Addresses] ADD CONSTRAINT [Customers_Customer_Addresses] 
    FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Customer_Addresses] ADD CONSTRAINT [Addresses_Customer_Addresses] 
    FOREIGN KEY ([address_id]) REFERENCES [Addresses] ([address_id])
GO



ALTER TABLE [Contacts] ADD CONSTRAINT [Ref_Contact_Status_Contacts] 
    FOREIGN KEY ([status_code]) REFERENCES [Ref_Contact_Status] ([status_code])
GO


ALTER TABLE [Contacts] ADD CONSTRAINT [Customers_Contacts] 
    FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Contact_Activities] ADD CONSTRAINT [Ref_Activity_Types_Contact_Activities] 
    FOREIGN KEY ([activity_type_code]) REFERENCES [Ref_Activity_Types] ([activity_type_code])
GO


ALTER TABLE [Contact_Activities] ADD CONSTRAINT [Contacts_Contact_Activities] 
    FOREIGN KEY ([contact_id]) REFERENCES [Contacts] ([contact_id])
GO


ALTER TABLE [Contact_Activities] ADD CONSTRAINT [Ref_Activity_Outcomes_Contact_Activities] 
    FOREIGN KEY ([outcome_code]) REFERENCES [Ref_Activity_Outcomes] ([outcome_code])
GO


/* ---------------------------------------------------------------------- */
/* Load Data into table "Ref_Activity_Outcomes"                            */
/* ---------------------------------------------------------------------- */

INSERT INTO Ref_Activity_Outcomes (outcome_code,outcome_description)
VALUES                           ('Cancel','Arrangements cancelled')
GO

INSERT INTO Ref_Activity_Outcomes (outcome_code,outcome_description)
VALUES                           ('Deal','Closed Deal')
GO

/* ---------------------------------------------------------------------- */
/* Check Data in table "Ref_Activity_Outcome"                             */
/* ---------------------------------------------------------------------- */

SELECT 'Ref_Activity_Outcomes' As Table_Name,* FROM Ref_Activity_Outcomes 
ORDER  BY outcome_code
GO



/* ---------------------------------------------------------------------- */
/* Load Data into table "Ref_Activity_Types"                            */
/* ---------------------------------------------------------------------- */
INSERT INTO Ref_Activity_Types (activity_type_code,activity_type_description)
VALUES                         ('Meet','Arrange Meeting')
GO

INSERT INTO Ref_Activity_Types (activity_type_code,activity_type_description)
VALUES                         ('Phone','Discuss Deal over the phone')
GO

/* ---------------------------------------------------------------------- */
/* Check Data in table "Ref_Activity_Outcome"                             */
/* ---------------------------------------------------------------------- */

SELECT 'Ref_Activity_Types' As Table_Name,* FROM Ref_Activity_Types 
ORDER  BY activity_type_code
GO

/* ---------------------------------------------------------------------- */
/* Load Data into table "Ref_Contact_Status"                              */
/* ---------------------------------------------------------------------- */
INSERT INTO Ref_Contact_Status (status_code,status_description)
VALUES                         ('Customer','Customer')
GO

INSERT INTO Ref_Contact_Status (status_code,status_description)
VALUES                         ('Supplier','Supplier')
GO

/* ---------------------------------------------------------------------- */
/* Check Data in table "Ref_Contact_Status"                               */
/* ---------------------------------------------------------------------- */
SELECT 'Ref_Contact_Status' As Table_Name,* FROM Ref_Contact_Status 
ORDER  BY status_code
GO

/* ---------------------------------------------------------------------- */
/* Load Data into table "Addresses"                                       */
/* ---------------------------------------------------------------------- */

/* Business Address ... */
INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('1500 E MAIN AVE STE 201','','','Springfield','22162-1010'
                      ,'VA','USA','This conforms to the US Postal Service 2-line address standard (see http://pe.usps.com/)')
GO


INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('123 MAGNOLIA ST','','','Hempstead','11550-1234'
                      ,'NY','USA','This conforms to the US Postal Service 2-line address standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('Rural Route 1,Box 99999',NULL,NULL,'Odessa','12345'
                      ,'MN','USA','This is a fictitious address but conforms to the US Postal Service 2-line standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('123 Woodland Street',NULL,NULL,'New Haven','06512'
                      ,'CT','USA','This does not conform to the US Postal Service 2-line address standard')
GO

INSERT INTO Addresses (line_1,line_2,line_3,city,zip_postcode
                      ,state_province_county,country,other_address_details)
VALUES                ('1776 New Cavendish Street',NULL,'Marylebone','London','W11X5BY'
                      ,'Greater London','UK',NULL)
GO

SELECT 'Addresses' As Table_Name,*
FROM   Addresses
GO


INSERT INTO Customers (organisation_or_person,organisation_name,first_name,last_name
                      ,date_became_customer,other_customer_details)
VALUES                ('ORG', 'Acme Widgets Inc',NULL,NULL
                      ,DATEADD(mi,-(60*24*301 + 60*24*4 + 37),getdate()),NULL)
GO

INSERT INTO Customers (organisation_or_person,organisation_name,first_name,last_name
                      ,date_became_customer,other_customer_details)
VALUES                ('PERSON',NULL,'John','Doe'
                      ,DATEADD(mi,-(60*24*342 + 60*24*27 + 9),getdate()),NULL)
GO

INSERT INTO Customers (organisation_or_person,organisation_name,first_name,last_name
                      ,date_became_customer,other_customer_details)
VALUES                ('PERSON',NULL,'Joseph','Bloggs'
                      ,DATEADD(mi,-(60*24*365 + 60*24*15 + 72),getdate()),NULL)
GO

SELECT 'Customers' As Table_Name,* 
FROM Customers
GO

INSERT INTO Customer_Addresses (customer_id,address_id,date_address_from,date_address_to,other_details)
VALUES                         (        1  ,       1  , DATEADD(mi,-(60*24*301 + 60*24*4 + 37),getdate()),DATEADD(mi,(60*24*365 + 60*24*7 + 36),getdate()),NULL)
GO

INSERT INTO Customer_Addresses (customer_id,address_id,date_address_from,date_address_to,other_details)
VALUES                         (        2  ,       2  , DATEADD(mi,-(60*24*342 + 60*24*27 + 9),getdate()),DATEADD(mi,(60*24*365 + 60*24*7 + 36),getdate()),NULL)
GO

INSERT INTO Customer_Addresses (customer_id,address_id,date_address_from,date_address_to,other_details)
VALUES                         (        3  ,       5  , DATEADD(mi,-(60*24*365 + 60*24*15 + 72),getdate()),DATEADD(mi,(60*24*365 + 60*24*7 + 36),getdate()),NULL)
GO

SELECT 'Customer_Addresses' As Table_Name,* 
FROM Customer_Addresses
GO

INSERT INTO Contacts (customer_id,status_code,email_address,web_site,contact_name,job_title,department,work_phone,cell_mobile_phone,fax_number,other_contact_details)
VALUES               (        1  ,'Supplier' ,    'pencils@pencilisland.com'     , 'pencilsisland.com', 'George Rooney', 'Manager', 'Sales', '777-789-4522', '778-553-3628','625-486-2541','Keep an eye on this one.'         )
GO

INSERT INTO Contacts (customer_id,status_code,email_address,web_site,contact_name,job_title,department,work_phone,cell_mobile_phone,fax_number,other_contact_details)
VALUES               (        2  ,'Customer' ,    'ready2move@fitness.com'     , 'fitness.com', 'Jeremy Fischer', 'Consultant', 'Marketing', '458-261-4577', '985-122-2385','778-587-4521',NULL         )
GO

INSERT INTO Contacts (customer_id,status_code,email_address,web_site,contact_name,job_title,department,work_phone,cell_mobile_phone,fax_number,other_contact_details)
VALUES               (        3  ,'Customer' ,    'harry@harryrendel.com'     , 'harryrendel.com', 'Harry Rendel', 'Freelancer', 'Design', '152-254-1578', '324-015-0235','254-678-5421','Very friendly.'         )
GO


SELECT 'Contacts' As Table_Name,* 
FROM    Contacts
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       1  ,        'Meet'    ,    'Deal'  , DATEADD(mi,-(60*24*0 + 30),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       2  ,        'Phone'    ,    'Cancel'  , DATEADD(mi,-(60*24*0 + 72),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       3  ,        'Phone'    ,    'Deal'  , DATEADD(mi,-(60*24*0 + 142),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       2  ,        'Meet'    ,    'Cancel'  , DATEADD(mi,-(60*24*1 + 69),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       1  ,        'Meet'    ,    'Deal'  , DATEADD(mi,-(60*24*1 + 253),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       3  ,        'Phone'    ,    'Cancel'  , DATEADD(mi,-(60*24*2 - 39),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       2  ,        'Phone'    ,    'Deal'  , DATEADD(mi,-(60*24*2 - 391),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       3  ,        'Meet'    ,    'Deal'  , DATEADD(mi,-(60*24*2 + 42),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       1  ,        'Phone'    ,    'Deal'  , DATEADD(mi,-(60*24*2 - 177),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       3  ,        'Meet'    ,    'Cancel'  , DATEADD(mi,-(60*24*3 + 7),getdate())  ,  NULL      )
GO

INSERT INTO Contact_Activities (contact_id,activity_type_code,outcome_code,date_activity,other_details)
VALUES                         (       2  ,        'Phone'    ,    'Deal'  , DATEADD(mi,-(60*24*4 + 147),getdate())  ,  NULL      )
GO

SELECT 'Contact_Activities' As Table_Name,* 
FROM    Contact_Activities
GO


