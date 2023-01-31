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


BEGIN;

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(id),
    vet_id INTEGER REFERENCES vets(id),
    UNIQUE (species_id, vet_id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date DATE,
    UNIQUE (animal_id, vet_id, visit_date)
);

COMMIT;


BEGIN;

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_animal_id ON visits(animal_id);
ANALYZE;

SAVEPOINT sp1;

CREATE INDEX idx_vet_id ON visits (vet_id);
ANALYZE;

CREATE INDEX idx_email ON owners (email);

COMMIT;
