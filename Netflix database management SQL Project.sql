-- Netflix Project -- 
DROP TABLE IF EXISTS Netflix;
CREATE TABLE Netflix (
	show_id VARCHAR (6),
	type VARCHAR (10),
	title VARCHAR (150),
	director   VARCHAR(208),
	casts   VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year    INT,
	rating   VARCHAR(10),
	duration    VARCHAR(15),
	listed_in   VARCHAR(100),
	description VARCHAR(250)
);


SELECT * FROM Netflix;


SELECT 
	COUNT(*) as total_content
FROM netflix;


SELECT 
	DISTINCT type
FROM netflix;

SELECT * FROM Netflix

-- 15 Business Problems
1. Count the Number of Movies vs TV Shows
SELECT
	type,
	COUNT(*) as total_content
FROM Netflix
GROUP BY type




2. Find the Most Common Rating for Movies and TV Shows
SELECT
	type,
	rating
FROM 
(
	SELECT 
		type,
	    rating,
		COUNT(*),
		RANK() OVER (PARTITION BY type ORDER BY COUNT (*) DESC) as ranking  
	FROM Netflix
	GROUP BY 1, 2
) as t1
WHERE 
	ranking = 1
-- ORDER BY 1, 3 DESC



3. List All Movies Released in a Specific Year (e.g., 2020)

SELECT * FROM Netflix
WHERE 
	type = 'Movie'
	AND
	release_year = 2020 

-- filter 2020
-- movies 

4. Find the Top 5 Countries with the Most Content on Netflix

SELECT
	UNNEST (STRING_TO_ARRAY (country, ',')) as new_country,
	COUNT(show_id) As Total_content 
From Netflix 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

5. Identify the Longest Movie

SELECT * FROM Netflix 
WHERE
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) FROM Netflix)

6. Find Content Added in the Last 5 Years

SELECT 
	*
FROM Netflix
WHERE
	TO_DATE(date_added, 'Month_DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

SELECT CURRENT_DATE - INTERVAL '5 years'

7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

SELECT * FROM Netflix 
WHERE director LIKE '%Rajiv Chilaka%'


8. List All TV Shows with More Than 5 Seasons

SELECT 
	*
FROM Netflix
WHERE 
	type = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1):: numeric > 5 


9. Count the Number of Content Items in Each Genre

SELECT 
	UNNEST (STRING_TO_ARRAY (listed_in, ','))as genre,
	COUNT(show_id) as total_content 
FROM Netflix 
GROUP BY 1

10.Find each year and the average numbers of content release in India on netflix. 
Return top 5 on average with highest content release

SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as year, 
	COUNT(*)as yearly_content,
	ROUND(
	COUNT(*)::numeric/(SELECT COUNT(*) FROM Netflix WHERE country = 'India')::numeric *100
	,2) as avg_content_per_year
FROM Netflix
WHERE country = 'India'
GROUP BY 1

11. List All Movies that are Documentaries

SELECT * FROM Netflix 
WHERE
	listed_in ILIKE '%documentaries%'


12. Find All Content Without a Director

SELECT * FROM Netflix
WHERE
director IS NULL


13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT * FROM Netflix
WHERE
	casts ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

SELECT
UNNEST (STRING_TO_ARRAY(casts, ',')) as actors,
COUNT(*) as total_content
FROM Netflix
WHERE country ILIKE '%India%'
Group By 1
ORDER BY 2 DESC
LIMIT 10


15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords. 
Label contents with the keyword 'Bad' and the rest as 'Good'. Count how many items fall into each category

WITH new_table
AS
(
SELECT 
*,
	CASE 
	WHEN description ILIKE '%kill%' OR
		description ILIKE '%violence%' THEN 'Bad_Content'
		ELSE 'Good_Content'
	END category
FROM Netflix
)
SELECT
	category,
	COUNT(*) as total_content
FROM new_table 
GROUP BY 1












