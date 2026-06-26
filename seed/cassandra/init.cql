
--
-- TP
--

CREATE KEYSPACE IF NOT EXISTS tp_cassandra
WITH replication = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
};

USE tp_cassandra ;

CREATE TABLE IF NOT EXISTS users (
	user_id uuid PRIMARY KEY,
	email text,
	first_name text,
	last_name text,
	age int,
	city text,
	created_at timestamp,
	tags set<text>
);

CREATE TABLE IF NOT EXISTS sensor_history_by_minute (
    uuid uuid,
    mois text,       -- Format "aaaamm"
    date text,       -- Format "aaaammjj"
    minute smallint,
    temperature float,
    humidite tinyint,
    pression smallint,
    PRIMARY KEY ((uuid), mois, date, minute)
) WITH CLUSTERING ORDER BY (mois ASC, date ASC, minute ASC) ;

CREATE TABLE IF NOT EXISTS measures_by_region (
    uuid        uuid,
    region      text,
    date        text,             -- '20260626'
    heure       smallint,         -- bucket horaire (0 à 23) pour limiter la taille de partition
    minute      smallint,         -- minute dans la journée (0 à 1439)
    temperature float,
    humidite    tinyint,
    pression    smallint,
    PRIMARY KEY ((region, date, heure), minute, uuid)
) WITH CLUSTERING ORDER BY (minute ASC, uuid ASC);

CREATE TABLE IF NOT EXISTS messages_by_conversation (
    conversation_id uuid,
    bucket          text,
    sent_at         timestamp,
    message_id      timeuuid,
    sender_id       uuid,
    content         text,
    PRIMARY KEY ((conversation_id, bucket), sent_at, message_id)
) WITH CLUSTERING ORDER BY (sent_at DESC);

CREATE TABLE IF NOT EXISTS conversations_by_user (
    user_id          uuid,
    last_message_at  timestamp,
    conversation_id  uuid,
    other_user_id    uuid,
    PRIMARY KEY (user_id, last_message_at)
) WITH CLUSTERING ORDER BY (last_message_at DESC);


---
-- Insertion de données de test générées par IA
---
-- ============================================================
-- 25 juin 2026
-- ============================================================
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('ile-de-france', '20260625', 14, 870, 6a2f41a3-c54c-fce8-32d2-000000000001, 24.6, 54, 1013);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('ile-de-france', '20260625', 15, 900, 7c9e6679-7425-40de-944b-e07fc1f90ae7, 24.9, 53, 1013);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('paca', '20260625', 15, 900, 1a3b5c7d-9e0f-4a2b-8c4d-000000000003, 30.5, 37, 1015);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('bretagne', '20260625', 15, 900, 2b4c6d8e-1f3a-5b7c-9d0e-000000000004, 18.6, 78, 1010);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('grand-est', '20260625', 15, 900, 3c5d7e9f-2a4b-6c8d-0e1f-000000000005, 25.9, 53, 1012);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('auvergne-rhone-alpes', '20260625', 15, 930, 4d6e8fa0-3b5c-7d9e-1f2a-000000000006, 14.4, 62, 876);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('nouvelle-aquitaine', '20260625', 15, 900, 5e7fa0b1-4c6d-8e0f-2a3b-000000000007, 26.5, 60, 1013);

-- ============================================================
-- 26 juin 2026
-- ============================================================
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('ile-de-france', '20260626', 15, 900, 6a2f41a3-c54c-fce8-32d2-000000000001, 25.0, 50, 1014);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('ile-de-france', '20260626', 15, 930, 7c9e6679-7425-40de-944b-e07fc1f90ae7, 25.3, 49, 1014);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('paca', '20260626', 14, 870, 1a3b5c7d-9e0f-4a2b-8c4d-000000000003, 29.7, 39, 1014);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('bretagne', '20260626', 15, 930, 2b4c6d8e-1f3a-5b7c-9d0e-000000000004, 19.5, 74, 1010);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('grand-est', '20260626', 15, 930, 3c5d7e9f-2a4b-6c8d-0e1f-000000000005, 26.4, 52, 1012);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('auvergne-rhone-alpes', '20260626', 14, 870, 4d6e8fa0-3b5c-7d9e-1f2a-000000000006, 13.9, 64, 876);
INSERT INTO measures_by_region (region, date, heure, minute, uuid, temperature, humidite, pression) VALUES ('nouvelle-aquitaine', '20260626', 14, 870, 5e7fa0b1-4c6d-8e0f-2a3b-000000000007, 26.0, 59, 1014);

-- ============================================================
-- CAPTEUR 1 : 6a2f41a3-c54c-fce8-32d2-000000000001
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260620', '202606', 480, 19.5, 70, 1010);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260620', '202606', 720, 22.1, 62, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260621', '202606', 480, 20.2, 68, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260621', '202606', 900, 24.3, 55, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260622', '202606', 360, 18.7, 73, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260622', '202606', 780, 23.5, 58, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260623', '202606', 540, 21.0, 65, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260623', '202606', 840, 24.8, 53, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260624', '202606', 420, 19.8, 71, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260624', '202606', 960, 25.4, 51, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260625', '202606', 510, 20.5, 67, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260625', '202606', 870, 24.6, 54, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260626', '202606', 600, 22.5, 60, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (6a2f41a3-c54c-fce8-32d2-000000000001, '20260626', '202606', 900, 25.0, 50, 1014);

-- ============================================================
-- CAPTEUR 2 : 7c9e6679-7425-40de-944b-e07fc1f90ae7
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260620', '202606', 450, 19.2, 71, 1010);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260620', '202606', 750, 22.4, 61, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260621', '202606', 510, 20.5, 67, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260621', '202606', 870, 24.0, 56, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260622', '202606', 390, 18.9, 72, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260622', '202606', 810, 23.7, 57, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260623', '202606', 570, 21.3, 64, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260623', '202606', 930, 25.1, 52, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260624', '202606', 450, 20.0, 70, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260624', '202606', 990, 25.7, 50, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260625', '202606', 540, 20.8, 66, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260625', '202606', 900, 24.9, 53, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260626', '202606', 630, 22.8, 59, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (7c9e6679-7425-40de-944b-e07fc1f90ae7, '20260626', '202606', 930, 25.3, 49, 1014);

-- ============================================================
-- CAPTEUR 3 : Marseille (chaud et sec)
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260620', '202606', 480, 24.5, 50, 1014);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260620', '202606', 840, 28.7, 42, 1014);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260621', '202606', 510, 25.1, 48, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260621', '202606', 900, 29.4, 40, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260622', '202606', 450, 24.8, 49, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260622', '202606', 870, 30.2, 38, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260623', '202606', 540, 25.7, 46, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260623', '202606', 960, 30.8, 36, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260624', '202606', 480, 25.3, 47, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260624', '202606', 930, 31.2, 35, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260625', '202606', 510, 25.9, 45, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260625', '202606', 900, 30.5, 37, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260626', '202606', 540, 26.4, 44, 1015);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (1a3b5c7d-9e0f-4a2b-8c4d-000000000003, '20260626', '202606', 870, 29.7, 39, 1014);

-- ============================================================
-- CAPTEUR 4 : Brest (océanique, humide)
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260620', '202606', 510, 15.2, 87, 1007);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260620', '202606', 870, 17.8, 80, 1008);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260621', '202606', 480, 14.8, 88, 1008);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260621', '202606', 930, 18.4, 78, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260622', '202606', 540, 15.6, 85, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260622', '202606', 900, 18.9, 76, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260623', '202606', 450, 14.5, 89, 1008);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260623', '202606', 870, 17.5, 82, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260624', '202606', 510, 15.1, 86, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260624', '202606', 960, 19.2, 75, 1010);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260625', '202606', 480, 14.9, 87, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260625', '202606', 900, 18.6, 78, 1010);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260626', '202606', 540, 16.0, 83, 1009);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (2b4c6d8e-1f3a-5b7c-9d0e-000000000004, '20260626', '202606', 930, 19.5, 74, 1010);

-- ============================================================
-- CAPTEUR 5 : Strasbourg (continental)
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260620', '202606', 450, 18.4, 65, 1010);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260620', '202606', 870, 24.8, 56, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260621', '202606', 510, 19.0, 63, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260621', '202606', 930, 25.6, 54, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260622', '202606', 480, 18.7, 64, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260622', '202606', 900, 26.3, 52, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260623', '202606', 540, 19.4, 62, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260623', '202606', 960, 27.1, 50, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260624', '202606', 450, 18.9, 64, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260624', '202606', 870, 26.7, 51, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260625', '202606', 510, 19.2, 63, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260625', '202606', 900, 25.9, 53, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260626', '202606', 540, 19.7, 61, 1011);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (3c5d7e9f-2a4b-6c8d-0e1f-000000000005, '20260626', '202606', 930, 26.4, 52, 1012);

-- ============================================================
-- CAPTEUR 6 : Chamonix (montagne, altitude)
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260620', '202606', 480, 7.2, 75, 873);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260620', '202606', 900, 13.4, 65, 874);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260621', '202606', 510, 8.0, 73, 874);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260621', '202606', 930, 14.1, 63, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260622', '202606', 450, 7.5, 76, 874);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260622', '202606', 870, 13.8, 64, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260623', '202606', 540, 8.4, 72, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260623', '202606', 960, 14.6, 61, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260624', '202606', 510, 8.1, 74, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260624', '202606', 900, 15.0, 60, 876);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260625', '202606', 480, 7.9, 73, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260625', '202606', 930, 14.4, 62, 876);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260626', '202606', 540, 8.7, 71, 875);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (4d6e8fa0-3b5c-7d9e-1f2a-000000000006, '20260626', '202606', 870, 13.9, 64, 876);

-- ============================================================
-- CAPTEUR 7 : Bordeaux (océanique tempéré)
-- ============================================================
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260620', '202606', 510, 19.8, 72, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260620', '202606', 870, 25.4, 62, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260621', '202606', 450, 19.3, 73, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260621', '202606', 930, 26.0, 60, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260622', '202606', 540, 20.1, 71, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260622', '202606', 900, 26.7, 58, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260623', '202606', 480, 19.6, 74, 1012);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260623', '202606', 870, 26.3, 61, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260624', '202606', 510, 20.4, 70, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260624', '202606', 960, 27.1, 57, 1014);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260625', '202606', 540, 20.8, 69, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260625', '202606', 900, 26.5, 60, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260626', '202606', 450, 19.9, 72, 1013);
INSERT INTO sensor_history_by_minute (uuid, date, mois, minute, temperature, humidite, pression) VALUES (5e7fa0b1-4c6d-8e0f-2a3b-000000000007, '20260626', '202606', 870, 26.0, 59, 1014);

--
-- Cityflow
--

CREATE KEYSPACE IF NOT EXISTS cityflow 
WITH replication = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
};

USE cityflow ;

-- Table pour Q1 : station_passages
CREATE TABLE station_passages (
	station_id text, day date, timestamp timestamp,
	user_id text, event_type text,
	PRIMARY KEY ((station_id, day), timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);

-- Table pour Q2 : user_passages
CREATE TABLE user_passages (
	user_id text, day date, timestamp timestamp,
	station_id text, event_type text,
	PRIMARY KEY ((user_id), day, timestamp)
) WITH CLUSTERING ORDER BY (day DESC, timestamp DESC);

-- Table pour Q3 : daily_station_stats (pré-agrégée)
CREATE TABLE daily_station_stats (
	station_id text, day date,
	total_passages counter,
	PRIMARY KEY (station_id, day)
);
