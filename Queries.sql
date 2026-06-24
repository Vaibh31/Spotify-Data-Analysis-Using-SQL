-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
select * from spotify;
--Query 1
SELECT track
FROM spotify
WHERE stream > 1000000000;

--Query 2
SELECT DISTINCT
    album,
    artist
FROM spotify
ORDER BY artist, album;

--QUERY 3
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = TRUE;

--Query 4
SELECT track
FROM spotify
WHERE album_type = 'single';

--Query 5
SELECT
    artist,
    COUNT(*) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;

--QUERY 6
SELECT
    album,
    ROUND(AVG(danceability)::numeric, 3) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;

--QUERY 7
SELECT
    track,
    artist,
    energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;

--QUERY 8
SELECT
    track,
    views,
    likes
FROM spotify
WHERE official_video = TRUE;

--QUERY 9
SELECT
    album,
    SUM(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;

--QUERY 10
SELECT
    track
FROM spotify
WHERE stream > views;

 --ADVANCED QUERIES--
 
 --QUERY 11
 
 WITH ranked_tracks AS (
    SELECT
        artist,
        track,
        views,
        RANK() OVER (
            PARTITION BY artist
            ORDER BY views DESC
        ) AS rank_num
    FROM spotify
)
SELECT
    artist,
    track,
    views
FROM ranked_tracks
WHERE rank_num <= 3;

--QUERY 12
SELECT
    track,
    artist,
    liveness
FROM spotify
WHERE liveness >
(
    SELECT AVG(liveness)
    FROM spotify
);

--QUERY 13
WITH album_energy AS (
    SELECT
        album,
        MAX(energy) AS max_energy,
        MIN(energy) AS min_energy
    FROM spotify
    GROUP BY album
)
SELECT
    album,
    max_energy,
    min_energy,
    (max_energy - min_energy) AS energy_difference
FROM album_energy
ORDER BY energy_difference DESC;

--QUERY 14
SELECT
    track,
    artist,
    energy,
    liveness,
    ROUND((energy / NULLIF(liveness, 0))::numeric, 2) AS energy_liveness_ratio
FROM spotify
WHERE (energy / NULLIF(liveness, 0)) > 1.2;

--QUERY 15
SELECT
    track,
    artist,
    views,
    likes,
    SUM(likes) OVER (
        ORDER BY views
    ) AS cumulative_likes
FROM spotify
ORDER BY views;
