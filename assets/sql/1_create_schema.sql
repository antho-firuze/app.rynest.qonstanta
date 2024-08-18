CREATE TABLE profile(
  id INTEGER PRIMARY KEY,
  fullname TEXT,
  place_of_birth TEXT,
  date_of_birth TEXT,
  gender INT,
  email TEXT,
  phone TEXT,
  photo_enc TEXT
);

INSERT INTO profile (fullname) VALUES ('');