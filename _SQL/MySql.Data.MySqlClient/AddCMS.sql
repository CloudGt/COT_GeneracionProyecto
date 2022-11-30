
create table site_content (
	site_content_id int not null auto_increment primary key,
    file_name nvarchar(150) not null,
    path nvarchar(150),
    content_type nvarchar(150) default 'text/plain',
    length int,
    data longblob,
    text longtext,
    
    schedule nvarchar(150),
    schedule_exceptions nvarchar(150),

    cache_profile nvarchar(50),

	created_date  datetime,
	modified_date  datetime
);

create index idx_site_content_path on site_content(path);
create index idx_site_content_file_name on site_content(file_name);
create index idx_site_content_file_name_path on site_content(file_name,path);
create index idx_site_content_modified_date on site_content(modified_date);