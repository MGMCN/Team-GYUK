from flask import Blueprint, request, Flask, session
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash
import re
import json

# create by zheyuan wei
# update at 2023/02/07

authbp = Blueprint('authbp', __name__)

authapp = Flask(__name__)

mysql = MySQL(authapp)

session_tmp = {}


# register (parameter: email, password, name, authorityType)
@authbp.route('/register', methods=["POST"])
def register():
    try:
        # retrieve the data from the request
        email = request.form["email"]
        password = request.form["password"]
        name = request.form["name"]
        # authorityType = request.form["authorityType"]
        # checking the email address and the input of name and password
        if is_valid_email(email):
            if password.isspace() or password is '':
                return json.dumps({"errorMessage": "The password input is empty", "code": 0})
            elif name.isspace() or name is '':
                return json.dumps({"errorMessage": "The name input is empty", "code": 0})
            else:
                pass
        else:
            return json.dumps({"errorMessage": "The email input is wrong", "code": 0})

        # checking the duplicate or the account and store in the datebase if not insert the value
        try:
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO user(userId,name,email,pwd,authType) VALUES (%s,%s,%s,%s,%s)",
                        (0, name, email, generate_password_hash(password), 'User'))
            mysql.connection.commit()
        # return if error occurs   
        except cur.IntegrityError:
            return json.dumps({"errorMessage": "Email is already exist", "code": 0})
        else:
            # Success, go to the login page.
            return json.dumps({"processMessage": "Register Successful", "code": 1})
    except KeyError:
        # if POST miss some value
        return json.dumps({"errorMessage": "Missing Some Value", "code": 0})


# module for valid the email format
def is_valid_email(email):
    """Check if email is a valid email address."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None


# login  (parameter: email, password)
@authbp.route('/login', methods=["POST"])
def login():
    # retrieve the data from the request
    email = request.form["email"]
    password = request.form["password"]
    error = None
    # check the email duplicate in database
    cur = mysql.connection.cursor()
    cur.execute(''' SELECT * FROM user WHERE email = %s ''', (email,))
    email_db = cur.fetchone()
    # if is input wrong return this
    if email_db is None:
        error = json.dumps({"errorMessage": "Incorrect email.", "code": 0})
        return error
    elif not check_password_hash(email_db["pwd"], password):
        error = json.dumps({"errorMessage": "Incorrect password.", "code": 0})
        return error

    if error is None:
        # store the user id in a new session and return to the index
        session.clear()
        session["user_id"] = generate_password_hash(email)
        if email in session_tmp.values():
            pass
        else:
            session_tmp[session["user_id"]] = email
            # return the session key and the authentication type to the frontend
    if email_db["authType"] == "Manager":
        return json.dumps(
            {"session_key": session["user_id"], "authtype": 0, "processMessage": "Login Successful", "code": 1})
    else:
        return json.dumps(
            {"session_key": session["user_id"], "authtype": 1, "processMessage": "Login Successful", "code": 1})


# @authbp.route('/tmp')
# def tmp():
#     return json.dumps(session_tmp)


# logout
@authbp.route('/logout', methods=["POST"])
def logout():
    # Clear the current session, including the stored user id.
    session.clear()
    skey = request.form["session_key"]
    session_tmp.pop(skey)
    return json.dumps({"processMessage": "Logout Successful", "code": 1})
