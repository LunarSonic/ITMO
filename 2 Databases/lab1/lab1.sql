CREATE TABLE location(
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(30) NOT NULL,
                         coordinate_x REAL NOT NULL CHECK (coordinate_x >= -180 AND coordinate_x <= 180),
                         coordinate_y REAL NOT NULL CHECK (coordinate_y >= -90 AND coordinate_y <= 90));

CREATE TABLE creature(
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(50) NOT NULL,
                         height NUMERIC(5, 2) NOT NULL CHECK (height > 0 AND height < 100),
                         weight NUMERIC(5, 2) NOT NULL CHECK (weight > 0 AND weight <= 10000),
                         kind VARCHAR(20) NOT NULL,
                         is_big BOOLEAN NOT NULL);

CREATE TABLE emotion(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(40) NOT NULL,
                        variety VARCHAR(30) NOT NULL);

CREATE TABLE creature_action(
                        id SERIAL PRIMARY KEY,
                        description VARCHAR(50) NOT NULL,
                        subject VARCHAR(30) NOT NULL);

CREATE TABLE event(
                      id SERIAL PRIMARY KEY,
                      name VARCHAR(50) NOT NULL,
                      description VARCHAR(120) NOT NULL,
                      event_time TIMESTAMP NOT NULL,
                      creature_id INTEGER NOT NULL REFERENCES creature(id),
                      creature_action_id INTEGER NOT NULL REFERENCES creature_action(id),
                      location_id INTEGER NOT NULL REFERENCES location(id),
                      emotion_id INTEGER NOT NULL REFERENCES emotion(id));

INSERT INTO location(name, coordinate_x, coordinate_y)
VALUES ('watering hole', 10.51, -76.2), ('forest', 20.6, 62.45), ('desert', 78.13, 12.345);
INSERT INTO creature(name, height, weight, kind, is_big)
VALUES('Looking at the moon', 94.23, 635, 'Leo', TRUE), ('Simba', 96, 560, 'Leo', TRUE),
      ('Shrek', 45.26, 700.04,'Ogre', TRUE),
      ('Mike Wazowski', 23.55, 98.29, 'Monster', FALSE);
INSERT INTO emotion(name, variety)
VALUES('interest', 'positive'), ('fear', 'negative'), ('delight', 'positive'), ('excitement', 'positive');
INSERT INTO creature_action(description, subject)
VALUES ('see', 'stone'), ('touch', 'stone'), ('admire', 'wonderful view'), ('search for a subject', 'ancient artifact');
INSERT INTO event(name, description, event_time, creature_id, creature_action_id, location_id, emotion_id)
VALUES ('mysterious footprints', 'unusual footprints have appeared in the forest leading deeper into the trees', '2024-07-16 19:15:24', 3, 3, 2, 3),
       ('unusual sound', 'a weird subject near the watering hole made sounds', '2024-05-13 06:30:25', 1, 1, 1, 1),
       ('desert mirage', 'a magnificent desert mirage rises from the sands shimmering in the distance', '2024-06-15 13:50:10', 4, 4, 3, 4);

SELECT * FROM event;
SELECT * FROM emotion;
SELECT * FROM location;
SELECT * FROM creature_action;
SELECT * FROM creature;
