/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          tracking_software_problems.dez                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2006-11-15 20:56                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Problems"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problems] (
    [problem_id] INTEGER IDENTITY(1,1) NOT NULL,
    [product_id] INTEGER NOT NULL,
    [reported_by_staff_id] INTEGER NOT NULL,
    [closure_authorised_by_staff_id] INTEGER,
    [date_problem_reported] DATETIME,
    [date_problem_closed] DATETIME,
    [problem_description] NVARCHAR(255) NOT NULL,
    [other_problem_details] NVARCHAR(255),
    CONSTRAINT [PK_Problems] PRIMARY KEY ([problem_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Products"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Products] (
    [product_id] INTEGER IDENTITY(1,1) NOT NULL,
    [product_name] NVARCHAR(80),
    [product_details] NVARCHAR(255),
    CONSTRAINT [PK_Products] PRIMARY KEY ([product_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Problem_Category_Codes"                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problem_Category_Codes] (
    [problem_category_code] NVARCHAR(15) NOT NULL,
    [problem_category_description] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Problem_Category_Codes] PRIMARY KEY ([problem_category_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Staff"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Staff] (
    [staff_id] INTEGER IDENTITY(1,1) NOT NULL,
    [staff_first_name] NVARCHAR(80),
    [staff_last_name] NVARCHAR(80),
    [other_staff_details] NVARCHAR(255),
    CONSTRAINT [PK_Staff] PRIMARY KEY ([staff_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Problem_Status_Codes"                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problem_Status_Codes] (
    [problem_status_code] NVARCHAR(15) NOT NULL,
    [problem_status_description] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Problem_Status_Codes] PRIMARY KEY ([problem_status_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Problem_Log"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Problem_Log] (
    [problem_log_id] INTEGER IDENTITY(1,1) NOT NULL,
    [assigned_to_staff_id] INTEGER,
    [problem_id] INTEGER NOT NULL,
    [problem_category_code] NVARCHAR(15) NOT NULL,
    [problem_status_code] NVARCHAR(15) NOT NULL,
    [log_entry_date] DATETIME,
    [log_entry_description] NVARCHAR(255),
    [log_entry_fix] NVARCHAR(255),
    [other_log_details] NVARCHAR(255),
    CONSTRAINT [PK_Problem_Log] PRIMARY KEY ([problem_log_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */


 ALTER TABLE [Problems] ADD CONSTRAINT [Products_Problems] 
    FOREIGN KEY ([product_id]) REFERENCES [Products] ([product_id])
 GO

 ALTER TABLE [Problems] ADD CONSTRAINT [%relname_2%] 
     FOREIGN KEY ([reported_by_staff_id]) REFERENCES [Staff] ([staff_id])
 GO

 ALTER TABLE [Problems] ADD CONSTRAINT [Staff_Problems] 
    FOREIGN KEY ([closure_authorised_by_staff_id]) REFERENCES [Staff] ([staff_id])
 GO

 ALTER TABLE [Problem_Log] ADD CONSTRAINT [Staff_Problem_Log] 
    FOREIGN KEY ([assigned_to_staff_id]) REFERENCES [Staff] ([staff_id])
 GO


ALTER TABLE [Problem_Log] ADD CONSTRAINT [Problem_Category_Codes_Problem_Log] 
    FOREIGN KEY ([problem_category_code]) REFERENCES [Problem_Category_Codes] ([problem_category_code])
GO

ALTER TABLE [Problem_Log] ADD CONSTRAINT [Problem_Status_Codes_Problem_Log] 
    FOREIGN KEY ([problem_status_code]) REFERENCES [Problem_Status_Codes] ([problem_status_code])
GO


ALTER TABLE [Problem_Log] ADD CONSTRAINT [Problems_Problem_Log] 
   FOREIGN KEY ([problem_id]) REFERENCES [Problems] ([problem_id])
GO


/* ---------------------------------------------------------------------- */
/* Load sample data into table "Problem_Category_Codes"                   */
/* ---------------------------------------------------------------------- */
INSERT INTO Problem_Category_Codes (problem_Category_code, problem_Category_description) 
VALUES                           ('COMMS','Communications')
GO

INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) 
VALUES                           ('DB','Database')
GO

INSERT INTO Problem_category_Codes (problem_category_code, problem_category_description) 
VALUES                           ('MDDLW','Middleware')
GO

/* Check values ... */
SELECT 'Problem_Category_Codes' As Table_Name, *
FROM    Problem_Category_Codes
GO

/* ---------------------------------------------------------------------- */
/* Load sample data into table "Problem_Status_Codes"                     */
/* ---------------------------------------------------------------------- */
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) 
VALUES                           ('RPTD','Reported'                              )
GO

INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) 
VALUES                           ('SLVD','Solved'                                )
GO

INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) 
VALUES                           ('WIP','Work In Progress'                       )
GO

/* Check values ... */
SELECT 'Problem_Status_Codes' As Table_Name, *
FROM    Problem_Status_Codes
GO



/* ---------------------------------------------------------------------- */
/* Load sample data into table "Staff"                                    */
/* ---------------------------------------------------------------------- */
INSERT INTO Staff (staff_first_name, staff_last_name, other_staff_details)
VALUES            ('Joe', 'Bloggs', 'On assignment from England')
GO

INSERT INTO Staff (staff_first_name, staff_last_name, other_staff_details)
VALUES            ('John', 'Doe', 'Probation Tester')
GO


SELECT 'Staff' As Table_Name,*
FROM Staff
GO

/* ---------------------------------------------------------------------- */
/* Load sample data into table "Products"                                 */
/* ---------------------------------------------------------------------- */
INSERT INTO Products ( product_name, product_details) 
VALUES               ('Widget'     ,'Adaptable Widget Controller')
GO

/* Check values ... */
SELECT 'Products' As Table_Name, *
FROM    Products
GO

/* ---------------------------------------------------------------------- */
/* Load sample data into table "Problems"                                 */
/* ---------------------------------------------------------------------- */
INSERT INTO Problems ( product_id, reported_by_staff_id,date_problem_reported,date_problem_closed,problem_description,other_problem_details) 
VALUES               ( 1         , 1                   ,'11/11/2006'         ,NULL,'Intermittent failure in principal Controller',NULL)
GO

/* Check values ... */
SELECT 'Problems' As Table_Name, *
FROM    Problems
GO

/* ---------------------------------------------------------------------- */
/* Load sample data into table "Problem_Log"                                 */
/* ---------------------------------------------------------------------- */
INSERT INTO Problem_Log (assigned_to_staff_id,problem_id, problem_category_code,problem_status_code
                        ,log_entry_date,log_entry_description,log_entry_fix,other_log_details      )
VALUES                  ( 1                   ,1        ,'COMMS'               ,'WIP'              
                        ,'11/11/2006'  ,'Intermittent and impossible to reproduce',NULL,NULL      )
GO

/* Check values ... */
SELECT 'Problem_Log' As Table_Name, *
FROM    Problem_Log
GO



