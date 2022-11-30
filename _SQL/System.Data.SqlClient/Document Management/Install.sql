/* ------------------------------------------------------------------------------------ */
/* Script by	: DeZign for Databases v4.1.2                     			*/
/* Target DBMS	: MS SQL Server 2005                              			*/
/* Project file	: Document_Management.dez                         			*/
/* Project name	: Document Management                             			*/
/* Author	: Barry Williams                                  			*/
/* Script type	: Database Create Tables script                       			*/
/* Created on	: 5.00 pm 18th. November 2006   		 			*/
/* Notes	: UNIQUEIDENTIFIER replaced BY INTEGER PRIMARY KEY NOT NULL IDENTITY	*/
/*		: This results commenting out some CONSTRAINTS can't be created.	*/
/* ------------------------------------------------------------------------------------ */

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Document_Structures"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Document_Structures] (
    [document_structure_code] NVARCHAR(15) NOT NULL,
    [parent_document_structure_code] NVARCHAR(15),
    [document_structure_description] NVARCHAR(80),
    CONSTRAINT [PK_Document_Structures] PRIMARY KEY ([document_structure_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Document_Types"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Document_Types] (
    [document_type_code] NVARCHAR(15) NOT NULL,
    [document_type_description] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Ref_Document_Types] PRIMARY KEY ([document_type_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Documents"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Documents] (
    [document_code] NVARCHAR(15) NOT NULL,
    [document_structure_code] NVARCHAR(15) NOT NULL,
    [document_type_code] NVARCHAR(15) NOT NULL,
    [access_count] INTEGER,
    [document_name] NVARCHAR(80),
    [document_description] NVARCHAR(255),
    [other_details] NVARCHAR(255),
    CONSTRAINT [PK_Documents] PRIMARY KEY ([document_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Functional_Areas"                                           */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Functional_Areas] (
    [functional_area_code] NVARCHAR(15) NOT NULL,
    [parent_functional_area_code] NVARCHAR(15),
    [functional_area_description] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Functional_Areas] PRIMARY KEY ([functional_area_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Document_Functional_Areas"                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Document_Functional_Areas] (
    [document_code] NVARCHAR(15) NOT NULL,
    [functional_area_code] NVARCHAR(15) NOT NULL,
    CONSTRAINT [PK_Document_Functional_Areas] PRIMARY KEY ([document_code], [functional_area_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Users"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Users] (
    [user_id] INTEGER PRIMARY KEY NOT NULL IDENTITY,
    [user_name] NVARCHAR(40),
    [user_login] NVARCHAR(40),
    [password] NVARCHAR(40),
    [other_details] NVARCHAR(255),
    [role_code] NVARCHAR(15) NOT NULL
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Roles"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Roles] (
    [role_code] NVARCHAR(15) NOT NULL,
    [role_description] NVARCHAR(80),
    CONSTRAINT [PK_Roles] PRIMARY KEY ([role_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Role_Documents_Access_Rights"                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Role_Documents_Access_Rights] (
    [role_code] NVARCHAR(15) NOT NULL,
    [document_code] NVARCHAR(15) NOT NULL,
    [CRUD_Value] NVARCHAR(8),
    CONSTRAINT [PK_Role_Documents_Access_Rights] PRIMARY KEY ([role_code], [document_code])
)
GO

/* Typical CRUD_Values would be R or RW */
/* ---------------------------------------------------------------------- */
/* Add table "Document_Sections"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Document_Sections] (
    [section_id] INTEGER PRIMARY KEY NOT NULL IDENTITY,
    [document_code] NVARCHAR(15) NOT NULL,
    [section_sequence] INTEGER,
    [section_code] NVARCHAR(20),
    [section_title] NVARCHAR(80),
    [section_text] TEXT
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Images"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Images] (
    [image_id] INTEGER PRIMARY KEY NOT NULL IDENTITY,
    [image_alt_text] NVARCHAR(80),
    [image_name] NVARCHAR(40),
    [image_url] NVARCHAR(255),
	[imageFileName] NVARCHAR(255),
	[imageContentType] NVARCHAR(255),
	[imageLength] INTEGER,
	[image] image
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Document_Sections_Images"                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Document_Sections_Images] (
    [section_id] INTEGER NOT NULL,
    [image_id] INTEGER NOT NULL,
    CONSTRAINT [PK_Document_Sections_Images] PRIMARY KEY ([section_id], [image_id])
)
GO




/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Document_Structures] ADD CONSTRAINT [Document_Structures_Document_Structures] 
    FOREIGN KEY ([parent_document_structure_code]) REFERENCES [Document_Structures] ([document_structure_code])
GO

ALTER TABLE [Documents] ADD CONSTRAINT [Document_Structures_Documents] 
    FOREIGN KEY ([document_structure_code]) REFERENCES [Document_Structures] ([document_structure_code])
GO

ALTER TABLE [Documents] ADD CONSTRAINT [Ref_Document_Types_Documents] 
    FOREIGN KEY ([document_type_code]) REFERENCES [Ref_Document_Types] ([document_type_code])
GO

ALTER TABLE [Functional_Areas] ADD CONSTRAINT [Functional_Areas_Functional_Areas] 
    FOREIGN KEY ([parent_functional_area_code]) REFERENCES [Functional_Areas] ([functional_area_code])
GO

ALTER TABLE [Document_Functional_Areas] ADD CONSTRAINT [Functional_Areas_Document_Functional_Areas] 
    FOREIGN KEY ([functional_area_code]) REFERENCES [Functional_Areas] ([functional_area_code])
GO

ALTER TABLE [Document_Functional_Areas] ADD CONSTRAINT [Documents_Document_Functional_Areas] 
    FOREIGN KEY ([document_code]) REFERENCES [Documents] ([document_code])
GO

ALTER TABLE [Users] ADD CONSTRAINT [Roles_Users] 
    FOREIGN KEY ([role_code]) REFERENCES [Roles] ([role_code])
GO

ALTER TABLE [Role_Documents_Access_Rights] ADD CONSTRAINT [Roles_Role_Documents_Access_Rights] 
    FOREIGN KEY ([role_code]) REFERENCES [Roles] ([role_code])
GO

ALTER TABLE [Role_Documents_Access_Rights] ADD CONSTRAINT [Documents_Role_Documents_Access_Rights] 
    FOREIGN KEY ([document_code]) REFERENCES [Documents] ([document_code])
GO

ALTER TABLE [Document_Sections] ADD CONSTRAINT [Documents_Document_Sections] 
    FOREIGN KEY ([document_code]) REFERENCES [Documents] ([document_code])
GO

ALTER TABLE [Document_Sections_Images] ADD CONSTRAINT [Document_Sections_Document_Sections_Images] 
    FOREIGN KEY ([section_id]) REFERENCES [Document_Sections] ([section_id])
GO

ALTER TABLE [Document_Sections_Images] ADD CONSTRAINT [Images_Document_Sections_Images] 
    FOREIGN KEY ([image_id]) REFERENCES [Images] ([image_id])
GO



/* ---------------------------------------------------------------------- */
/* Load Reference data into table "Ref_Document_Types"                    */
/* ---------------------------------------------------------------------- */
INSERT INTO Ref_Document_Types ( document_type_code, document_type_description)
VALUES                         ('BP Manual'        ,'Best Practice Manual'    )
GO

SELECT 'Ref_Document_Types' As Table_Name,*
FROM    Ref_Document_Types
GO


/* ---------------------------------------------------------------------- */
/* Load Reference data into table "Roles"                                 */
/* ---------------------------------------------------------------------- */
INSERT INTO Roles(role_code, role_description)
VALUES           ('ADV'    ,'Protocol Advisor')
GO

INSERT INTO Roles(role_code, role_description)
VALUES           ('AMB'    ,'Ambassador')
GO

INSERT INTO Roles(role_code, role_description)
VALUES           ('DBA'    ,'Database Administration')
GO

INSERT INTO Roles(role_code, role_description)
VALUES           ('LIB'    ,'Librarian'      )
GO

INSERT INTO Roles(role_code, role_description)
VALUES           ('PM'     ,'Project Manager')
GO

/* ---------------------------------------------------------------------- */
/* Check Reference data in table "Roles"                                  */
/* ---------------------------------------------------------------------- */

SELECT 'Roles' As Table_Name,*
FROM    Roles
GO

INSERT INTO Users (role_code, user_name    ,user_login,password,other_details)
VALUES            ('ADV'    ,'Andy Advisor','andy','passwd'  ,NULL         )
GO

INSERT INTO Users (role_code, user_name,user_login,password,other_details)
VALUES            ('LIB'    ,'John Doe','johnd'   ,'passwd',NULL         )
GO

/* ---------------------------------------------------------------------- */
/* Check data in table "Users"                                            */
/* ---------------------------------------------------------------------- */

SELECT 'Users' As Table_Name,*
FROM    Users
GO

/* ---------------------------------------------------------------------- */
/* Load sample data into table "Document_Structures"                      */
/* ---------------------------------------------------------------------- */

INSERT INTO Document_Structures (document_structure_code,parent_document_structure_code,document_structure_description)
VALUES                          ('BP Manual',NULL,'Best Practice Manual')
GO

INSERT INTO Document_Structures (document_structure_code,parent_document_structure_code,document_structure_description)
VALUES                          ('BP Chapter','BP Manual','Chapter in a Best Practice Manual')
GO

INSERT INTO Document_Structures (document_structure_code,parent_document_structure_code,document_structure_description)
VALUES                          ('BP Paragraph','BP Chapter','Paragraph in a Chapter in a Best Practice Manual')
GO

SELECT 'Document_Structures' As Table_Name,*
FROM    Document_Structures
GO

/*
INSERT INTO Documents (document_code,document_structure_code,document_type_code,access_count, document_name,document_description,other_details)
VALUES                ('DIPL_PROTOCOL'   ,'BP Manual'            ,'BP Manual'       ,0           ,'UN Protocol','UN Protocol Guidelines in Geneva'
                      ,'Material in this Best Practices Manual is on the UN Web Site at  http://www.unog.ch/protocol/guide.htm
                      , and is also stored in a Database on the 
                        <A HREF="http://www.databaseanswers.org/pi_best_practice_display/manual.asp?manual_id=UN_PROTOCO'">Database Answers Web Site')
---GO
*/

INSERT INTO Documents (document_code,document_structure_code,document_type_code,access_count, document_name,document_description,other_details)
VALUES                ('DIPL_PROTOCOL'   ,'BP Manual'            ,'BP Manual'       ,0           ,'UN Protocol','UN Protocol Guidelines in Geneva'
                      ,'Material in this Best Practices Manual is on the UN Web Site at  http://www.unog.ch/protocol/guide.htm
                      , and is also stored in a Database on the Database Answers Web Site')
GO

SELECT 'Documents' As Table_Name,*
FROM    Documents
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                          ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,10              ,'BP Chapter','1. Opening of a new Permanent Mission',NULL)
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                          ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,11              ,'BP Paragraph','1.1   A Government informs the Secretary-General of the United Nations'
                              ,'It is current practice for a Government to inform the Secretary-General of the United Nations, in writing, through the intermediary of its Permanent Mission in New York, of its intention to establish a Permanent Mission in Geneva')
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title   ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,20              ,'BP Chapter','2. Credentials',NULL        )
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                          ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,21              ,'BP Paragraph','2.1 Credentials of Permanent Representatives'
                              ,'Credentials of Permanent Representatives are issued either by the Head of State or Government, or by the Minister for Foreign Affairs,
and they are addressed to the Secretary-General of the UN')
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                                               ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,30              ,'BP Chapter','3. Protocol upon assumption of office of Permanent Representatives',NULL)
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                          ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,31              ,'BP Paragraph','3.1 Upon assumption of office by a Permanent Representative'
                              ,'Upon assumption of office by a Permanent Representative,the Permanent Mission should ask the UN Protocol Office in Geneva to make arrangements for the presentation of credentials')
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title       ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,40              ,'BP Chapter','4. Precedence',NULL        )
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                                          ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,50              ,'BP Chapter','5. Presence of Permanent Representatives at ceremonies, etc.',NULL )
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                                            ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,60              ,'BP Chapter','6. End of tenure of office of Permanent Representatives',NULL)
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                                       ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,70              ,'BP Chapter','7. Temporary absences of Permanent Representatives',NULL)
GO

INSERT INTO Document_Sections (document_code,section_sequence,section_code,section_title                           ,section_text)
VALUES                        ('DIPL_PROTOCOL'   ,80              ,'BP Chapter','8. Changes in the diplomatic personnel',NULL)
GO

SELECT 'Document_Sections' As Table_Name,*
FROM    Document_Sections
GO


INSERT INTO Functional_Areas ( functional_area_code,parent_functional_area_code, functional_area_description)
VALUES                       ('Protocol'           ,NULL                       ,'Protocol, Best Practice, SOPs and Guidelines for Etiquette')
GO

INSERT INTO Functional_Areas ( functional_area_code,parent_functional_area_code, functional_area_description)
VALUES                       ('Credentials'        ,'Protocol'                 ,'Presenting Credentials for newly-appointed Ambassadors and High Commissioners')
GO

SELECT 'Functional_Areas' As Table_Name,*
FROM    Functional_Areas
GO

INSERT INTO Document_Functional_Areas ( document_code ,functional_area_code)
VALUES                                ('DIPL_PROTOCOL','Credentials')
GO

SELECT 'Document_Functional_Areas' As Table_Name,*
FROM    Document_Functional_Areas
GO

/* Role_Document_Access_Rights */
INSERT INTO Role_DocumentS_Access_Rights (role_code, document_code , CRUD_Value)
VALUES                                  ('ADV'    ,'DIPL_PROTOCOL','CRUD'     )
GO

INSERT INTO Role_DocumentS_Access_Rights (role_code, document_code ,CRUD_Value)
VALUES                                  ('AMB'    ,'DIPL_PROTOCOL','R'       )
GO

SELECT 'Role_DocumentS_Access_Rights' As Table_Name, *
FROM    Role_DocumentS_Access_Rights
GO

INSERT INTO Images (image_alt_text               ,image_name               ,image_url                                              )
VALUES             ('Barry Williams, Our Sponsor','Photo of Barry Williams','http://www.databaseanswers.org/images/barryw_vsml.jpg')
GO

SELECT 'Images' As Table_Name,*
FROM    Images
GO

INSERT INTO Document_Sections_Images (section_id,image_id)
VALUES                               (1         ,1       )
GO

SELECT 'Document_Sections_Images' As Table_Name,*
FROM    Document_Sections_Images
GO

