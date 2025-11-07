# Netflix-_database_management_sql_project
Netflix database management of shows, movies, cast members, and genres using Advanced SQL Techniques 

![Netflix Logo](https://github.com/Ishaan-Guha/Netflix-_database_management_sql_project/blob/main/Netflix%20logo.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives
- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.


## Dataset Link
https://www.kaggle.com/datasets/shivamb/netflix-shows 


## Schema

''' sql 
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
''' 
