CREATE TABLE rangers(
    ranger_id INT PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
)

INSERT INTO rangers (ranger_id, name, region) VALUES
  (1, 'Alice Green', 'Northern Hills'),
  (2, 'Bob White', 'River Delta'),
  (3, 'Carol King', 'Mountain Range');


 CREATE TABLE species(
    species_id INT PRIMARY KEY,
    common_name VARCHAR(30),
    scientific_name VARCHAR(50),
    discovery_data DATE,
    conservation_status VARCHAR(30)

 )

 INSERT INTO species (species_id, common_name, scientific_name, discovery_data, conservation_status) VALUES
  (1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  (2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
  (3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  (4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

  CREATE TABLE sightings (
  sighting_id INT PRIMARY KEY,
  species_id INT REFERENCES species(species_id),
  ranger_id INT REFERENCES rangers(ranger_id),
  location VARCHAR(100),
  sighting_time TIMESTAMP,
  notes TEXT
);

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
  (1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
  (2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
  (3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
  (4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


--   SOLVE ONE

INSERT INTO rangers VALUES(4,'Derek Fox', 'Coastal Plains');

-- SOLVE TWO
SELECT COUNT(DISTINCT species_id) AS  unique_species_count FROM sightings;

-- Solve three

SELECT * from sightings WHERE location ILIKE '%Pass%';

-- Solve Four

SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name
ORDER BY r.name;

-- Solve Five

SELECT common_name
FROM species
WHERE species_id NOT IN (
  SELECT DISTINCT species_id FROM sightings
);

-- Solve six
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- solve seven
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_data < '1800-01-01';

-- solve eight
SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- solve nine
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);




 