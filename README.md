
# 🎵 Spotify Data Analysis using SQL
<p align="center">
<img src="spotify_logo.png" width="700" height="300">
</p>
## 📌 Project Overview

This project focuses on analyzing Spotify music data using PostgreSQL. The goal is to answer real-world business questions and uncover meaningful insights related to tracks, artists, albums, streaming performance, audience engagement, and music characteristics. The project demonstrates practical SQL skills including data exploration, aggregations, subqueries, Common Table Expressions (CTEs), and Window Functions.

## 🎯 Project Objectives

- Analyze track and album performance.
- Explore streaming trends and audience engagement.
- Identify top-performing artists and songs.
- Compare Spotify streams with YouTube views.
- Apply advanced SQL techniques to solve business problems.
- Generate actionable insights from music streaming data.

## Business Value

This analysis helps stakeholders understand:

- Top-performing artists and tracks
- Audience engagement through views, likes, and comments
- Album performance and popularity
- Platform-wise content consumption trends
- Music characteristics such as energy, danceability, and liveness
- 
## 📂 Dataset Information

The dataset contains information about:

- Artists
- Tracks
- Albums
- Album Types
- Danceability
- Energy
- Acousticness
- Liveness
- Tempo
- Views
- Likes
- Comments
- Streams
- Platform Information

## 🗄️ Database Schema

```sql
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
```

# 📊 Business Problems and Solutions

## 🟢 Easy Level

### 1. Retrieve the Names of All Tracks That Have More Than 1 Billion Streams

```sql
SELECT track
FROM spotify
WHERE stream > 1000000000;
```

### 2. List All Albums Along with Their Respective Artists

```sql
SELECT DISTINCT
    album,
    artist
FROM spotify
ORDER BY artist, album;
```

### 3. Get the Total Number of Comments for Tracks Where licensed = TRUE

```sql
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = TRUE;
```

### 4. Find All Tracks That Belong to the Album Type 'single'

```sql
SELECT track
FROM spotify
WHERE album_type = 'single';
```

### 5. Count the Total Number of Tracks by Each Artist

```sql
SELECT
    artist,
    COUNT(*) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;
```

---

## 🟡 Medium Level

### 6. Calculate the Average Danceability of Tracks in Each Album

```sql
SELECT
    album,
    ROUND(AVG(danceability)::numeric, 3) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;
```

### 7. Find the Top 5 Tracks with the Highest Energy Values

```sql
SELECT
    track,
    artist,
    energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;
```

### 8. List All Tracks Along with Their Views and Likes Where official_video = TRUE

```sql
SELECT
    track,
    views,
    likes
FROM spotify
WHERE official_video = TRUE;
```

### 9. For Each Album, Calculate the Total Views of All Associated Tracks

```sql
SELECT
    album,
    SUM(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;
```

### 10. Retrieve the Track Names That Have Been Streamed on Spotify More Than YouTube

```sql
SELECT
    track
FROM spotify
WHERE stream > views;
```

## 🔴 Advanced Level

### 11. Find the Top 3 Most-Viewed Tracks for Each Artist Using Window Functions

```sql
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
```

### 12. Find Tracks Where the Liveness Score Is Above the Average

```sql
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
```

### 13. Calculate the Difference Between the Highest and Lowest Energy Values for Tracks in Each Album

```sql
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
```

### 14. Find Tracks Where the Energy-to-Liveness Ratio Is Greater Than 1.2

```sql
SELECT
    track,
    artist,
    energy,
    liveness,
    ROUND((energy / NULLIF(liveness, 0))::numeric, 2) AS energy_liveness_ratio
FROM spotify
WHERE (energy / NULLIF(liveness, 0)) > 1.2;
```

### 15. Calculate the Cumulative Sum of Likes for Tracks Ordered by Number of Views

```sql
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
```

## 📚 SQL Concepts Covered

- SELECT Statements
- Filtering with WHERE
- GROUP BY
- ORDER BY
- Aggregate Functions
- String Operations
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Running Totals
- Data Analysis Techniques

## 🔍 Key Insights

- Identified tracks with over 1 billion streams.
- Analyzed album-level engagement through views and likes.
- Ranked top-performing tracks for each artist.
- Compared Spotify streaming performance against YouTube views.
- Measured track characteristics using danceability, energy, and liveness metrics.
- Applied advanced SQL techniques to generate meaningful business insights.

## 🏁 Conclusion

This project demonstrates how SQL can be used to analyze music streaming data and answer business-oriented questions. Through the use of PostgreSQL, various analytical techniques were applied to uncover trends in artist performance, audience engagement, track popularity, and music characteristics.

---

⭐ If you found this project useful, consider giving it a star!
