from __init__ import db

class Book(db.Model):
    id = db.Column('bookId', db.Integer, primary_key = True)
    bookName = db.Column(db.String(255))
    bookStatus = db.Column(db.String(255))
    def __repr__(self):
        return '<Book {}>'.format(self.bookName)