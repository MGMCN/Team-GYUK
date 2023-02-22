from config import Config
from flask import Flask
from flask_mysqldb import MySQL
from enum import Enum

class BookStatus(Enum):
    AVAILABLE = 'available'
    BORROWED = 'borrowed'
class AuthType(Enum):
    MANAGER = 'Manager'
    USER = 'User'

#MySQL Connection
app = Flask(__name__)
# app.config.from_object(Config)
app.config['MYSQL_HOST'] = 'mysql'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'
app.config['MYSQL_DB'] = 'Serverdb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)