
/**********************************************************************
 * NAME: Arjuna Herbst
 * CLASS: CPSC321
 * DATE: 10/15/2023
 * HOMEWORK: HW4
 **********************************************************************/

-- drop table statements ******************************************************

DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS province;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS border;

-- create table statements ******************************************************

CREATE TABLE country(

    country_code CHAR(3),
    country_name CHAR(40),
    gdp BIGINT, 
    inflation FLOAT,
    PRIMARY KEY (country_code)

);

CREATE TABLE province(

    province_name CHAR(40),
    country_code CHAR(3),
    area INT,
    PRIMARY KEY (province_name, country_code),
    FOREIGN KEY (country_code) REFERENCES country(country_code)

);

CREATE TABLE city(

    city_name CHAR(40),
    province_name CHAR(40),
    country_code CHAR(3),
    city_population BIGINT,
    PRIMARY KEY (city_name, province_name, country_code),
    FOREIGN KEY (province_name, country_code) REFERENCES province(province_name, country_code)

);

CREATE TABLE border(

    country_code1 CHAR(3),
    country_code2 CHAR(3),
    border_length INT,
    PRIMARY KEY (country_code1, country_code2),
    FOREIGN KEY (country_code1) REFERENCES country(country_code),
    FOREIGN KEY (country_code2) REFERENCES country(country_code)

);
-- add insert statements ******************************************************

INSERT INTO country VALUES

        ('USA', 'United States of America', 23270000000000, 3.6),
        ('UK', 'United Kingdom', 310000000000, 6.7),
        ('SIN', 'Singapore', 397000000000, 4.0),
        ('CAN', 'Canada', 1988000000000, 3.6);

INSERT INTO province VALUES

        /*USA Provinces*/
        ('Minnesota', 'USA', 300),
        ('Washington', 'USA', 450),
        ('Colorado', 'USA', 350),
        ('California', 'USA', 550),

        /*UK Provinces*/
        ('Manchester', 'UK', 350),
        ('Newcastle', 'UK', 300),
        ('Brighton', 'UK', 400),
        ('York', 'UK', 250), 

        /*CAN Provinces*/
        ('Ontario', 'CAN', 500),
        ('Vancouver', 'CAN', 450),
        ('British Columbia', 'CAN', 400),
        ('Quebec', 'CAN', 550),

        /*SIN Provinces*/
        ('Pasir Ris', 'SIN', 50),
        ('Singapore', 'SIN', 100),
        ('Bukit', 'SIN', 50),
        ('Jurong', 'SIN', 150);


INSERT INTO city VALUES
        
    /*cities in USA provinces */
    /*Minnesota*/  ('Minneapolis', 'Minnesota', 'USA', 300000),('Roseville', 'Minnesota', 'USA', 3000),
                   ('Saint Paul', 'Minnesota', 'USA', 200000),('Arden Hills', 'Minnesota', 'USA', 2000),

    /*Washington*/ ('Seattle', 'Washington', 'USA', 3000000),('Spokane', 'Washington', 'USA', 500000),
                   ('Tacoma', 'Washington', 'USA', 500000),('Pullman', 'Washington', 'USA', 50000),

    /*Colorado*/   ('Denver', 'Colorado', 'USA', 700000),('Vail', 'Colorado', 'USA', 18000),
                   ('Golden', 'Colorado', 'USA', 60000),('City4', 'Colorado', 'USA', 700000),

    /*California*/ ('Los Angeles', 'California', 'USA', 38490000),('San Francisco', 'California', 'USA', 850000),
                   ('Sacremento', 'California', 'USA', 500000),('San Diego', 'California', 'USA', 1340000);


INSERT INTO city VALUES
        
    /*cities in UK provinces */
    /*Manchester*/ ('city1','Manchester', 'UK', 350),('city2','Manchester', 'UK', 350), 
                   ('city3','Manchester', 'UK', 350),('city4','Manchester', 'UK', 350),

    /*Newcastle*/ ('city1','Newcastle', 'UK', 300),('city2','Newcastle', 'UK', 300),
                  ('city3','Newcastle', 'UK', 300),('city4','Newcastle', 'UK', 300),

    /*Brighton*/ ('city1', 'Brighton', 'UK', 400),('city2','Brighton', 'UK', 400), 
                 ('city3', 'Brighton', 'UK', 400),('city4','Brighton', 'UK', 400),

    /*York*/     ('city1','York', 'UK', 250),('city2','York', 'UK', 250), 
                 ('city3', 'York', 'UK', 250),('city4','York', 'UK', 250);


INSERT INTO city VALUES
        
    /*cities in CAN provinces */
    /*Ontario*/  ('city1','Ontario', 'CAN', 500),('city2','Ontario', 'CAN', 500), 
                 ('city3','Ontario', 'CAN', 500),('city4','Ontario', 'CAN', 500),

    /*Vancouver*/  ('city1','Vancouver', 'CAN', 450),('city2','Vancouver', 'CAN', 450), 
                   ('city3','Vancouver', 'CAN', 450),('city4','Vancouver', 'CAN', 450),

    /*British Columbia*/  ('city1','British Columbia', 'CAN', 400),('city2','British Columbia', 'CAN', 400), 
                          ('city3','British Columbia', 'CAN', 400),('city4','British Columbia', 'CAN', 400),

    /*Quebec*/ ('city1','Quebec', 'CAN', 550),('city2','Quebec', 'CAN', 550), 
               ('city3','Quebec', 'CAN', 550),('city4','Quebec', 'CAN', 550);

INSERT INTO city VALUES
        
    /*cities in SIN provinces */
    /*Pasir Ris*/  ('city1','Pasir Ris', 'SIN', 50),('city2','Pasir Ris', 'SIN', 50), 
                   ('city3','Pasir Ris', 'SIN', 50),('city4','Pasir Ris', 'SIN', 50),

    /*Singapore*/  ('city1','Singapore', 'SIN', 100),('city2','Singapore', 'SIN', 100), 
                   ('city3','Singapore', 'SIN', 100),('city4','Singapore', 'SIN', 100),

    /*Bukit*/  ('city1','Bukit', 'SIN', 50),('city2','Bukit', 'SIN', 50), 
               ('city3','Bukit', 'SIN', 50),('city4','Bukit', 'SIN', 50),

    /*Jurong*/  ('city1','Jurong', 'SIN', 150),('city2','Jurong', 'SIN', 150), 
                ('city3','Jurong', 'SIN', 150),('city4','Jurong', 'SIN', 150);

INSERT INTO border VALUES

    ('USA', 'CAN', 6000),
    ('USA', 'UK', 40);



