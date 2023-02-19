from __init__ import app, mysql
from auth import authbp
from bksf import bksfbp
import json

app.register_blueprint(authbp)
app.register_blueprint(bksfbp)

@app.route('/test_demo')
def test_demo():
    return "Hello World!"

@app.route('/')
def hello_world():  # put application's code here
    str = "<b>Database Manager</b><br/>"
    str += "<a href='/database_create'>Create Database</a><br/>"
    str += "<a href='/database_drop'>Drop Database</a><br/>"
    return str
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
            `bookStatus` varchar(255) NOT NULL DEFAULT 'available',
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
            UNIQUE KEY `unique_bookId` (`bookId`),
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

# Drop the database, if exist return message
@app.route("/database_drop")
def database_drop():
    try:
        cur = mysql.connection.cursor()
        cur.execute(''' DROP TABLE `Serverdb`.`borrowStatus` ''')
        cur.execute(''' DROP TABLE `Serverdb`.`book` ''')
        cur.execute(''' DROP TABLE `Serverdb`.`user` ''')
        mysql.connection.commit()
        return json.dumps({"processMessage" : "Drop Success", "code": 1})
    except cur.OperationalError:
        return json.dumps({"errorMessage": "Drop failed", "code": 0})
if __name__ == '__main__':
    app.secret_key = 'super secret key'
    app.run(host="0.0.0.0", port=5000)
