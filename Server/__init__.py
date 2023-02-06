from config import Config
from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config.from_object(Config)

db = MySQL(app)