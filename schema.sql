CREATE TABLE animals(
  id                INT GENERATED ALWAYS AS IDENTITY,
  name   		    VARCHAR(100),
  date_of_birth     DATE,
  escape_attempts   INT,
  neutered          BOOL,
  weight_kg		    DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species varchar(100);
