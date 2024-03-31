import mysql.connector as mc
import config 

# read config
hst = config.host
dat = config.database
usr = config.user
pwd = config.password

# connect to database
cn = mc.connect(host=hst, database=dat, user=usr, password=pwd)

def main(): 
    try:
        
        # query to create pet table
        # create_pet_table = "CREATE TABLE pet( id INT NOT NULL, name VARCHAR(20), type VARCHAR(20), PRIMARY KEY (id) );"
        # cn._execute_query(create_pet_table)

        # query to insert data into pet table
        insert_pet = "INSERT INTO pet VALUES(8, 'herald', 'cat'), (9, 'fodo', 'dog'), (10, 'bubbles', 'fish'), (11, 'betty', 'bird'), (12, 'bobo', 'chicken'), (13, 'char', 'pig'), (14, 'grape', 'duck');"
        cn._execute_query(insert_pet)

        cn.commit()

        # result set
        rs = cn.cursor()

        # create query
        q1 = "SELECT * FROM pet"

        rs.execute(q1)
        for row in rs:
            print("pet name: " + f'{row[1]}' + ", pet type: " + f'{row[2]}') 

    except mc.Error as e:
        print(e)



if __name__ == "__main__":
    main()