CREATE TABLE aspnet_Sessions
(
	SessionId       nvarchar(80)	NOT NULL,
	ApplicationName nvarchar(255)	NOT NULL,
	Created         DateTime		NOT NULL,
	Expires         DateTime		NOT NULL,
	LockDate        DateTime		NOT NULL,
	LockId          Integer		NOT NULL,
	Timeout         Integer		NOT NULL,
	Locked          bit			NOT NULL,
	SessionItems    varbinary(max),
	Flags           Integer   NOT NULL,
	PRIMARY KEY (SessionId, ApplicationName)
)