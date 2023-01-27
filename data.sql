INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Agumon', 'Feb 3, 2020', 0, true, 10.23 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Gabumon', 'Nov 15 2018', 2, true, 8 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Pikachu', 'Jan 7, 2021', 1, false, 15.04 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Devimon', 'May 12, 2017', 5, true, 11 );


INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Charmander', 'Feb 8, 2020', 0, false, -11 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Plantmon', 'Nov 15, 2021', 2, true, -5.7 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Squirtle', 'Apr 2, 1993', 3, false, -12.13 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Angemon', 'Jun 12, 2005', 1, true, -45 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Boarmon', 'Jun 7, 2005', 7, true, 20.4 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Blossom', 'Oct 13, 1998', 3, true, 17 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Ditto', 'May 14, 2022', 4, true, 22 );


BEGIN;

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);


INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon';


UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';

COMMIT;


BEGIN;

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
       ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
       ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
       ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));


SAVEPOINT sp1;


INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (11, 3, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (11, 1, '2021-01-11');

COMMIT;
