create table SITE_CONTENT (
	"SITE_CONTENT_ID" raw(16) default sys_guid() not null primary key,
	"FILE_NAME" varchar2(150) not null,
	"PATH" varchar2(150),
	"CONTENT_TYPE" varchar2(150) default 'text/plain',
	"LENGTH" int,
	"DATA" blob,
	"TEXT" clob,

	"ROLES" varchar2(150),
	"ROLE_EXCEPTIONS" varchar2(150),
	"USERS" varchar2(150),
	"USER_EXCEPTIONS" varchar2(150),

	"SCHEDULE" varchar2(150),
	"SCHEDULE_EXCEPTIONS" varchar2(150),
	
	"CACHE_PROFILE" varchar2(50)
);
create index "SITE_CONTENT_FILE_NAME_IX" on "SITE_CONTENT" ("FILE_NAME");
create index "SITE_CONTENT_FILE_NAME_PATH_IX" on "SITE_CONTENT" ("FILE_NAME", "PATH");
create index "SITE_CONTENT_PATH_IX" on "SITE_CONTENT" ("PATH");
