CREATE DATABASE ontheroad;

USE ontheroad;

CREATE TABLE `Person` (
  userId int unsigned not null auto_increment,
  username varchar(64) not null,
  password varchar(20) not null,
  auth bit(2) not null,
  PRIMARY KEY(userId)
);

INSERT INTO `Person` (`userId`, `username`, `password`, `auth`) VALUES
(1, 'admin', '123456', b'01');

CREATE TABLE `Follow` (
  userId1 int unsigned not null,
  userId2 int unsigned not null,
  FOREIGN KEY (userId1) REFERENCES `Person`(userId) ON DELETE CASCADE,
  FOREIGN KEY (userId2) REFERENCES `Person`(userId) ON DELETE CASCADE,
  PRIMARY KEY(userId1, userId2)
);

CREATE TABLE `Location` (
  locationId int unsigned not null auto_increment,
  name varchar(40),
  state varchar(40),
  country varchar(40),
  placeIntro text,
  addTime TIMESTAMP not null default CURRENT_TIMESTAMP(),
  PRIMARY KEY(locationId)
);

CREATE TABLE `Like` (
  locationId int unsigned not null,
  userId int unsigned not null,
  FOREIGN KEY(locationId) REFERENCES `Location`(locationId) ON DELETE CASCADE,
  FOREIGN KEY(userId) REFERENCES `Person`(userId) ON DELETE CASCADE,
  PRIMARY KEY(locationId, userId)
);

CREATE TABLE `Post` (
  postId int unsigned not null auto_increment,
  userId int unsigned not null,
  content text not null,
  addTime TIMESTAMP not null default CURRENT_TIMESTAMP(),
  FOREIGN KEY(userId) REFERENCES `Person`(userId) ON DELETE CASCADE,
  PRIMARY KEY(postId)
);

CREATE TABLE `Note` (
  postId int unsigned not null,
  locationId int unsigned not null,
  score tinyint unsigned,
  title varchar(60),
  FOREIGN KEY(postId) REFERENCES `Post`(postId) ON DELETE CASCADE,
  FOREIGN KEY(locationId) REFERENCES `Location`(locationId) ON DELETE CASCADE,
  PRIMARY KEY(postId)
);

CREATE TABLE `Comment` (
  postId int unsigned not null,
  relatedNoteId int unsigned not null,
  FOREIGN KEY(postId) REFERENCES `Post`(postId) ON DELETE CASCADE,
  FOREIGN KEY(relatedNoteId) REFERENCES `Note`(postId) ON DELETE CASCADE,
  PRIMARY KEY(postId)
);