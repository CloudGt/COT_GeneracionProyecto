create table aspnet_users 
( 
    user_id raw(16) default sys_guid() not null primary key, 
    user_name varchar2(128) not null, 
    password varchar2(128) not null, 
    email varchar2(128), 
    comments nclob, 
    password_question varchar2(256), 
    password_answer varchar2(128), 
    is_approved number(1,0) default 1 check (is_approved in (1,0)) not null, 
    last_activity_date timestamp not null, 
    last_login_date timestamp not null, 
    last_password_changed_date timestamp not null, 
    creation_date timestamp not null, 
    is_locked_out number(1,0) default 1 check(is_locked_out in (1,0)) not null, 
    last_locked_out_date timestamp not null, 
    pwd_attempt_count int not null, 
    pwd_attempt_window_start timestamp not null, 
    pwd_ans_attempt_count int not null, 
    pwd_ans_attempt_window_start timestamp not null 
);

create table aspnet_roles 
( 
    role_id raw(16) default sys_guid() not null primary key, 
    role_name varchar2(50) 
);

create table aspnet_user_roles 
( 
    user_id raw(16) not null, 
    role_id raw(16) not null, 
    constraint pk_user_roles primary key(user_id, role_id), 
    constraint fk_users foreign key(user_id) references aspnet_users(user_id), 
    constraint fk_roles foreign key(role_id) references aspnet_roles(role_id) 
)