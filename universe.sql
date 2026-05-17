cat << 'EOF' > universe.sql
-- Create and connect to the universe database
CREATE DATABASE universe;
\c universe

-- 1. Create Galaxy Table (6+ rows needed)
CREATE TABLE IF NOT EXISTS galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  type VARCHAR(60) NOT NULL,
  size NUMERIC(14,2) NOT NULL,
  has_dark_matter BOOLEAN NOT NULL,
  star_count INT NOT NULL,
  notes TEXT
);

-- 2. Create Star Table (6+ rows needed)
CREATE TABLE IF NOT EXISTS star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  mass NUMERIC(14,5) NOT NULL,
  is_binary BOOLEAN NOT NULL,
  age INT NOT NULL,
  classification VARCHAR(40) NOT NULL,
  description TEXT
);

-- 3. Create Planet Table (12+ rows needed)
CREATE TABLE IF NOT EXISTS planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  star_id INT NOT NULL REFERENCES star(star_id),
  mass NUMERIC(12,4) NOT NULL,
  radius NUMERIC(10,4) NOT NULL,
  is_habitable BOOLEAN NOT NULL,
  orbital_period INT NOT NULL,
  composition TEXT
);

-- 4. Create Moon Table (20+ rows needed)
CREATE TABLE IF NOT EXISTS moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  diameter NUMERIC(10,2) NOT NULL,
  is_tidally_locked BOOLEAN NOT NULL,
  surface_area NUMERIC(14,2) NOT NULL,
  has_atmosphere BOOLEAN NOT NULL,
  notes TEXT
);

-- 5. Create Fifth Table: Nebula (3+ rows needed)
CREATE TABLE IF NOT EXISTS nebula (
  nebula_id SERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  mass NUMERIC(14,3) NOT NULL,
  is_visible BOOLEAN NOT NULL,
  type VARCHAR(60) NOT NULL,
  description TEXT
);

-- ==========================================
-- POPULATE DATA
-- ==========================================

-- Insert into galaxy (6 rows required)
INSERT INTO galaxy (name, type, size, has_dark_matter, star_count, notes) VALUES
('Milky Way', 'Barred Spiral', 105700.00, true, 4000, 'Our home galaxy.'),
('Andromeda', 'Spiral', 220000.00, true, 10000, 'On a collision course with Milky Way.'),
('Triangulum', 'Spiral', 60000.00, true, 400, 'Third largest in the Local Group.'),
('Large Magellanic Cloud', 'Magellanic Spiral', 14000.00, true, 30, 'Satellite of the Milky Way.'),
('Small Magellanic Cloud', 'Dwarf Irregular', 7000.00, true, 3, 'Satellite of the Milky Way.'),
('Sombrero Galaxy', 'Unbarred Spiral', 50000.00, true, 800, 'Features an unusually large central bulge.');

-- Insert into star (6 rows required)
INSERT INTO star (name, galaxy_id, mass, is_binary, age, classification, description) VALUES
('Sun', 1, 1.00000, false, 4600, 'G-type main-sequence star', 'The center of our Solar System.'),
('Sirius', 1, 2.06300, true, 242, 'A-type main-sequence star', 'The brightest star in the night sky.'),
('Alpha Centauri A', 1, 1.10000, true, 5300, 'G-type main-sequence star', 'Part of the closest star system.'),
('Betelgeuse', 1, 16.50000, false, 8, 'Red Supergiant', 'Expected to explode as a supernova.'),
('Andromeda Main', 2, 2.50000, false, 3000, 'Blue Giant', 'Hypothetical core star for structure.'),
('Triangulum Alpha', 3, 1.80000, true, 1500, 'F-type Main Sequence', 'Primary tracking star for Triangulum.');

-- Insert into planet (12 rows required)
INSERT INTO planet (name, star_id, mass, radius, is_habitable, orbital_period, composition) VALUES
('Mercury', 1, 0.0553, 2439.7000, false, 88, 'Rocky, metallic core'),
('Venus', 1, 0.8150, 6051.8000, false, 225, 'Rocky, extreme greenhouse atmosphere'),
('Earth', 1, 1.0000, 6371.0000, true, 365, 'Rocky, nitrogen-oxygen atmosphere'),
('Mars', 1, 0.1070, 3389.5000, false, 687, 'Rocky, iron oxide dust dust'),
('Jupiter', 1, 317.8000, 69911.0000, false, 4333, 'Gas Giant, hydrogen and helium'),
('Saturn', 1, 95.2000, 58232.0000, false, 10759, 'Gas Giant, extensive ring system'),
('Uranus', 1, 14.5000, 25362.0000, false, 30687, 'Ice Giant, tilted axis'),
('Neptune', 1, 17.1000, 24622.0000, false, 60190, 'Ice Giant, strong winds'),
('Sirius Prime', 2, 4.2000, 12000.0000, false, 450, 'Super-Earth, irradiated'),
('Centauri Rock', 3, 0.8500, 5900.0000, true, 12, 'Exoplanet in habitable zone'),
('Betelgeuse Dust', 4, 15.0000, 95000.0000, false, 5000, 'Hot Jupiter, evaporating'),
('Triangulum ExB', 6, 2.1000, 8900.0000, false, 180, 'Rocky, tidally locked');

-- Insert into moon (20 rows required)
INSERT INTO moon (name, planet_id, diameter, is_tidally_locked, surface_area, has_atmosphere, notes) VALUES
('Moon', 3, 3474.20, true, 37930000.00, false, 'Earth''s only natural satellite.'),
('Phobos', 4, 22.20, true, 1548.00, false, 'Mar''s larger inner moon.'),
('Deimos', 4, 12.40, true, 495.00, false, 'Mar''s smaller outer moon.'),
('Io', 5, 3643.20, true, 41910000.00, false, 'Most geologically active body in solar system.'),
('Europa', 5, 3121.60, true, 30900000.00, false, 'Subsurface liquid water ocean present.'),
('Ganymede', 5, 5268.20, true, 87300000.00, true, 'Largest moon in the Solar System.'),
('Callisto', 5, 4820.60, true, 73000000.00, false, 'Heavily cratered, ancient surface.'),
('Mimas', 6, 396.40, true, 500000.00, false, 'Resembles the Death Star due to Herschel crater.'),
('Enceladus', 6, 504.20, true, 800000.00, false, 'Cryovolcanoes vent water ice into space.'),
('Tethys', 6, 1062.00, true, 3550000.00, false, 'Composed almost entirely of water ice.'),
('Dione', 6, 1122.80, true, 3960000.00, false, 'Heavily cratered with bright ice cliffs.'),
('Rhea', 6, 1527.60, true, 7330000.00, false, 'Second-largest moon of Saturn.'),
('Titan', 6, 5149.50, true, 83300000.00, true, 'Dense atmosphere, liquid methane lakes.'),
('Iapetus', 6, 1468.60, true, 6700000.00, false, 'Distinct two-toned coloration.'),
('Miranda', 7, 471.60, true, 700000.00, false, 'Extreme, patched-together topography.'),
('Ariel', 7, 1157.80, true, 4210000.00, false, 'Brightest moon of Uranus.'),
('Umbriel', 7, 1169.40, true, 4300000.00, false, 'Darkest large moon of Uranus.'),
('Titania', 7, 1577.80, true, 7800000.00, false, 'Largest moon of Uranus.'),
('Oberon', 7, 1522.80, true, 7280000.00, false, 'Oldest, most heavily cratered Uranian moon.'),
('Triton', 8, 2706.80, true, 23018000.00, true, 'Retrograde orbit, captured Kuiper belt object.');

-- Insert into nebula (3 rows required)
INSERT INTO nebula (name, galaxy_id, mass, is_visible, type, description) VALUES
('Orion Nebula', 1, 2000.000, true, 'Reflection/Emission', 'Visible to the naked eye.'),
('Crab Nebula', 1, 4.600, true, 'Supernova Remnant', 'Formed from a supernova in 1054 AD.'),
('Eagle Nebula', 1, 15000.000, true, 'Emission', 'Contains the famous Pillars of Creation.');
EOF
