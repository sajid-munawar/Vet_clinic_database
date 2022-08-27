/*Queries that provide answers to the questions from all projects.*/

-- display ANIMALS that their names end with 'mon'
SELECT *
FROM ANIMALS
WHERE NAME LIKE '%mon';

-- display ANIMALS born between 2016 and 2019
SELECT NAME
FROM ANIMALS
WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';

-- display ANIMALS neutered and have attempted escape less than 3 times
SELECT NAME
FROM ANIMALS
WHERE NEUTERED = true AND ESCAPE_ATTEMPTS < 3;

-- display ANIMALS and their date of birth whose name is 'Agumon' or 'Pikachu'
SELECT NAME, DATE_OF_BIRTH
FROM ANIMALS
WHERE NAME IN ('Agumon','Pikachu');

--display ANIMALS that weigh less than 10.5kg and their escape attempts
SELECT NAME, ESCAPE_ATTEMPTS
FROM ANIMALS
WHERE WEIGHT_KG > 10.5;

--display all ANIMALS that has been neutered
SELECT *
FROM ANIMALS
WHERE NEUTERED = TRUE;

-- display all ANIMALS that their name is "Gabumon"
SELECT *
FROM ANIMALS
WHERE NOT NAME = 'Gabumon';

-- display all ANIMALS that weigh between 10.4kg and 17.3kg
SELECT *
FROM ANIMALS
WHERE WEIGHT_KG >= 10.4 AND WEIGHT_KG <= 17.3;

-- Display how many ANIMALS are there
select count(*) from ANIMALS;

-- Display how many ANIMALS that have never tried to escape
select count(escape_attempts) from ANIMALS
where escape_attempts = 0;

-- Display the average weight of ANIMALS
select avg(weight_kg) from ANIMALS;

-- Display who escapes the most, neutered or not neutered ANIMALS
select max(escape_attempts) from ANIMALS;

select name from ANIMALS
where escape_attempts = 7;

-- Display the minimum weight of each type of animal
select species, min(weight_kg), max(weight_kg) from ANIMALS
group by species;

-- Display the average number of escape attempts per animal type of those born between 1990 and 2000
select species, avg(escape_attempts) from ANIMALS
where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;

DELETE * FROM ANIMALS;
BEGIN;
DELETE FROM ANIMALS WHERE name='Blossom';
COMMIT;

DELETE FROM ANIMALS WHERE weight_kg=11;
ROLLBACK;

SAVEPOINT save_point1;
DELETE FROM ANIMALS WHERE name='Agumon';
ROLLBACK to save_point1;

SELECT * FROM ANIMALS;

UPDATE ANIMALS SET weight_kg= weight_kg * -1;
UPDATE ANIMALS SET weight_kg = weight_kg * -1 WHERE weight_kg<0;
COMMIT;

UPDATE ANIMALS 
set species='unspecified';

update ANIMALS
set species = 'digimon'
where name like '%mon';

update ANIMALS
set species = 'pokemon'
where not species = 'digimon';


-- JOIN queries one to many ralationship

-- What ANIMALS belong to Melody Pond?
SELECT name,full_name FROM ANIMALS JOIN owners ON owners_id= owners.id AND owners.full_name='Melody Pond';

-- List of all ANIMALS that are pokemon (their type is Pokemon).
SELECT ANIMALS.name AS Pokemon FROM ANIMALS JOIN species ON species_id=species.id AND name='Pokemon';

-- List all owners and their ANIMALS, remember to include those that don't own any animal.
SELECT name, full_name FROM ANIMALS FULL OUTER JOIN owners owner_id=owners.id;

-- How many ANIMALS are there per species?
SELECT species.name AS species FROM species JOIN ANIMALS ON species.id = species_id GROUP BY species;

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name AS owners, ANIMALS.name AS ANIMALS FROM owners INNER JOIN species ON owners.full_name= 'Jenifer Orwell' AND species.name =' Digimon'INNER  JOIN ANIMALS ON owners.id= owners_id AND species.id= species_id;

-- List all ANIMALS owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name as Owners,ANIMALS.name as ANIMALS FROM owners JOIN  ANIMALS ON   Owners.id = owner_id AND owners.full_name = 'Dean Winchester' AND ANIMALS.escape_attempts = 0;

-- Who owns the most ANIMALS?
SELECT owners.full_name AS Owners,count(*) FROM owners JOIN  ANIMALS ON  owners.id = owner_id GROUP BY Owners ORDER BY count DESC LIMIT 1; 

SELECT owners.full_name AS Owners,count(*) FROM owners JOIN  ANIMALS ON  owners.id = owner_id GROUP BY Owners ORDER BY count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT ANIMALS.name 
  FROM ANIMALS
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON vets_id = vets.id WHERE vets.name = 'William Tatcher'
  ORDER BY date_of_visit DESC LIMIT 1;

  -- How many different ANIMALS did Stephanie Mendez see?
  SELECT COUNT(DISTINCT ANIMALS.name)
  FROM ANIMALS
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet,species.name AS specialization
  FROM vets
  JOIN  specializations ON  vets.id = vets_id 
  JOIN species ON species_id = species.id;

  -- List all ANIMALS that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT ANIMALS.name
  FROM ANIMALS
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON vets_id = vets.id WHERE vets.name = 'Stephanie Mendez' 
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

  -- What animal has the most visits to vets?
SELECT ANIMALS.name, count(*)
  FROM ANIMALS
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON vets_id = vets.id 
  GROUP BY ANIMALS.name ORDER BY count DESC LIMIT 1;

  -- Who was Maisy Smith's first visit?
SELECT ANIMALS.name,date_of_visit
  FROM ANIMALS
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON vets_id = vets.id WHERE vets.name = 'Maisy Smith' 
  ORDER BY date_of_visit LIMIT 1;

  -- Details for most recent visit: animal information, vet information, and date of visit.
SELECT ANIMALS.name,date_of_birth,escape_attempts,neutered,weight_kg,species.name as specie,
      vets.name as vet_name,vets.age as vet_age,date_of_graduation ,date_of_visit
  FROM species 
  JOIN ANIMALS ON ANIMALS.species_id = species.id
  JOIN  visits ON  ANIMALS.id = ANIMALS_id 
  JOIN vets ON visits.vets_id = vets.id
  ORDER BY date_of_visit DESC LIMIT 1;

  -- How many visits were with a vet that did not specialize in that animal's species?
  SELECT vets.name,count(*) 
    FROM visits
    JOIN  vets ON vets.id = visits.vets_id  
    LEFT JOIN specializations ON vets.id = specializations.vets_id WHERE specializations.vets_id IS NULL
    GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT species.name AS specialization,count(*) AS number_of_visits
    FROM species
    JOIN  ANIMALS ON species.id = ANIMALS.species_id
    JOIN visits ON ANIMALS.id  = visits.ANIMALS_id
    JOIN vets ON visits.vets_id = vets.id  WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name ORDER BY number_of_visits DESC LIMIT 1;