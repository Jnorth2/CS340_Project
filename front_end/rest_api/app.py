from flask import Flask, render_template, json
import os
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
    return "database"

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 3382))
    app.run(port=port, debug=True)