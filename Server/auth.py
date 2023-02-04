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
    # retrieve the data from the request
    email = request.form["email"]
    password = request.form["password"]
    name = request.form["name"]
    authorityType = request.form["authorityType"]
    # declare the error message as none
    error = None
    # check the element is empty or not 
    if not email:
        error = "Email is required."
        return error 
    elif not password:
        error = "Password is required."
        return error
    elif not name:
        error = "name is required."
        return error
    # checking the duplicate or the account and store in the datebase
    if error is None:
        try:
            # extract the email data from the database 
            cur = mysql.connection.cursor()
            cur.execute('''SELECT email FROM user''')
            email_list = []
            for i in cur.fetchall():
                email_list.append(i['email'])
            
            if email in email_list:
                return "Email is already registered."
            else:
                # save new account into the database
                cur.execute("INSERT INTO user(userId,name,email,pwd,authType) VALUES (%s,%s,%s,%s,%s)",(0,name,email,generate_password_hash(password),authorityType))      
                mysql.connection.commit()

        except cur.IntegrityError:
            error = f"User {email} is already registered."
        else:
            # Success, go to the login page.
            return 'Success'
    flash(error)


#login  (parameter: email, password)
@authbp.route('/login', methods=["POST"])
def login():
    return "login"


#logout
@authbp.route('/logout')
def logout():
    return "logout"