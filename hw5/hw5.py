# *********************************************
# Author: Arjuna Herbst
# Date: 2023-10-29
# Project: Homework 5
# *********************************************

import mysql.connector as mc
import config

def main():
    try:
        # set flag for menu loop
        flag = False
        # get connection info
        hst = config.host
        dat = config.database
        usr = config.user
        pwd = config.password
        
        # create connection
        cn = mc.connect(host=hst, database=dat, user=usr, password=pwd)
        
        # result set
        rs = cn.cursor()

        # print menu
        while not flag:
            print("1. List Countries\n" + "2. Add Country\n" + "3. Find countries based on gdp and inflation\n" 
                + "4. Update Country's gdp and Inflation\n" + "5. Exit\n"+ "Enter your choice (1-5):\n")

            # get user input
            userChoice = int(input())

            print("\n")

            # create queries for menu options
            q1 = 'SELECT * FROM country'
            q2_1 = 'SELECT * FROM country WHERE country_code=%s'
            q2_2 = 'INSERT INTO country (country_code, country_name, gdp, inflation) VALUES (%s, %s, %s, %s)'
            q3 = 'SELECT * FROM country WHERE gdp >= %s AND gdp <= %s AND inflation >= %s AND inflation <= %s ORDER BY gdp DESC, inflation ASC'
            q4 = 'UPDATE country SET gdp=%s, inflation=%s WHERE country_code=%s'

            # user selection from menu 
            match userChoice:
                case 1: 
                    rs.execute(q1)
                    for row in rs:
                        print(f'{row[1]}', "("+ f'{row[0]}'+ ")", 
                            "per capita GDP: $"+ f'{row[2]}', "inflation: "+ f'{row[3]}'+ "%\n")
                        
                # add country 
                case 2:
                    # get user input
                    country_code = input("Enter country code: ")
                    name = input("Enter country name: ")
                    gdp = int(input("Enter country's GDP: "))
                    inflation = float(input("Enter country's inflation: "))

                    # check if country already exists
                    rs.execute(q2_1, (country_code,))
                    existing_country = rs.fetchone()

                    if existing_country is None:
                        rs.execute(q2_2, (country_code, name, gdp, inflation))
                        cn.commit()
                        print(f"Country {name} added successfully.\n")

                    else:
                        print(f"Country {name} already exists.\n")

                # find countries w/ inflation & gdp 
                case 3:
                    # get user input
                    min_gdp = int(input("Minimum per capita gdp (USD): "))
                    max_gdp = int(input("Maximum per capita gdp (USD): "))
                    min_inflation = float(input("Minimum inflation (pct): "))
                    max_inflation = float(input("Maximum inflation (pct): "))

                    rs.execute(q3, (min_gdp, max_gdp, min_inflation, max_inflation))
                    for row in rs:
                        print(f'{row[1]}', "("+ f'{row[0]}'+ ")", 
                            "per capita GDP: $"+ f'{row[2]}', "inflation: "+ f'{row[3]}'+ "%\n")
                    print("\n")

                # update country's gdp and inflation
                case 4:
                    # get user input
                    country_code = input("Enter country code: ")
                    new_gdp = int(input("Enter country's new GDP: "))
                    new_inflation = float(input("Enter country's new inflation: "))

                    # check if country exists
                    rs.execute(q2_1, (country_code,))
                    existing_country = rs.fetchone()

                    if existing_country is not None:
                        rs.execute(q4, (new_gdp, new_inflation, country_code))
                        cn.commit()
                        print(f"Country {country_code} updated successfully.\n")
                    else: 
                        print(f"Country with country code {country_code} does not exist.\n")

                    print("\n")

                # exit menu and close connection 
                case 5:
                    print("Disconnecting from database...")
                    flag = True
                           
        #clean up
        rs.close()
        cn.close()
            
    except mc.Error as err:
        print(err)

        
if __name__ == '__main__':
    main()