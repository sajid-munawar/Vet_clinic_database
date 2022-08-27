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
    id SERIAL PRIMARY KEY NOT NULL,
    full_name varchar(100) NOT NULL,
    age int NOT NULL
);

CREATE TABLE species(
    id SERIAL PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL
);

CREATE TABLE vets ( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id) 
);

-- Create a join table named specializations
CREATE TABLE specializations (
    vets_id INT,
    species_id INT,
    PRIMARY KEY(vets_id, species_id),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);


-- Create a join table named visits
CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    PRIMARY KEY(animals_id,vets_id,date_of_visit),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);