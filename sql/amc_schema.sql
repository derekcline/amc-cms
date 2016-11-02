
drop database if exists amc;
create database amc;

-- user
use amc;

create table user (
     id int(11) not null primary key auto_increment,
     first_name tinytext not null,
     middle_initial tinytext,
     last_name tinytext not null,
     user_name tinytext not null,
     password tinytext not null,
     email tinytext,
     phone tinytext,
     address text,
     city text,
     state tinytext,
     zip_code tinytext,
     join_date date not null
);

insert into user (id, first_name, middle_initial, last_name, user_name, password, join_date) values (1, "Erik", "", "Tank", "skeletonkey", "temp123!", NOW());

-- grouping

create table grouping (
     id int(11) not null primary key auto_increment,
     name tinytext not null,
     display_name text not null,
     description text,
     type tinytext not null
);

insert into grouping (id, name, display_name, description, type) values (1,"shirt_size", "Shirt Size", "Size of T Shirt", "radio");
insert into grouping (id, name, display_name, description, type) values (2, "phone", "Phone Number", "", "text");


-- attribute

create table attribute (
     id int(11) not null primary key auto_increment,
     grouping_id int(11) not null default 0,
     name varchar(25) not null,
     display_name tinytext not null,
     description text,
     constraint foreign key (grouping_id) references grouping (id) on delete cascade on update cascade
);

insert into attribute (id, grouping_id, name, display_name, description) values (1, 1, "S", "Small", "A Small Mother Fucking TShirt");
insert into attribute (id, grouping_id, name, display_name, description) values (2, 1, "M", "Medium", "A Medium Mother Fucking TShirt");
insert into attribute (id, grouping_id, name, display_name, description) values (3, 1, "L", "Large", "A Large Mother Fucking TShirt");
insert into attribute (id, grouping_id, name, display_name, description) values (4, 1, "XL", "X-Large", "A Extra Large Mother Fucking TShirt");
insert into attribute (id, grouping_id, name, display_name, description) values (5, 2, "home", "Home Phone", "");
insert into attribute (id, grouping_id, name, display_name, description) values (6, 2, "work", "Work Phone", "");



-- user_attribute

create table user_attribute (
     id int(11) not null primary key auto_increment,
     user_id int(11) not null,
     attribute_id int(11) not null,
     value tinytext,
     comment text,
     preferred int(1) not null default 0,
     constraint foreign key (attribute_id) references attribute (id) on delete cascade on update cascade,
     constraint foreign key (user_id) references user (id) on delete cascade on update cascade
     -- primary int(1) not null default 1
);

insert into user_attribute (user_id, attribute_id, value, comment, preferred) values (1, 4, null, "", 0);
insert into user_attribute (user_id, attribute_id, value, comment, preferred) values (1, 5, "480-555-6666", "", 1);
insert into user_attribute (user_id, attribute_id, value, comment, preferred) values (1, 6, "480-555-7777", "", 0);


-- grouping_attribute

create table grouping_attribute (
     id int(11) not null primary key auto_increment,
     grouping_id int(11) not null,
     attribute_id int(11) not null,
     display_order int(1) not null default 1,
     constraint foreign key (attribute_id) references attribute (id) on delete cascade on update cascade,
     constraint foreign key (grouping_id) references grouping (id) on delete cascade on update cascade
);

insert into grouping_attribute (grouping_id, attribute_id, display_order) values (1, 1, 1);
insert into grouping_attribute (grouping_id, attribute_id, display_order) values (1, 2, 2);
insert into grouping_attribute (grouping_id, attribute_id, display_order) values (1, 3, 3);
insert into grouping_attribute (grouping_id, attribute_id, display_order) values (1, 4, 4);
insert into grouping_attribute (grouping_id, attribute_id, display_order) values (2, 5, 1);
insert into grouping_attribute (grouping_id, attribute_id, display_order) values (2, 6, 2);

