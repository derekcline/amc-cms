
-- user

create table user (
     id int(11) not null primary key auto_increment,
     first_name tinytext not null,
     middle_initial tinytext,
     last_name tinytext not null,
     email tinytext not null,
     phone tinytext not null
);

-- insert into user (first_name, middle_initial, last_name, email, phone) values ("Erik", "", "Tank", "erik2029@gmail.com", "480-692-1894");

-- select id, first_name, middle_initial, last_name, email, phone from user;


-- attribute

create table attribute (
     id int(11) not null primary key auto_increment,
     grouping_id int(11) not null default 0,
     name varchar(25) not null,
     display_name tinytext not null,
     description text
);

-- insert into attribute (grouping_id, name, display_name, description) values (1, "grouping", "Grouping Name", "This is a grouping.");

-- select id, grouping_id, name, display_name, description from attribute;


-- user_attribute

create table user_attribute (
     id int(11) not null primary key auto_increment,
     user_id int(11) not null,
     attribute_id int(11) not null,
     value tinytext not null,
     comment text
     -- primary int(1) not null default 1
);

-- insert into user_attribute (user_id, attribute_id, value, comment) values (1, 1, "User Attribute", "Comment.");


-- grouping

create table grouping (
     id int(11) not null primary key auto_increment,
     name tinytext not null,
     display_name text not null,
     description text
);

-- insert into grouping (name, display_name, description) values ("grouping", "Grouping", "Description");


-- grouping_option

create table grouping_option (
     id int(11) not null primary key auto_increment,
     grouping_id int(11) not null,
     option_name tinytext not null,
     display text not null,
     description text
);

-- insert into grouping_option (grouping_id, option_name, display, description) values (1, "option_name", "Option", "Description.");

