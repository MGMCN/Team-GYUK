from flask import Blueprint

authbp = Blueprint('authbp',__name__)

@authbp.route('/login')
def login():
    return "login"