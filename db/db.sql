CREATE TABLE channels (
  name varchar(32) primary key not null,
  topic_message varchar(512) null,
  topic_author varchar(128),
  topic_created_on date null,
  topic_updated_on date null,
  created_on date null,
  updated_on date null
);

CREATE TABLE events (
  event_type int not null references types(id),
  channel varchar(32) not null,
  nick varchar(128) not null,
  content varchar(512) null,
  created_at timestamp not null
);
