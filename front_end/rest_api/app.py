from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os
#import app/db_connector as db

app = Flask(__name__)
#db_connection = db.connect_to_database()

app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_northjar'
app.config['MYSQL_PASSWORD'] = 'BI0eNTF2blxy' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_northjar'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"


mysql = MySQL(app)

# Routes
@app.route('/')
def root():
    people_from_app_py =[
    {
        "name": "Thomas",
        "age": 33,
        "location": "New Mexico",
        "favorite_color": "Blue"
    },
    {
        "name": "Gregory",
        "age": 41,
        "location": "Texas",
        "favorite_color": "Red"
    },
    {
        "name": "Vincent",
        "age": 27,
        "location": "Ohio",
        "favorite_color": "Green"
    },
    {
        "name": "Alexander",
        "age": 29,
        "location": "Florida",
        "favorite_color": "Orange"
    }]

    return render_template("main.j2", people=people_from_app_py)

# @app.route('/bsg-people')
# def bsg_people():
#     return "this is bsg_people route"


# Listener
if __name__ == "__main__":

    #Start the app on port 3000, it will be different once hosted
    app.run(port=3382, debug=True)