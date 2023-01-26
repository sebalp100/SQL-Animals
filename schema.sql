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

CREATE TABLE owners (
 id 			SERIAL PRIMARY KEY,
 full_name 		VARCHAR(255),
 age 			INT
);

CREATE TABLE species (
 id 			SERIAL PRIMARY KEY,
 name 		VARCHAR(100)
);

BEGIN;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

COMMIT;
