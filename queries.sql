SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth >='2016/01/01' AND date_of_birth <='2019/12/31';

SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;

SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';

SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;

SELECT * FROM animals WHERE neutered=true;

SELECT * FROM animals WHERE name!='Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- add update/delete queries

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE animals 
SET species = 'Digimon'
WHERE name LIKE '%mon';

UPDATE animals 
SET species = 'Pokemon'
WHERE species IS null;

COMMIT;



BEGIN;

DELETE FROM animals;

ROLLBACK;


BEGIN;

DELETE FROM animals WHERE date_of_birth>'2022/1/1';

SAVEPOINT deleted_after_dob;


UPDATE animals 
SET weight_kg = weight_kg * -1;

ROLLBACK TO deleted_after_dob;

UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0

COMMIT;


-- add AGGREGATE FUNCTIONS queries


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) as avg_escape_attempts FROM animals
WHERE  date_of_birth > '1990/1/1' AND date_of_birth < '2000/12/31'
GROUP BY species;


-- add JOIN queries

SELECT animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners
LEFT OUTER JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) as animal_count 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.id
ORDER BY animal_count DESC
LIMIT 1;
