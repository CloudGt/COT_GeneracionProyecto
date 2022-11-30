/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          assets_dezign.dez                               */
/* Project name:          Assets Maintenance                              */
/* Author:                Barry Williams                                  */
/* Script type:           Database creation script                        */
/* Created on:            2006-11-04 23:29                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Maintenance_Engineers"                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Maintenance_Engineers] (
    [engineer_id] INTEGER IDENTITY(1,1) NOT NULL,
    [company_id] INTEGER NOT NULL,
    [first_name] NVARCHAR(50),
    [last_name] NVARCHAR(50),
    [other_details] NVARCHAR(2000),
    CONSTRAINT [PK_Maintenance_Engineers] PRIMARY KEY ([engineer_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Assets"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Assets] (
    [asset_id] INTEGER IDENTITY(1,1) NOT NULL,
    [maintenance_contract_id] INTEGER NOT NULL,
    [supplier_company_id] INTEGER NOT NULL,
    [asset_details] NVARCHAR(255),
    [asset_make] NVARCHAR(20),
    [asset_model] NVARCHAR(20),
    [asset_acquired_date] DATETIME,
    [asset_disposed_date] DATETIME,
    [other_asset_details] NVARCHAR(255),
    CONSTRAINT [PK_Assets] PRIMARY KEY ([asset_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Maintenance_Contracts"                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Maintenance_Contracts] (
    [maintenance_contract_id] INTEGER IDENTITY(1,1) NOT NULL,
    [maintenance_contract_company_id] INTEGER NOT NULL,
    [contract_start_date] DATETIME,
    [contract_end_date] DATETIME,
    [other_contract_details] NVARCHAR(255),
    CONSTRAINT [PK_Maintenance_Contracts] PRIMARY KEY ([maintenance_contract_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Fault_Log"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Fault_Log] (
    [fault_log_entry_id] INTEGER IDENTITY(1,1) NOT NULL,
    [asset_id] INTEGER NOT NULL,
    [recorded_by_staff_id] INTEGER NOT NULL,
    [fault_log_entry_datetime] DATETIME,
    [fault_description] NVARCHAR(255),
    [other_fault_details] NVARCHAR(255),
    CONSTRAINT [PK_Fault_Log] PRIMARY KEY ([fault_log_entry_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Staff"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Staff] (
    [staff_id] INTEGER IDENTITY(1,1) NOT NULL,
    [staff_name] NVARCHAR(255),
    [gender] NVARCHAR(1),
    [other_staff_details] NVARCHAR(255),
    CONSTRAINT [PK_Staff] PRIMARY KEY ([staff_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Parts"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Parts] (
    [part_id] INTEGER IDENTITY(1,1) NOT NULL,
    [part_name] NVARCHAR(255),
    [chargeable_yn] NVARCHAR(1),
    [chargeable_amount] NVARCHAR(20),
    [other_part_details] NVARCHAR(255),
    CONSTRAINT [PK_Parts] PRIMARY KEY ([part_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Engineer_Visits"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Engineer_Visits] (
    [engineer_visit_id] INTEGER IDENTITY(1,1) NOT NULL,
    [contact_staff_id] INTEGER,
    [engineer_id] INTEGER NOT NULL,
    [fault_log_entry_id] INTEGER NOT NULL,
    [fault_status_code] NVARCHAR(10) NOT NULL,
    [visit_start_datetime] DATETIME,
    [visit_end_datetime] DATETIME,
    [other_visit_details] NVARCHAR(255),
    CONSTRAINT [PK_Engineer_Visits] PRIMARY KEY ([engineer_visit_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Fault_Log_Parts"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Fault_Log_Parts] (
    [fault_log_entry_id] INTEGER NOT NULL,
    [part_fault_id] INTEGER NOT NULL,
    [fault_status_code] NVARCHAR(10) NOT NULL,
    CONSTRAINT [PK_Fault_Log_Parts] PRIMARY KEY ([fault_log_entry_id], [part_fault_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Part_Faults"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Part_Faults] (
    [part_fault_id] INTEGER IDENTITY(1,1) NOT NULL,
    [part_id] INTEGER NOT NULL,
    [fault_short_name] NVARCHAR(20),
    [fault_description] NVARCHAR(255),
    [other_fault_details] NVARCHAR(255),
    CONSTRAINT [PK_Part_Faults] PRIMARY KEY ([part_fault_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Third_Party_Companies"                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Third_Party_Companies] (
    [company_id] INTEGER IDENTITY(1,1) NOT NULL,
    [company_type_code] NVARCHAR(5) NOT NULL,
    [company_name] NVARCHAR(255),
    [company_address] NVARCHAR(255),
    [other_company_details] NVARCHAR(255),
    CONSTRAINT [PK_Third_Party_Companies] PRIMARY KEY ([company_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Ref_Company_Types"                                          */
/* eg Maintenance Contractor, Supplier                                    */
/* eg Supplier and Maintenance                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Ref_Company_Types] (
    [company_type_code] NVARCHAR(5) NOT NULL,
    [company_type_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Company_Types] PRIMARY KEY ([company_type_code])
)
GO


CREATE TABLE [Ref_Fault_Status] (
    [fault_status_code] NVARCHAR(10) NOT NULL,
    [fault_status_description] NVARCHAR(255),
    CONSTRAINT [PK_Ref_Fault_Status] PRIMARY KEY ([fault_status_code])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Asset_Parts"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Asset_Parts] (
    [asset_id] INTEGER NOT NULL,
    [part_id] INTEGER NOT NULL,
    CONSTRAINT [PK_Asset_Parts] PRIMARY KEY ([asset_id], [part_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Skills"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Skills] (
    [skill_id] INTEGER IDENTITY(1,1) NOT NULL,
    [skill_code] NVARCHAR(20),
    [skill_description] NVARCHAR(255),
    CONSTRAINT [PK_Skills] PRIMARY KEY ([skill_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Skills_Required_To_Fix"                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Skills_Required_To_Fix] (
    [part_fault_id] INTEGER NOT NULL,
    [skill_id] INTEGER NOT NULL,
    CONSTRAINT [PK_Skills_Required_To_Fix] PRIMARY KEY ([part_fault_id], [skill_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Engineer_Skills"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Engineer_Skills] (
    [engineer_id] INTEGER NOT NULL,
    [skill_id] INTEGER NOT NULL,
    CONSTRAINT [PK_Engineer_Skills] PRIMARY KEY ([engineer_id], [skill_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Maintenance_Engineers] ADD CONSTRAINT [Suppliers_and_Maintenance_Companies_Maintenance_Engineers] 
    FOREIGN KEY ([company_id]) REFERENCES [Third_Party_Companies] ([company_id])
GO

ALTER TABLE [Assets] ADD CONSTRAINT [Suppliers_and_Maintenance_Companies_Machines] 
    FOREIGN KEY ([supplier_company_id]) REFERENCES [Third_Party_Companies] ([company_id])
GO

ALTER TABLE [Assets] ADD CONSTRAINT [Maintenance_Contracts_Machines] 
    FOREIGN KEY ([maintenance_contract_id]) REFERENCES [Maintenance_Contracts] ([maintenance_contract_id])
GO

ALTER TABLE [Maintenance_Contracts] ADD CONSTRAINT [Maintenance_Contract_Companies_Maintenance_Contracts] 
    FOREIGN KEY ([maintenance_contract_company_id]) REFERENCES [Third_Party_Companies] ([company_id])
GO

ALTER TABLE [Fault_Log] ADD CONSTRAINT [Staff_Fault_Log] 
    FOREIGN KEY ([recorded_by_staff_id]) REFERENCES [Staff] ([staff_id])
GO

ALTER TABLE [Fault_Log] ADD CONSTRAINT [Machines_Fault_Log] 
    FOREIGN KEY ([asset_id]) REFERENCES [Assets] ([asset_id])
GO

ALTER TABLE [Engineer_Visits] ADD CONSTRAINT [Maintenance_Engineers_Engineer_Visits] 
    FOREIGN KEY ([engineer_id]) REFERENCES [Maintenance_Engineers] ([engineer_id])
GO

ALTER TABLE [Engineer_Visits] ADD CONSTRAINT [Staff_Engineer_Visits] 
    FOREIGN KEY ([contact_staff_id]) REFERENCES [Staff] ([staff_id])
GO

ALTER TABLE [Engineer_Visits] ADD CONSTRAINT [Fault_Log_Engineer_Visits] 
    FOREIGN KEY ([fault_log_entry_id]) REFERENCES [Fault_Log] ([fault_log_entry_id])
GO

ALTER TABLE [Engineer_Visits] ADD CONSTRAINT [Ref_Fault_Status_Engineer_Visits] 
    FOREIGN KEY ([fault_status_code]) REFERENCES [Ref_Fault_Status] ([fault_status_code])
GO

ALTER TABLE [Fault_Log_Parts] ADD CONSTRAINT [Component_Part_Faults_Fault_Log_Components] 
    FOREIGN KEY ([part_fault_id]) REFERENCES [Part_Faults] ([part_fault_id])
GO

ALTER TABLE [Fault_Log_Parts] ADD CONSTRAINT [Fault_Log_Fault_Log_Components] 
    FOREIGN KEY ([fault_log_entry_id]) REFERENCES [Fault_Log] ([fault_log_entry_id])
GO

ALTER TABLE [Fault_Log_Parts] ADD CONSTRAINT [Ref_Fault_Status_Fault_Log_Components] 
    FOREIGN KEY ([fault_status_code]) REFERENCES [Ref_Fault_Status] ([fault_status_code])
GO

ALTER TABLE [Part_Faults] ADD CONSTRAINT [Component_Parts_Component_Part_Faults] 
    FOREIGN KEY ([part_id]) REFERENCES [Parts] ([part_id])
GO

ALTER TABLE [Third_Party_Companies] ADD CONSTRAINT [Ref_Company_Types_Third_Party_Companies] 
    FOREIGN KEY ([company_type_code]) REFERENCES [Ref_Company_Types] ([company_type_code])
GO

ALTER TABLE [Asset_Parts] ADD CONSTRAINT [Machines_Machine_Parts] 
    FOREIGN KEY ([asset_id]) REFERENCES [Assets] ([asset_id])
GO

ALTER TABLE [Asset_Parts] ADD CONSTRAINT [Component_Parts_Machine_Parts] 
    FOREIGN KEY ([part_id]) REFERENCES [Parts] ([part_id])
GO

ALTER TABLE [Skills_Required_To_Fix] ADD CONSTRAINT [Skills_Skills_Required_To_Fix] 
    FOREIGN KEY ([skill_id]) REFERENCES [Skills] ([skill_id])
GO

ALTER TABLE [Skills_Required_To_Fix] ADD CONSTRAINT [Part_Faults_Skills_Required_To_Fix] 
    FOREIGN KEY ([part_fault_id]) REFERENCES [Part_Faults] ([part_fault_id])
GO

ALTER TABLE [Engineer_Skills] ADD CONSTRAINT [Skills_Engineer_Skills] 
    FOREIGN KEY ([skill_id]) REFERENCES [Skills] ([skill_id])
GO

ALTER TABLE [Engineer_Skills] ADD CONSTRAINT [Maintenance_Engineers_Engineer_Skills] 
    FOREIGN KEY ([engineer_id]) REFERENCES [Maintenance_Engineers] ([engineer_id])
GO





/* ---------------------------------------------------------------------- */
/* Load sample data into Skills and Reference Data Tables ...             */
/* ---------------------------------------------------------------------- */


/* Load sample data into Skills Table */
INSERT INTO Skills (skill_code, skill_description)
VALUES             ('ELEC','Electrician'         )
GO

INSERT INTO Skills (skill_code, skill_description)
VALUES             ('MECH','Mechanic'            )
GO

INSERT INTO Skills (skill_code, skill_description)
VALUES             ('IT','Information Technology')
GO

SELECT 'Skills' As Table_Name,* FROM Skills
GO



/* Load Reference data */
INSERT INTO Ref_Company_Types (company_type_code,company_type_description)
VALUES                        ('MAINT'          ,'Maintenance Contractor')
GO

INSERT INTO Ref_Company_Types (company_type_code,company_type_description)
VALUES                        ('SUPPL'          ,'Supplier'              )
GO

SELECT 'Ref_Company_Types' As Table_Name,* 
FROM    Ref_Company_Types
GO


/* ---------------------------------------------------------------------- */
/* Load sample data into table "Ref_Fault_Status"                                           */
/* eg Fixed, Reported, Return Visit Required, Waiting for Spare Part   	  */
/* ---------------------------------------------------------------------- */

INSERT INTO Ref_Fault_Status (fault_status_code,fault_status_description)
VALUES                       ('FXD'            ,'Fixed'                 )
GO

INSERT INTO Ref_Fault_Status (fault_status_code,fault_status_description)
VALUES                       ('RPTD'           ,'Reported'              )
GO

INSERT INTO Ref_Fault_Status (fault_status_code,fault_status_description)
VALUES                       ('RTN'            ,'Return Visit Required' )
GO

INSERT INTO Ref_Fault_Status (fault_status_code,fault_status_description)
VALUES                       ('WAIT'           ,'Waiting for Spare Part')
GO


SELECT 'Ref_Fault_Status' As Table_Name,* 
FROM    Ref_Fault_Status
GO

INSERT INTO Third_Party_Companies (company_type_code,company_name                     ,company_address,other_company_details       )
VALUES                            ('MAINT'          ,'Asset Maintenance Services Inc.',NULL           ,'Address to follow.')
GO

SELECT 'Third_Party_Companies' As Table_Name,* 
FROM    Third_Party_Companies
GO

INSERT INTO Maintenance_Engineers (company_id,first_name,last_name,other_details)
VALUES                            (1         ,'Ray'     ,'Charles','Ray has very highly developed tactile skills.')
GO

SELECT 'Maintenance_Engineers' As Table_Name,* 
FROM    Maintenance_Engineers
GO


INSERT INTO Staff (staff_name,gender,other_staff_details)
VALUES            ('John Doe','M'   ,'John is highly-skilled and very loyal')
GO

SELECT 'Staff' As Table_Name,* 
FROM    Staff
GO

INSERT INTO Maintenance_Contracts (maintenance_contract_company_id, contract_start_date, contract_end_date,other_contract_details)
VALUES                            (1                              ,'01/01/2007'        ,'12/31/2007'     ,'This is the first trial Contract.')
GO

SELECT 'Maintenance_Contracts' As Table_Name,* 
FROM    Maintenance_Contracts
GO

INSERT INTO Assets 
(maintenance_contract_id, supplier_company_id, asset_details      ,asset_make,asset_model   , asset_acquired_date,asset_disposed_date,other_asset_details       )
VALUES             
(1                      , 1                  ,'Bullet-Proof Caddy','Cadillac','Super-Safety','12/31/2007'        , NULL              ,'CEOs personal transport.')
GO

SELECT 'Assets' As Table_Name,* 
FROM    Assets
GO


INSERT INTO Fault_Log (asset_id,recorded_by_staff_id, fault_log_entry_datetime, fault_description                   , other_fault_details           )
VALUES                (1       ,1                   , '02/02/2007'            ,'Intermittent knocking in the engine','Seems to occur at high speeds')
GO

SELECT 'Fault_Log' As Table_Name,* 
FROM    Fault_Log
GO

INSERT INTO Engineer_Visits (contact_staff_id, engineer_id, fault_log_entry_id, fault_status_code, visit_start_datetime, visit_end_datetime, other_visit_details                )
VALUES                      (1               , 1          , 1                 , 'FXD'             , '02/04/2007'        ,'02/04/2007'       ,'Excellent, knowledgeable Engineer.')
GO

SELECT 'Engineer_Visits' As Table_Name,* 
FROM    Engineer_Visits
GO

INSERT INTO Parts ( part_name    ,chargeable_yn,chargeable_amount, other_part_details)
VALUES            ('Caddy Engine','Y'          ,5000.00          ,'A major piece of work')
GO

SELECT 'Parts' As Table_Name,* 
FROM    Parts
GO

INSERT INTO Asset_Parts (asset_id, part_id)
VALUES                  (1       , 1      )
GO

SELECT 'Asset_Parts' As Table_Name,* 
FROM    Asset_Parts
GO

INSERT INTO Part_Faults (part_id,fault_short_name, fault_description      , other_fault_details          )
VALUES                  (1      ,'knocking'      ,'Knocking in the engine','First off - check the Timing')
GO

SELECT 'Part_Faults' As Table_Name,* 
FROM    Part_Faults
GO

INSERT INTO Fault_Log_Parts (fault_log_entry_id, part_fault_id,fault_status_code)
VALUES                      (1                 , 1            ,'FXD'            )
GO

SELECT 'Fault_Log_Parts' As Table_Name,* 
FROM    Fault_Log_Parts
GO

INSERT INTO Skills_Required_To_Fix (part_fault_id,skill_id)
VALUES                             (1            , 1      )
GO

SELECT 'Skills_Required_To_Fix' As Table_Name,* 
FROM    Skills_Required_To_Fix
GO


INSERT INTO Engineer_Skills (engineer_id,skill_id)
VALUES                      (1          ,1       )
GO


SELECT 'Engineer_Skills' As Table_Name,* 
FROM    Engineer_Skills
GO




