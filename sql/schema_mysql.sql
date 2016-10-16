create table if not exists entries (
  id int(11) not null primary key auto_increment,
  title tinytext not null,
  text tinytext not null
);

