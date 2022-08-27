/*Queries that provide answers to the questions from all projects.*/

-- display animals that their names end with 'mon'
SELECT *
FROM ANIMALS
WHERE NAME LIKE '%mon';

-- display animals born between 2016 and 2019
SELECT NAME
FROM ANIMALS
WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';

-- display animals neutered and have attempted escape less than 3 times
SELECT NAME
FROM ANIMALS
WHERE NEUTERED = true AND ESCAPE_ATTEMPTS < 3;

-- display animals and their date of birth whose name is 'Agumon' or 'Pikachu'
SELECT NAME, DATE_OF_BIRTH
FROM ANIMALS
WHERE NAME IN ('Agumon','Pikachu');

--display animals that weigh less than 10.5kg and their escape attempts
SELECT NAME, ESCAPE_ATTEMPTS
FROM ANIMALS
WHERE WEIGHT_KG > 10.5;

--display all animals that has been neutered
SELECT *
FROM ANIMALS
WHERE NEUTERED = TRUE;

-- display all animals that their name is "Gabumon"
SELECT *
FROM ANIMALS
WHERE NOT NAME = 'Gabumon';

-- display all animals that weigh between 10.4kg and 17.3kg
SELECT *
FROM ANIMALS
WHERE WEIGHT_KG >= 10.4 AND WEIGHT_KG <= 17.3;

-- Display how many animals are there
select count(*) from animals;

-- Display how many animals that have never tried to escape
select count(escape_attempts) from animals
where escape_attempts = 0;

-- Display the average weight of animals
select avg(weight_kg) from animals;

-- Display who escapes the most, neutered or not neutered animals
select max(escape_attempts) from animals;

select name from animals
where escape_attempts = 7;

-- Display the minimum weight of each type of animal
select species, min(weight_kg), max(weight_kg) from animals
group by species;

-- Display the average number of escape attempts per animal type of those born between 1990 and 2000
select species, avg(escape_attempts) from animals
where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;

DELETE * FROM animals;
BEGIN;
DELETE FROM animals WHERE name='Bolossom';
COMMIT;

DELETE FROM animals WHERE weight_kg=11;
ROLLBACK;

SAVEPOINT save_point1;
DELETE FROM animals WHERE name='Agumon';
ROLLBACK to save_point1;

SELECT * FROM animals;

UPDATE animals SET weight_kg= weight_kg * -1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg<0;
COMMIT;

UPDATE animals 
set species='unspecified';

update animals
set species = 'digimon'
where name like '%mon';

update animals
set species = 'pokemon'
where not species = 'digimon';

-- JOIN queries one to many ralationship

-- What animals belong to Melody Pond?
SELECT name,full_name FROM animals JOIN owners ON owners_id= owners.id AND owners.full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name AS Pokemon FROM animals JOIN species ON species_id=species.id AND name='Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name FROM animals FULL OUTER JOIN owners owner_id=owners.id;

-- How many animals are there per species?
SELECT species.name AS species FROM species JOIN animals ON species.id = species_id GROUP BY species;

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name AS owners, animals.name AS animals FROM owners INNER JOIN species ON owners.full_name= 'Jenifer Orwell' AND species.name =' Digimon'INNER  JOIN animals ON owners.id= owners_id AND species.id= species_id;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name as Owners,animals.name as Animals FROM owners JOIN  animals ON   Owners.id = owner_id AND owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name AS Owners,count(*) FROM owners JOIN  animals ON  owners.id = owner_id GROUP BY Owners ORDER BY count DESC LIMIT 1; 