SELECT *
FROM world_life_expectancy
;


#Checking for duplicates
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;


SELECT *
FROM(
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num > 1
;


#Delete Duplicates
DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
    ) AS Row_Table
    WHERE Row_Num > 1
    )
    ;
    
    
    