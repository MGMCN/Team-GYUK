from flask import Flask
from auth import authbp
from bksf import bksfbp
from flask_mysqldb import MySQL
import json

app = Flask(__name__)
app.register_blueprint(authbp)
app.register_blueprint(bksfbp)


#MySQL Connection
app.config['MYSQL_HOST'] = 'mysql'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'
app.config['MYSQL_DB'] = 'Serverdb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)


@app.route('/test_demo')
def test_demo():
    return "Hello World!"


@app.route('/')
def hello_world():  # put application's code here
        return 'Hello World!'
# initialize the database, if exist return message
@app.route("/database_create")
def database_create():
    try:
        cur = mysql.connection.cursor()
        cur.execute(''' CREATE TABLE `Serverdb`.`user` (
            `userId` INT NOT NULL AUTO_INCREMENT,
            `name` VARCHAR(255) NOT NULL,
            `email` VARCHAR(255) NOT NULL,
            `pwd` VARCHAR(255) NOT NULL,
            `authType` VARCHAR(255) NOT NULL,
            PRIMARY KEY (`userId`),
            UNIQUE INDEX `userId_UNIQUE` (`userId` ASC),
            UNIQUE INDEX `email_UNIQUE` (`email` ASC));
            ''')
        cur.execute(''' CREATE TABLE `book` (
            `bookName` varchar(255) NOT NULL,
            `bookId` int(255) NOT NULL AUTO_INCREMENT,
            `bookStatus` varchar(255) NOT NULL,
            PRIMARY KEY (`bookId`),
            UNIQUE KEY `unique_bookId` (`bookId`)
            );
            ''')
        cur.execute(''' CREATE TABLE `borrowStatus` (
            `borrowId` int(255) NOT NULL AUTO_INCREMENT,
            `userId` int(255) NOT NULL,
            `bookId` int(255) NOT NULL,
            PRIMARY KEY (`borrowId`),
            UNIQUE KEY `unique_borrowId` (`borrowId`),
            KEY `lnk_user_borrowStatus` (`userId`),
            KEY `lnk_book_borrowStatus` (`bookId`),
            CONSTRAINT `lnk_book_borrowStatus` FOREIGN KEY (`bookId`) REFERENCES `book` (`bookId`) ON DELETE CASCADE ON UPDATE CASCADE,
            CONSTRAINT `lnk_user_borrowStatus` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
            );
            ''')
        mysql.connection.commit()
        return json.dumps({"processMessage" : "Create Success", "code": 1})
    except cur.OperationalError:
        return json.dumps({"errorMessage": "Database Already Exist", "code": 0})
if __name__ == '__main__':
    app.secret_key = 'super secret key'
    app.run(host="0.0.0.0", port=5000)
