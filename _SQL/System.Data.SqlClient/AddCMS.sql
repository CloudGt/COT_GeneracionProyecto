create table SiteContent(
    [SiteContentID] uniqueidentifier NOT NULL default (newid()) primary key nonclustered,
    [FileName] nvarchar(200) NOT NULL,
    [Path] nvarchar(200),
    [ContentType] nvarchar(150) default 'text/plain',
    [Length] int,
    [Data] varbinary(max) ,
    [Text] nvarchar(max),
    
    [Schedule] nvarchar(200),
    [ScheduleExceptions] nvarchar(200),

    [CacheProfile] nvarchar(50),

	[CreatedDate]  datetime,
	[ModifiedDate]  datetime

) 

create index IX_SiteContent_FileName on SiteContent(FileName)

create index IX_SiteContent_Path on SiteContent(Path)

create index IX_SiteContent_FileName_Path on SiteContent(FileName, Path)

create index IX_SiteContent_ModifiedDate on SiteContent(ModifiedDate)