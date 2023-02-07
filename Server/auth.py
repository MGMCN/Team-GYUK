from flask import Blueprint, request, Flask, session
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash
import json

# create by zheyuan wei
# update at 2023/02/07

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
        # checking the duplicate or the account and store in the datebase if not insert the value
        try:
            cur = mysql.connection.cursor()
            cur.execute("INSERT IGNORE INTO user(userId,name,email,pwd,authType) VALUES (%s,%s,%s,%s,%s)",(0,name,email,generate_password_hash(password),authorityType))      
            mysql.connection.commit()
        # return if error occurs   
        except cur.IntegrityError:
            return f"missing some value"
        else:
            # Success, go to the login page.
            return 'Register Success'
    except KeyError:
        # if POST miss some value
        return "Miss Some value"


#login  (parameter: email, password)
@authbp.route('/login', methods=["POST"])
def login():
    # retrieve the data from the request
    email = request.form["email"]
    password = request.form["password"]
    error = None
    # check the email duplicate in database
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT * FROM user WHERE email = %s ''',(email,))
    email_db = cur.fetchone()
    # if is input wrong return this
    if email_db is None:
        error = "Incorrect email."
        return error
    elif not check_password_hash(email_db["pwd"], password):
        error = "Incorrect password."
        return error

    if error is None:
        # store the user id in a new session and return to the index
        session.clear()
        session["user_id"] = generate_password_hash(email)
    # return the session key and the authentication type to the frontend
    if email_db["authType"] == "Manager":
        return json.dumps({"session_key": session["user_id"],"authtype": 0})
    else:
        return json.dumps({"session_key": session["user_id"],"authtype": 1})


#logout
@authbp.route('/logout')
def logout():
    # Clear the current session, including the stored user id.
    session.clear()
    return ["Logout Success", session]