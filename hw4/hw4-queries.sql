
/**********************************************************************
 * NAME: Arjuna Herbst
 * CLASS: CPSC321   
 * DATE: 10/14/2023
 * HOMEWORK: HW4 
 **********************************************************************/

-- Quesiton 1: 
SELECT *
FROM country
WHERE inflation <= 3.6 AND gdp > 300000000000
ORDER BY inflation ASC;

-- Question 2:

SELECT c.country_code, country_name, inflation, province_name, area
FROM country c, province
WHERE inflation > 3.6 AND area < 250
ORDER BY inflation DESC, c.country_code, area ASC;

-- Question 3:
SELECT country_code, country_name, inflation, province_name, area
FROM country JOIN province USING(country_code)
WHERE inflation > 3.6 AND area < 250
ORDER BY inflation DESC, country_code, area ASC;

-- Question 4:
SELECT DISTINCT C.country_code, C.country_name, P.province_name, P.area
FROM country C, province P, city CT
WHERE C.country_code = P.country_code
  AND P.country_code = CT.country_code
  AND CT.city_population > 50000;

-- Question 5:
SELECT DISTINCT C.country_code, C.country_name, P.province_name, P.area
FROM country C JOIN province P USING(country_code) 
                JOIN city CT ON(P.country_code = CT.country_code)
WHERE C.country_code = P.country_code
  AND P.country_code = CT.country_code
  AND CT.city_population > 50000;

-- Question 6:
SELECT DISTINCT C.country_code, C.country_name, P.province_name, P.area
FROM country C, province P, city CT1, city CT2
WHERE C.country_code = P.country_code
    AND P.country_code = CT1.country_code
    AND P.country_code = CT2.country_code
    AND CT1.city_population > 30000
    AND CT2.city_population > 30000
    AND CT1.city_name != CT2.city_name;

    

-- Question 7:
SELECT DISTINCT C.country_code, C.country_name, P.province_name, P.area
FROM country C JOIN province P USING(country_code) 
                JOIN city CT1 ON(CT1.province_name = P.province_name)
                JOIN city CT2 ON(CT2.province_name = P.province_name)
WHERE C.country_code = P.country_code
    AND P.country_code = CT1.country_code
    AND P.country_code = CT2.country_code
    AND CT1.city_population > 30000
    AND CT2.city_population > 30000
    AND CT1.city_name != CT2.city_name;

-- Question 8:
SELECT C.country_code, P.province_name, CT1.country_code, CT2.country_code, CT1.city_population, CT2.city_population
FROM country C, province P, city CT1, city CT2
WHERE CT1.city_name != CT2.city_name
    OR CT1.country_code != CT2.country_code
    OR CT1.province_name != CT2.province_name;

-- Question 9:
SELECT C1.country_name, C1.country_code 
FROM country C1, country C2, border B
WHERE C1.country_code = B.country_code1
    AND C2.country_code = B.country_code2
    AND C1.gdp > 30000000000
    AND C1.inflation < 3.1
    AND C2.gdp < 25000000000
    AND C2.inflation > 2.0;

-- Question 10:
SELECT C1.country_name, C1.country_code 
FROM country C1 JOIN border B ON(C1.country_code = B.country_code1)
                JOIN country C2 ON(C2.country_code = B.country_code2)
WHERE C1.country_code = B.country_code1
    AND C2.country_code = B.country_code2
    AND C1.gdp > 3000000
    AND C1.inflation < 3.1
    AND C2.gdp < 2500000
    AND C2.inflation > 3.2;

-- Question 11:
/* This query retrieves unique combinations of country code, country name, province name, 
and province area. It does so by performing multiple joins across the country, border, province, 
and city tables. The query filters countries with a GDP greater than 1 billion, inflation less than 
3.0, and cities with a population greater than 5 million. Finally, the results are sorted by country 
code and province name */ 
SELECT DISTINCT C1.country_code, C1.country_name, P.province_name, P.area
FROM country C1 JOIN border B ON C1.country_code = B.country_code1
                JOIN country C2 ON B.country_code2 = C2.country_code
                JOIN province P ON C2.country_code = P.country_code
                JOIN city CT ON P.province_name = CT.province_name 
                    AND P.country_code = CT.country_code
WHERE C1.gdp > 1000000000
    AND C1.inflation < 3.0
    AND CT.city_population > 5000000
ORDER BY C1.country_code, P.province_name;
