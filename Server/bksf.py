from Server import db, app
from Server.models import Book
from Server.forms import BookForm, BookUpdateForm
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

"""
@bksfbp.route('/', methods=['GET'])
def index():
    books = Book.query.order_by(Book.date.desc()).paginate(page=1, per_page=app.config['ITEMS_PER_PAGE'], error_out=False)
    authors = db.session.query(Author).join(Book, Book.author_id == Author.id).all()
    return render_template('/books/index.html', books=books, authors=authors)

@books.route('/books/pages/<int:page_num>', methods=['GET','POST'])
def index_pages(page_num):

    books = Book.query.order_by(Book.date.desc()).paginate(page=page_num, per_page=app.config['ITEMS_PER_PAGE'], error_out=False)
    authors = db.session.query(Author).join(Book, Book.author_id == Author.id).all()
    return render_template('books/index.html', books=books, authors=authors)


@books.route('/books/register', methods=['GET','POST'])
def register():

    registered_authors = db.session.query(Author).order_by('name')
    authors_list = [(i.id, i.name) for i in registered_authors]

    form = BookForm()
    form.author.choices = authors_list

    if form.date.data is None:
        form.date.data = datetime.datetime.today()

    if form.validate_on_submit():
        book = Book(title=form.title.data,genre=form.genre.data, date=form.date.data, recommended=form.recommended.data, comment=form.comment.data, author_id=form.author.data)
        db.session.add(book)
        db.session.commit()
        return redirect(url_for('books.index'))
    return render_template('books/register.html', form=form)

@books.route('/books/<int:id>/update', methods=['GET','POST'])
def update(id):
    book = Book.query.get(id)

    registered_authors = db.session.query(Author).order_by('name')
    authors_list = [(i.id, i.name) for i in registered_authors]

    form = BookUpdateForm()

    form.author.choices = authors_list

    if form.validate_on_submit():

        book.title = form.title.data
        book.genre = form.genre.data
        book.author_id = form.author.data
        book.date = form.date.data
        book.recommended = form.recommended.data
        book.comment = form.comment.data
        db.session.commit()

        return redirect(url_for('books.index'))

    elif request.method == 'GET':

        form.title.data = book.title
        form.author.data = book.author_id
        form.genre.data = book.genre
        form.date.data = book.date
        form.recommended.data = book.recommended
        form.comment.data = book.comment

    return render_template('books/each.html', form=form, id=id)

@books.route('/books/<int:id>/delete', methods=['GET','POST'])
def delete(id):
    book = Book.query.get(id)
    db.session.delete(book)
    db.session.commit()
    return redirect(url_for('books.index'))
"""