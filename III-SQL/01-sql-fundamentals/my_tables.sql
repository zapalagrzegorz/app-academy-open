DROP TABLE animals;
DROP TABLE countries;

CREATE TABLE countries(
  id SERIAL PRIMARY KEY,
  name varchar(255) NOT NULL,
  population INTEGER NOT NULL
);
CREATE TABLE animals(
  id SERIAL PRIMARY KEY,
  name varchar(255) NOT NULL,
  country_id INTEGER NOT NULL,
  FOREIGN KEY (country_id) REFERENCES countries
);
INSERT INTO countries (name, population)
VALUES
  ('UNITED STATES', 327000000);
INSERT INTO animals (name, country_id)
VALUES
  (
    'Racoon',
    (
      SELECT
        id
      FROM countries
      WHERE
        name = 'UNITED STATES'
    )
  ),
  (
    'Black Bear',
    (
      SELECT
        id
      FROM countries
      WHERE
        name = 'UNITED STATES'
    )
  ),
  (
    'Bald Eagle',
    (
      SELECT
        id
      FROM countries
      WHERE
        name = 'UNITED STATES'
    )
  );