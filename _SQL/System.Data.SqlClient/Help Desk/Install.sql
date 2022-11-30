/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          help_desk_dezign.dez                            */
/* Project name:          Help Desk                                       */
/* Author:                Barry Williams                                  */
/* Script type:           Database creation script                        */
/* Created on:            2006-12-01 21:38                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Priority_Levels"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Priority_Levels] (
    [priority_level_code] NVARCHAR(20) NOT NULL,
    [priority_level_description] NVARCHAR(255),
     CONSTRAINT [PK_Ref_Priority_Levels] PRIMARY KEY ([priority_level_code])
)
GO

/*   [eg Hi, Med, Low] NVARCHAR(1), */


/* ---------------------------------------------------------------------- */
/* Add table "Users"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Users] (
    [user_id] INTEGER IDENTITY(1,1) NOT NULL,
    [user_type_code] NVARCHAR(20) NOT NULL,
    [user_first_name] NVARCHAR(80),
    [user_last_name] NVARCHAR(80),
    [user_phone] NVARCHAR(80),
    [user_email] NVARCHAR(80),
    [address] NVARCHAR(255),
    [other_user_details] NVARCHAR(255),
    CONSTRAINT [PK_Users] PRIMARY KEY ([user_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "User_Equipment_History"                                     */
/* ---------------------------------------------------------------------- */
/*
CREATE TABLE [User_Equipment_History] (
    [user_id] INTEGER NOT NULL,
    [equipment_id] INTEGER NOT NULL,
    [date_equipment_owned] DATETIME NOT NULL,
    [date_equipment_released] DATETIME,
    CONSTRAINT [PK_User_Equipment_History] PRIMARY KEY ([user_id], [equipment_id], [date_equipment_owned])
)
--GO
*/

/* ---------------------------------------------------------------------- */
/* Add table "Ref_User_Types"                                             */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_User_Types] (
    [user_type_code] NVARCHAR(20) NOT NULL,
    [user_type_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_User_Types] PRIMARY KEY ([user_type_code])
)
GO

/*      [eg Admin,Mgt] NVARCHAR(1), */

/* ---------------------------------------------------------------------- */
/* Add table "Problems"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problems] (
    [problem_id] INTEGER IDENTITY(1,1) NOT NULL,
    [equipment_id] INTEGER NOT NULL,
    [user_id] INTEGER NOT NULL,
    [problem_reported_datetime] DATETIME NOT NULL,
    [problem_description] NVARCHAR(255),
    CONSTRAINT [PK_Problems] PRIMARY KEY ([problem_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Problem_Status_Codes"                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Problem_Status_Codes] (
    [problem_status_code] NVARCHAR(20) NOT NULL,
    [problem_status_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Problem_Status_Codes] PRIMARY KEY ([problem_status_code])
)
GO

/*    [eg Assigned, Open, Closed] NVARCHAR(1), */


/* ---------------------------------------------------------------------- */
/* Add table "Support_Staff"                                              */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Support_Staff] (
    [staff_id] INTEGER IDENTITY(1,1) NOT NULL,
    [date_joined] DATETIME,
    [date_left] DATETIME,
    [staff_name] NVARCHAR(80),
    [staff_phone] NVARCHAR(80),
    [staff_email] NVARCHAR(80),
    [staff_location] NVARCHAR(255),
    [other_staff_details] NVARCHAR(255),
    CONSTRAINT [PK_Support_Staff] PRIMARY KEY ([staff_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Skill_Codes"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Skill_Codes] (
    [skill_code] NVARCHAR(20) NOT NULL,
    [skill_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Skill_Codes] PRIMARY KEY ([skill_code])
)
GO

/* eg DBA, Telecomms */

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Equipment_Types"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Equipment_Types] (
    [equipment_type_code] NVARCHAR(20) NOT NULL,
    [equipment_type_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Equipment_Types] PRIMARY KEY ([equipment_type_code])
)
GO

/* eg PDA */

/* ---------------------------------------------------------------------- */
/* Add table "Equipment"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Equipment] (
    [equipment_id] INTEGER IDENTITY(1,1) NOT NULL,
    [equipment_type_code] NVARCHAR(20) NOT NULL,
    [date_equipment_acquired] DATETIME NOT NULL,
    [date_equipment_disposed] DATETIME,
    [equipment_code] NVARCHAR(20),
    [equipment_name] NVARCHAR(255),
    [equipment_description] NVARCHAR(255),
    [manufacturer_name] NVARCHAR(80),
    [other_details] NVARCHAR(255),
    CONSTRAINT [PK_Equipment] PRIMARY KEY ([equipment_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Problem_History"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problem_History] (
    [problem_history_id] INTEGER IDENTITY(1,1) NOT NULL,
    [priority_level_code] NVARCHAR(20) NOT NULL,
    [problem_id] INTEGER NOT NULL,
    [problem_status_code] NVARCHAR(20) NOT NULL,
    [assigned_staff_id] INTEGER NOT NULL,
    [fix_datetime] DATETIME NOT NULL,
    CONSTRAINT [PK_Problem_History] PRIMARY KEY ([problem_history_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Resolutions"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Resolutions] (
    [resolution_id] INTEGER IDENTITY(1,1) NOT NULL,
    [problem_history_id] INTEGER NOT NULL,
    [resolution_description] NVARCHAR(255),
    CONSTRAINT [PK_Resolutions] PRIMARY KEY ([resolution_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Staff_Skills"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Staff_Skills] (
    [staff_id] INTEGER NOT NULL,
    [skill_code] NVARCHAR(20) NOT NULL,
    [date_skill_obtained] DATETIME,
    CONSTRAINT [PK_Staff_Skills] PRIMARY KEY ([staff_id], [skill_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Users] ADD CONSTRAINT [Ref_User_Types_Users] 
    FOREIGN KEY ([user_type_code]) REFERENCES [Ref_User_Types] ([user_type_code])
GO

/*
ALTER TABLE [User_Equipment_History] ADD CONSTRAINT [Users_IT_Equipment] 
    FOREIGN KEY ([user_id]) REFERENCES [Users] ([user_id])
--GO

ALTER TABLE [User_Equipment_History] ADD CONSTRAINT [Equipment_User_Equipment_History] 
    FOREIGN KEY ([equipment_id]) REFERENCES [Equipment] ([equipment_id])
--GO
*/

ALTER TABLE [Problems] ADD CONSTRAINT [Equipment_Problems] 
    FOREIGN KEY ([equipment_id]) REFERENCES [Equipment] ([equipment_id])
GO

ALTER TABLE [Problems] ADD CONSTRAINT [Users_Problems] 
    FOREIGN KEY ([user_id]) REFERENCES [Users] ([user_id])
GO

ALTER TABLE [Equipment] ADD CONSTRAINT [Ref_Equipment_Types_IT_Equipment] 
    FOREIGN KEY ([equipment_type_code]) REFERENCES [Ref_Equipment_Types] ([equipment_type_code])
GO

ALTER TABLE [Problem_History] ADD CONSTRAINT [Ref_Problem_Status_Codes_Equipment_Problem_History] 
    FOREIGN KEY ([problem_status_code]) REFERENCES [Ref_Problem_Status_Codes] ([problem_status_code])
GO

ALTER TABLE [Problem_History] ADD CONSTRAINT [Equipment_Problem_Reports_Equipment_Problem_History] 
    FOREIGN KEY ([problem_id]) REFERENCES [Problems] ([problem_id])
GO

ALTER TABLE [Problem_History] ADD CONSTRAINT [Support_Staff_Equipment_Problem_History] 
    FOREIGN KEY ([assigned_staff_id]) REFERENCES [Support_Staff] ([staff_id])
GO

ALTER TABLE [Problem_History] ADD CONSTRAINT [Ref_Priority_Levels_Problem_History] 
    FOREIGN KEY ([priority_level_code]) REFERENCES [Ref_Priority_Levels] ([priority_level_code])
GO

ALTER TABLE [Resolutions] ADD CONSTRAINT [Equipment_Problem_History_Resolutions] 
    FOREIGN KEY ([problem_history_id]) REFERENCES [Problem_History] ([problem_history_id])
GO

ALTER TABLE [Staff_Skills] ADD CONSTRAINT [Support_Staff_Staff_Skills] 
    FOREIGN KEY ([staff_id]) REFERENCES [Support_Staff] ([staff_id])
GO

ALTER TABLE [Staff_Skills] ADD CONSTRAINT [Ref_Skill_Codes_Staff_Skills] 
    FOREIGN KEY ([skill_code]) REFERENCES [Ref_Skill_Codes] ([skill_code])
GO



/* ---------------------------------------------------------------------- */
/* Load Sample Data into Tables                                           */
/* ---------------------------------------------------------------------- */


INSERT INTO Ref_Equipment_Types (equipment_type_code,equipment_type_description)
VALUES                          ('PDA','Personal Digital Assistant')
GO

SELECT 'Ref_Equipment_Types' As Table_Name, *
FROM    Ref_Equipment_Types
GO



INSERT INTO Ref_Priority_Levels (priority_level_code,priority_level_description)
VALUES                          ('Hi'               ,'High'                    )
GO

INSERT INTO Ref_Priority_Levels (priority_level_code,priority_level_description)
VALUES                          ('Med'              ,'Medium'                  )
GO

INSERT INTO Ref_Priority_Levels (priority_level_code,priority_level_description)
VALUES                          ('Low'              ,'Low'                  )
GO

SELECT 'Ref_Priority_Levels' As Table_Name, *
FROM Ref_Priority_Levels
GO


INSERT INTO Ref_Problem_Status_Codes (problem_status_code,problem_status_description)
VALUES                               ('ASSND'            ,'Assigned'                )
GO

INSERT INTO Ref_Problem_Status_Codes (problem_status_code,problem_status_description)
VALUES                               ('OPEN'            ,'Open'                     )
GO

INSERT INTO Ref_Problem_Status_Codes (problem_status_code,problem_status_description)
VALUES                               ('CLSD'            ,'Closed'                   )
GO

SELECT 'Ref_Problem_Status_Codes' As Table_Name, *
FROM    Ref_Problem_Status_Codes
GO


INSERT INTO Ref_Skill_Codes (skill_code,skill_description        )
VALUES                      ('DBA'     ,'Database Administration')
GO

INSERT INTO Ref_Skill_Codes (skill_code,skill_description        )
VALUES                      ('Telecomms'    ,'Telecomms')
GO

SELECT 'Ref_Skill_Codes' As Table_Name, *
FROM    Ref_Skill_Codes
GO


INSERT INTO Ref_User_Types (user_type_code,user_type_description)
VALUES                     ('Admin'       ,'Administrative and Managerial')
GO

INSERT INTO Ref_User_Types (user_type_code,user_type_description)
VALUES                     ('Prof'       ,'Professional')
GO

INSERT INTO Ref_User_Types (user_type_code,user_type_description)
VALUES                     ('Tech'       ,'Technical')
GO

SELECT 'Ref_User_Types' As Table_Name, *
FROM    Ref_User_Types
GO


INSERT INTO Support_Staff (date_joined,date_left,staff_name
                          ,staff_phone,staff_email,staff_location,other_staff_details)
VALUES                    ('01/01/2003',NULL,'John Doe'
                          ,NULL       ,NULL       ,'HQ'          ,NULL               )
GO

SELECT 'Support_Staff' As Table_Name,*
FROM    Support_Staff
GO


INSERT INTO Staff_Skills (staff_id,skill_code,date_skill_obtained)
VALUES                   (1       ,'DBA'     ,'01/01/2004')
GO

SELECT 'Staff_Skills' As Table_Name,*
FROM    Staff_Skills
GO

INSERT INTO Equipment (equipment_type_code,date_equipment_acquired,date_equipment_disposed
                      ,equipment_code,equipment_name,equipment_description
                      ,manufacturer_name,other_details)
VALUES                ('PDA'              ,'01/01/2006',NULL
                      ,'MIO 701'     ,'701 Personal Digital Assistant','Hand-held PDA with GPS'
                      ,'Mitac'          ,NULL)
GO

SELECT 'Equipment' As Table_Name,*
FROM    Equipment
GO

INSERT INTO Users(user_type_code,user_first_name,user_last_name,user_phone,user_email,address,other_user_details)
VALUES           ('Admin'       ,'Jane'         ,'Doe'         ,'Ext.777' ,'jane.doe@widgetcorp.con',NULL,NULL  )
GO

SELECT 'Users' As Table_name,* 
FROM    Users
GO



INSERT INTO Problems (equipment_id,user_id,problem_reported_datetime,problem_description)
VALUES               (1            ,1      ,'11/11/2006','PDA fails after 2 hours usage')
GO

SELECT 'Problems' As Table_Name,*
FROM    Problems
GO

INSERT INTO Problem_History (priority_level_code,problem_id,problem_status_code,assigned_staff_id,fix_datetime)
VALUES                      ('Hi'               ,1         ,'Open'             ,1                ,'11/12/2006')
GO

SELECT 'Problem_History' As Table_Name,*
FROM    Problem_History
GO

INSERT INTO Resolutions (problem_history_id,resolution_description      )
VALUES                  (1                 ,'Provided back-up Batteries')
GO

SELECT 'Resolutions' As Table_Name,*
FROM    Resolutions
GO


