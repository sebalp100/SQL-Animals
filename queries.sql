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


-- add "join" tables queries

SELECT animals.name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT animal_id)
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT vets.name, specializations.species_id
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.animal_id) AS visit_count
FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;


SELECT animals.name, MIN(visits.visit_date) as visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name
ORDER BY MIN(visits.visit_date)
LIMIT 1;

SELECT animals.name AS animal_name, animals.date_of_birth, animals.escape_attempts, animals.weight_kg, animals.neutered, animals.species_id, animals.owner_id, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE visits.visit_date = (SELECT MAX(visit_date) FROM visits);

SELECT COUNT(*)
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON specializations.vet_id = vets.id AND specializations.species_id = animals.species_id
WHERE specializations.species_id IS NULL;

SELECT species.name, COUNT(visits.animal_id) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC;
