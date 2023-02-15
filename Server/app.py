from __init__ import app
from auth import authbp
from bksf import bksfbp
from flask_mysqldb import MySQL

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
            UNIQUE KEY `unique_bookId` (`bookId`),
            KEY `lnk_user_borrowStatus` (`userId`),
            KEY `lnk_book_borrowStatus` (`bookId`),
            CONSTRAINT `lnk_book_borrowStatus` FOREIGN KEY (`bookId`) REFERENCES `book` (`bookId`) ON DELETE CASCADE ON UPDATE CASCADE,
            CONSTRAINT `lnk_user_borrowStatus` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
            );
            ''')
        mysql.connection.commit()
    except cur.OperationalError:

        return 'Hello World!'

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
