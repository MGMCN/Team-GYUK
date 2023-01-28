from flask import Flask
from auth import authbp
from bksf import bksfbp
from flask_mysqldb import MySQL

app = Flask(__name__)
app.register_blueprint(authbp)
app.register_blueprint(bksfbp)


#MySQL Connection
app.config['MYSQL_HOST'] = '163.221.29.193'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'
app.config['MYSQL_DB'] = 'bookmanagement'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app) 


@app.route('/')
def hello_world():  # put application's code here
   
    return 'Hello World!'

if __name__ == '__main__':
    app.run(debug=True)
