/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v4.1.2                     */
/* Target DBMS:           MS SQL Server 2005                              */
/* Project file:          product_catalogs.dez                            */
/* Project name:          Product Catalogs                                */
/* Author:                Barry Williams                                  */
/* Script type:           Database creation script                        */
/* Created on:            2006-11-05 00:22                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Catalogs"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Catalogs] (
    [catalog_id] INTEGER IDENTITY(1,1) NOT NULL,
    [catalog_name] NVARCHAR(50),
    [catalog_publisher] NVARCHAR(80),
    [catalog_description] NVARCHAR(255),
    [date_of_publication] DATETIME,
    [date_of_latest_revision] DATETIME,
    CONSTRAINT [PK_Catalogs] PRIMARY KEY ([catalog_id])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Catalog_Structure"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Catalog_Structure] (
    [catalog_level_number] INTEGER  NOT NULL,
    [catalog_id] INTEGER NOT NULL,
    [catalog_level_name] NVARCHAR(50),
    [catalog_level_description] NVARCHAR(255),
     CONSTRAINT [PK_Catalog_Structure] PRIMARY KEY ([catalog_level_number])
)
GO

/* Example - Product Level */

/* ---------------------------------------------------------------------- */
/* Add table "Catalog_Contents"                                           */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Catalog_Contents] (
    [catalog_entry_id] INTEGER IDENTITY(1,1) NOT NULL,
    [catalog_level_number] INTEGER NOT NULL,
    [parent_entry_id] INTEGER,
    [previous_entry_id] INTEGER,
    [next_entry_id] INTEGER,
    [catalog_entry_name] NVARCHAR(80),
    [manufacturer] NVARCHAR(80),
    [product_reference_number] NVARCHAR(50),
    [product_description] NVARCHAR(255),
    [photo_filename] NVARCHAR(255),
    [price_in_dollars] MONEY,
    [price_in_euros] MONEY,
    [price_in_pounds] MONEY,
    [capacity] NVARCHAR(80),
    [length] NVARCHAR(80),
    [height] NVARCHAR(80),
    [width] NVARCHAR(80),
    [other_details] NVARCHAR(255),
    CONSTRAINT [PK_Catalog_Contents] PRIMARY KEY ([catalog_entry_id])
)
GO


/* ---------------------------------------------------------------------- */
/* Add table "Attribute_Definitions"                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Attribute_Definitions] (
    [attribute_id] INTEGER IDENTITY(1,1) NOT NULL,
    [attribute_name] NVARCHAR(30),
    [attribute_data_type] NVARCHAR(10),
    [attribute_description] NVARCHAR(255),
    CONSTRAINT [PK_Attribute_Definitions] PRIMARY KEY ([attribute_id])
)
GO

/* Sample Data - Internal memory, Megapixels, SKU */




/* ---------------------------------------------------------------------- */
/* Add table "Catalog_Entry_Definitions"                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Catalog_Entry_Definitions] (
    [catalog_level_number] INTEGER NOT NULL,
    [attribute_id] INTEGER NOT NULL,
    CONSTRAINT [PK_Catalog_Entry_Definitions] PRIMARY KEY ([catalog_level_number], [attribute_id])
)
GO

CREATE TABLE [Catalog_Contents_Additional_Attributes] (
    [catalog_entry_id] INTEGER NOT NULL,
    [catalog_level_number] INTEGER NOT NULL,
    [attribute_id] INTEGER NOT NULL,
    [attribute_value] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_Catalog_Contents_Additional_Attributes] PRIMARY KEY ([catalog_entry_id], [catalog_level_number], [attribute_id])
)
GO


/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Catalog_Contents] ADD CONSTRAINT [Catalog_Sructure_Catalog_Contents] 
    FOREIGN KEY ([catalog_level_number]) REFERENCES [Catalog_Structure] ([catalog_level_number])
GO

ALTER TABLE [Catalog_Structure] ADD CONSTRAINT [Catalogs_Catalog_Structure] 
    FOREIGN KEY ([catalog_id]) REFERENCES [Catalogs] ([catalog_id])
GO

ALTER TABLE [Catalog_Entry_Definitions] ADD CONSTRAINT [Catalog_Structure_Catalog_Entry_Definitions] 
    FOREIGN KEY ([catalog_level_number]) REFERENCES [Catalog_Structure] ([catalog_level_number])
GO

ALTER TABLE [Catalog_Entry_Definitions] ADD CONSTRAINT [Attribute_Definitions_Catalog_Entry_Definitions] 
    FOREIGN KEY ([attribute_id]) REFERENCES [Attribute_Definitions] ([attribute_id])
GO


ALTER TABLE [Catalog_Contents_Additional_Attributes] ADD CONSTRAINT [Catalog_Contents_Additional_Attributes_Catalog_Contents] 
    FOREIGN KEY ([catalog_entry_id]) REFERENCES [Catalog_Contents] ([catalog_entry_id])
GO


/* ---------------------------------------------------------------------- */
/* Load sample data - Catalogs                                            */
/* ---------------------------------------------------------------------- */

INSERT INTO Catalogs (catalog_name, catalog_description,date_of_publication)
VALUES              ('Barrys Cosmic Camera Store'  ,'Comprehensive coverage of all popular makes','28-Nov-2006')
GO


SELECT 'Catalogs',* FROM Catalogs
GO


INSERT INTO Attribute_Definitions (attribute_name, attribute_data_type,attribute_description)
VALUES                            ('Memory'       , 'Text'             ,'Internal Memory'   )
GO

INSERT INTO Attribute_Definitions (attribute_name, attribute_data_type,attribute_description)
VALUES                            ('MegaPixels'  , 'Text'             ,'MegaPixels'         )
GO

INSERT INTO Attribute_Definitions (attribute_name, attribute_data_type,attribute_description)
VALUES                            ('SKU'         , 'Text'             ,'Stock Keeping Unit - recommended Best Practice' )
GO

/* ---------------------------------------------------------------------- */
/* Check loaded sample data                                               */
/* ---------------------------------------------------------------------- */
SELECT 'Attribute_Definitions' As Table_Name,*
FROM    Attribute_Definitions
GO

/* ---------------------------------------------------------------------- */
/* Load sample data - Catalog Structure                                   */
/* ---------------------------------------------------------------------- */

/* For example, Digital Compact Cameras */
INSERT INTO Catalog_Structure (catalog_level_number,catalog_id, catalog_level_name, catalog_level_description)
VALUES                        (       1            ,       1  ,'Category'        , 'Top-Level Grouping,eg Digital Compact Cameras, Digital SLRs, Camcorders,etc.')
GO

INSERT INTO Catalog_Structure (catalog_level_number,catalog_id, catalog_level_name, catalog_level_description)
VALUES                        (       2            ,       1  ,'Sub-Category','Digital Compact Cameras,Memory Cards,Digital Accessories,etc.')
GO

INSERT INTO Catalog_Structure (catalog_level_number,catalog_id, catalog_level_name, catalog_level_description)
VALUES                        (       3            ,       1  ,'Product'          ,        'Product'         )
GO

/* ---------------------------------------------------------------------- */
/* Check loaded sample data                                               */
/* ---------------------------------------------------------------------- */
SELECT 'Catalog Structure' As Table_Name,*
FROM    Catalog_Structure
GO

DELETE FROM    Catalog_Contents
GO

/* ---------------------------------------------------------------------- */
/* Load  Catalog_Contents data                                            */
/* ---------------------------------------------------------------------- */
INSERT INTO Catalog_Contents (catalog_level_number,parent_entry_id,previous_entry_id,next_entry_id,catalog_entry_name
                             ,manufacturer,product_reference_number,product_description,price_in_dollars,price_in_euros,price_in_pounds
                             ,capacity,length,height,width,other_details)
VALUES                       (          3         ,0,0,2,NULL
                             ,'Olympus','Camedia C-170','Digital Camera',NULL,NULL,64.97
                             ,NULL,NULL,NULL,NULL,NULL)
GO

INSERT INTO Catalog_Contents (catalog_level_number,parent_entry_id,previous_entry_id,next_entry_id,catalog_entry_name
                             ,manufacturer,product_reference_number,product_description,price_in_dollars,price_in_euros,price_in_pounds
                             ,capacity,length,height,width,other_details)
VALUES                       (          3         ,0,1,3,NULL
                             ,'Olympus','FE110','Digital Camera',NULL,NULL,89.97
                             ,NULL,NULL,NULL,NULL,NULL)
GO

INSERT INTO Catalog_Contents (catalog_level_number,parent_entry_id,previous_entry_id,next_entry_id,catalog_entry_name
                             ,manufacturer,product_reference_number,product_description,price_in_dollars,price_in_euros,price_in_pounds
                             ,capacity,length,height,width,other_details)
VALUES                       (          3         ,0,2,4,NULL
                             ,'Pentax','Optio 50L','Digital Camera',NULL,NULL,89.97
                             ,NULL,NULL,NULL,NULL,NULL)
GO

INSERT INTO Catalog_Contents (catalog_level_number,parent_entry_id,previous_entry_id,next_entry_id,catalog_entry_name
                             ,manufacturer,product_reference_number,product_description,price_in_dollars,price_in_euros,price_in_pounds
                             ,capacity,length,height,width,other_details)
VALUES                       (          3         ,0,3,5,NULL
                             ,'Sony','Cyber-shot S40','Digital Camera',NULL,NULL,99.97
                             ,NULL,NULL,NULL,NULL,NULL)
GO

SELECT 'Catalog_Contents' As Table_Name,*
FROM    Catalog_Contents
GO


/* Internal memory specified for the Olympus FE110 ... */
INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (1               ,3                   ,1           ,'14MB'         )
GO


/* Megapixels specified for the Olympus FE110 ... */
INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (1               ,3                   ,2           ,'4'            )
GO




/* Internal memory specified for the Olympus FE110 ... */
INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (2               ,3                   ,1           ,'28MB'         )
GO


/* Megapixels specified for the Olympus FE110 ... */
INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (2               ,3                   ,2           ,'5'            )
GO




/* No Internal memory specified for the Optio 50L ...
INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (3               ,3                   ,1           ,'28MB'         )
--GO
*/

INSERT INTO Catalog_Contents_Additional_Attributes 
                             (catalog_entry_id,catalog_level_number,attribute_id,attribute_value)
VALUES                       (3               ,3                   ,2           ,'5'            )
GO



SELECT 'Catalog_Contents_Additional_Attributes' As Table_Name,*
FROM    Catalog_Contents_Additional_Attributes
GO

