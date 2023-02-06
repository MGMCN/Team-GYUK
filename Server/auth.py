from flask import Blueprint, request, Flask, flash
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash


authbp = Blueprint('authbp',__name__)

authapp = Flask(__name__)

mysql = MySQL(authapp)
  
#register (parameter: email, password, name, authorityType)
@authbp.route('/register', methods=["POST"])
def register():
    try:
    # retrieve the data from the request
        email = request.form["email"]
        password = request.form["password"]
        name = request.form["name"]
        authorityType = request.form["authorityType"]
        # checking the duplicate or the account and store in the datebase
        try:
            # extract the email data from the database
            cur = mysql.connection.cursor()
            cur.execute("INSERT IGNORE INTO user(userId,name,email,pwd,authType) VALUES (%s,%s,%s,%s,%s)",(0,name,email,generate_password_hash(password),authorityType))      
            mysql.connection.commit()
        except cur.IntegrityError:
            return f"missing some value"
        else:
            # Success, go to the login page.
            return 'Success'
    except KeyError:
        # if POST miss some value
        return "Miss Some value"


#login  (parameter: email, password)
@authbp.route('/login', methods=["POST"])
def login():
    return "login"


#logout
@authbp.route('/logout')
def logout():
    return "logout"