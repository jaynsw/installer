CREATE TABLE user (
  id char(32) NOT NULL DEFAULT '',
  name varchar(8) NOT NULL DEFAULT '',
  email varchar(40) NOT NULL DEFAULT '',
  pwd char(64) NOT NULL DEFAULT '',
  role char(2) NOT NULL DEFAULT '',
  createTime bigint(20) NOT NULL,
  deleteTime bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (id),
  KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user (id, name, email, pwd, role, createTime, deleteTime)
VALUES
	('2f20e2dfbf2cd676380693b118f9b650', 'Jay', 'jay@abc.com', 'ddfsdfsd33', 'cu', 0, 0),
	('2f20e2dfbf2cd676380693b118f9b651', 'James', 'james@abc.com', 'sfasdfsd322', 'cu', 0, 0);
