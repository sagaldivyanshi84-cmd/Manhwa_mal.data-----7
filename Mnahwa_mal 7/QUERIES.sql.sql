-- This query shows highest rated manhwa
WITH highest_rated AS (
       SELECT *
       FROM manhwa_mal
       WHERE score > 8.5)
       
SELECT title, score 
FROM manhwa_mal;	        
-- This query shows popular manhwa list
WITH popular_manhwa AS (
	  SELECT * 
      FROM manhwa_mal
      WHERE popularity > 25000 )
      
SELECT title, popularity
FROM popular_manhwa;
-- This query shows completed manhwa
WITH completed_manhwa AS (
      SELECT *
      FROM manhwa_mal
      WHERE status = "Finished")
      
SELECT COUNT(*) AS total_completed
FROM completed_manhwa;
-- This query shows longest manhwas
WITH long_manhwa AS (
      SELECT *
      FROM manhwa_mal
      WHERE chapters > 300) 

SELECT *
FROM long_manhwa;
-- This query shows calculation of average score
WITH scores AS (
      SELECT score, genres
      FROM manhwa_mal)

SELECT AVG(score) AS avg_score
FROM score;
-- This query shows above average scored manhwa
WITH score AS (
      SELECT AVG(score) AS avg_score
      FROM manhwa_mal)

SELECT title, score
FROM manhwa_mal, score
WHERE score > avg_score;
-- This query shows most popular manhwa
WITH popular AS (
	  SELECT *
      FROM manhwa_mal)

SELECT title,popularity
FROM popular
WHERE popularity > 10000
LIMIT 5 ; 
-- This query shows action manhwa with score greater than 8 
WITH action_manhwa AS (
      SELECT *
      FROM  manhwa_mal
      WHERE genres = "Action")

SELECT title, score, genres
FROM action_manhwa 
WHERE score > 8;
-- This query shows category
WITH categorize AS (
	  SELECT *,
      CASE 
          WHEN score >= 8.5 THEN "Top"
          WHEN score BETWEEN 7 AND 8 THEN "Popular"
          ELSE "Average" 
          END AS category
          FROM manhwa_mal)
          
SELECT title, category
FROM categorize;
-- This query shows highest score and popular manhwa
WITH high_score AS (
      SELECT title, score
      FROM manhwa_mal
      WHERE score > 8),
    
     popular_manhwa AS (
     SELECT title, popularity
     FROM manhwa_mal
     WHERE popularity > 10000)
     
SELECT *
FROM high_score, popular_manhwa;
-- This query shows comparison with maximum score
WITH score AS (
      SELECT MAX(score) AS max_score
      FROM manhwa_mal)
      
SELECT title, score
FROM manhwa_mal, score
WHERE score >= max_score - 0.5;
-- This query shows ranking according to the scores of manhwas
WITH ranks AS (
	  SELECT title, score,
      DENSE_RANK() OVER(ORDER BY score DESC) AS ranking
      FROM manhwa_mal)
      
SELECT *
FROM ranks;
-- This query shows genre-wise average score  
WITH score AS (
      SELECT AVG(score) AS avg_score, genres
      FROM manhwa_mal
      GROUP BY genres) 
        
SELECT *
FROM score;
-- This query prints serial numbers from 1 to 20
WITH numbers AS (
      SELECT 1 AS sno
       
      UNION ALL
      
      SELECT sno + 1
      FROM manhwa_mal
      WHERE sno < 20)
      
 SELECT *
 FROM numbers;
-- This query shows best manhwa per genre 
WITH manhwa AS (
      SELECT *,
      ROW_NUMBER() OVER(PARTITION BY genres 
						ORDER BY score DESC) AS rn
      FROM manhwa_mal) 

SELECT title, score, genres
FROM manhwa;
-- This query shows top 3 popular manhwa
WITH top_manhwa AS (
	  SELECT *,ROW_NUMBER() OVER(ORDER BY popularity DESC) AS rn
      FROM manhwa_mal)
      
SELECT *
FROM top_manhwa
WHERE rn<=3;
-- This query shows difference between score and average score
WITH score AS (
      SELECT AVG(score) AS avg_score
      FROM manhwa_mal)
      
SELECT title, score, avg_score, score-avg_score AS diff
FROM manhwa_mal, score;
-- This query shows trend analysis      
WITH analysis AS (
      SELECT *,
	  CASE
          WHEN score >= 8.5 AND popularity > 30000 THEN "Trending"
          WHEN score >= 7 THEN "Good"
          ELSE "Normal"
          END AS category
          FROM manhwa_mal)       

SELECT title, score, popularity , category
FROM analysis;

