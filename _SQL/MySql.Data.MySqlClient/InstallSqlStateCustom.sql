create table aspnet_sessions
(
	session_id       nvarchar(80)	not null,
	application_name nvarchar(255)	not null,
	created          datetime	    not null,
	expires          datetime		not null,
	lock_date        datetime		not null,
	lock_id          int		    not null,
	timeout          int		    not null,
	locked           tinyint(1)		not null,
	session_items    mediumblob,
	flags            int	        not null,
    primary key(session_id, application_name) 
)