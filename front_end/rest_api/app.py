from flask import Flask, render_template, json
import os
from dotenv import load_dotenv, find_dotenv
import database.db_connector as db

# Configuration

app = Flask(__name__)
db_connection = db.connect_to_database()

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")

@app.route('/customers')
def customers():
    query = "SELECT * FROM Customers;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("customers.j2", customers = results)
@app.route('/invoices')
def invoices():
    query = "SELECT * FROM Invoices;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("invoices.j2", invoices=results)

@app.route('/products')
def products():
    query = "SELECT * FROM Products;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("products.j2", products=results)

# Listener

if __name__ == "__main__":
    load_dotenv(find_dotenv())
    port = int(os.environ.get('PORT', 3382))
    app.run(port=port, debug=True)
