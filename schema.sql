/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS (
 ID SERIAL PRIMARY KEY NOT NULL,
 NAME VARCHAR(100) NOT NULL,
 DATE_OF_BIRTH DATE,
 ESCAPE_ATTEMPTS INT,
 NEUTERED BOOLEAN,
 WEIGHT_KG DECIMAL,
 species_id,
 owners_id,
 FOREIGN KEY (owners_id) REFERENCES owners(id),
 FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE owners (
    id int SERIAL PRIMARY KEY NOT NULL,
    full_name varchar(100) NOT NULL,
    age int NOT NULL
);

CREATE TABLE species(
    id int SERIAL PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL
)
