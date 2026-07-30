SELECT *
FROM world_life_expectancy
;


SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#Comparing the minimum and maximum life expectancy by the highest years added
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) as Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

#Comparing the life expectancy by the lowest years added 
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) as Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

#Checking the average life expectancy by year
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

SELECT *
FROM world_life_expectancy
;

#Comparing average life expectancy and GDP
SELECT Country, ROUND(AVG(`Life Expectancy`),1) AS Life_Expectancy,
ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
AND GDP > 0
ORDER BY GDP ASC
;

#Comparing average life expectancy and GDP
SELECT Country, ROUND(AVG(`Life Expectancy`),1) AS Life_Expectancy,
ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
AND GDP > 0
ORDER BY GDP DESC
;


SELECT *
FROM world_life_expectancy
ORDER BY GDP
;


#If GPD is higher than mid GDP ~1500 give it a 1 if its lower give it a 0
SELECT 
SUM(CASE
	WHEN GDP >= 1500 THEN 1
    ELSE 0
END) High_GDP_Count
FROM world_life_expectancy
;

#Comparing the high GDP and Life Expectancy to the Low GDP Expectancy
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;



#Comparing the life expectancy to the status of the country
SELECT Status, ROUND(AVG(`Life Expectancy`), 1)
FROM world_life_expectancy
GROUP BY Status
;

#How many countries are listed as developed or developing
SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;


SELECT Status, COUNT(DISTINCT Country),ROUND(AVG(`Life Expectancy`), 1)
FROM world_life_expectancy
GROUP BY Status
;

#Comparing the BMI to the life expectancy
SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

SELECT *
FROM world_life_expectancy
;

#Comparing the adult mortality to the life expectancy
SELECT Country, 
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE'%United%'
;

