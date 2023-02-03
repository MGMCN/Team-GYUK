from __init__ import db, app
from models import Book
from forms import BookForm, BookUpdateForm
from flask import Blueprint, render_template, redirect, url_for, request

bksfbp = Blueprint('bksfbp',__name__,url_prefix='/books')

@bksfbp.route('/')
def show_all():
   books = Book.query.order_by(Book.bookName.desc()).paginate(page=1, per_page=app.config['ITEMS_PER_PAGE'], error_out=False)
   return render_template('books/index.html', books = books)

@bksfbp.route('/register', methods=['GET','POST'])
def register():

    form = BookForm()

    if form.validate_on_submit():
        book = Book(bookName=form.bookName.data, bookStatus=form.bookStatus.data)
        db.session.add(book)
        db.session.commit()
        return redirect(url_for('bksfbp.show_all'))

    return render_template('books/register.html', form=form)

@bksfbp.route('/books/<int:id>/update', methods=['GET','POST'])
def update(id):
    book = Book.query.get(id)
    form = BookUpdateForm()

    print(book)
    print(book.id)
    print(book.bookName)

    if form.validate_on_submit():

        book.bookName = form.bookName.data
        book.bookStatus = form.bookStatus.data
        db.session.commit()

        return redirect(url_for('bksfbp.show_all'))

    elif request.method == 'GET':
        form.bookName.data = book.bookName
        form.bookStatus.data = book.bookStatus

    return render_template('books/each.html', form=form, id=id)


@bksfbp.route('/books/<int:id>/delete', methods=['GET','POST'])
def delete(id):
    book = Book.query.get(id)
    db.session.delete(book)
    db.session.commit()
    return redirect(url_for('bksfbp.show_all'))
