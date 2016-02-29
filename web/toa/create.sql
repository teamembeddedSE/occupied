DROP TABLE IF EXISTS data;
CREATE TABLE data
    (id INTEGER PRIMARY KEY   AUTOINCREMENT,
      bathroomID   INTEGER    NOT NULL,
      time      datetime     NOT NULL,
      status        INTEGER
      );
