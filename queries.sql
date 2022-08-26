/*Queries that provide answers to the questions from all projects.*/


SELECT *
FROM ANIMALS
WHERE NAME LIKE '%mon';

SELECT NAME
FROM ANIMALS
WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';

    SELECT NAME
    FROM ANIMALS
    WHERE NEUTERED = true AND ESCAPE_ATTEMPTS < 3;

SELECT NAME, DATE_OF_BIRTH
FROM ANIMALS
WHERE NAME IN ('Agumon','Pikachu');

SELECT NAME, ESCAPE_ATTEMPTS
FROM ANIMALS
WHERE WEIGHT_KG > 10.5;

SELECT *
FROM ANIMALS
WHERE NEUTERED = TRUE;

SELECT *
FROM ANIMALS
WHERE NOT NAME = 'Gabumon';

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