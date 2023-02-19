from __init__ import mysql, BookStatus, AuthType
# from forms import BookForm, BookUpdateForm
from flask import Blueprint, render_template, redirect, url_for, request
import json

def print_error(error="Error"):
    return json.dumps({'errorMessage': str(error), 'code': 0})
def print_success(success="Success"):
    return json.dumps({'processMessage': str(success), 'code': 1})
def validate_form_data(form, headers):
    errors = []
    for header in headers:
        if header not in form:
            errors.append(f"{header} is empty")
    return errors
def row_count():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM book")
    count = cursor.fetchone()[0] # to get current ID
    return count + 1
def extract_form_data(form, headers):
    values = []
    # values.append(row_count())
    for header in headers:
        values.append(form[header])
    return values

def update_headers():
    return ['userId', 'bookName']

bksfbp = Blueprint('bksfbp',__name__) #,url_prefix='/books')

@bksfbp.route('/getbooklist')
def show_all():
   cs = mysql.connection.cursor()
   cs.execute('''SELECT * FROM book''')
   result = json.dumps(cs.fetchall())
   cs.close()
   return result

@bksfbp.route('/addbooks', methods=['POST'])
def add():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return print_error(errors)
    try:
        cursor = mysql.connection.cursor()
        sql = """SELECT * from user WHERE userId=%s"""
        cursor.execute(sql, extract_form_data(request.form, ['userId']))
        user = cursor.fetchone()
        if user['authType'] != AuthType.MANAGER.value:
            return print_error("You are not a manager")
        sql = """INSERT INTO book (bookName) VALUES (%s)"""
        cursor.execute(sql, extract_form_data(request.form, ['bookName']))
        mysql.connection.commit()
    except Exception as e:
        return print_error(e)

    return print_success()

@bksfbp.route('/deletebooks', methods=['POST'])
def delete():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return print_error(errors)
    try:
        cursor = mysql.connection.cursor()

        sql = """SELECT * from user where userId=%s"""
        cursor.execute(sql, extract_form_data(request.form, ['userId']))
        user = cursor.fetchone()
        if user['authType'] != AuthType.MANAGER.value:
            return print_error("You are not a manager")
        sql = """SELECT * FROM book WHERE bookStatus=%s AND bookName=%s"""
        cursor.execute(sql, [BookStatus.AVAILABLE.value] + extract_form_data(request.form, ['bookName']))
        book = cursor.fetchone()
        if not book:
            return print_error("Book not found")
        sql = """DELETE FROM book WHERE bookId=%s"""
        cursor.execute(sql, [book['bookId']])
        mysql.connection.commit()
    except Exception as e:
        return print_error(e)

    return print_success()

@bksfbp.route('/returnbooks', methods=['POST'])
def returnbooks():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return print_error(errors)
    try:
        cursor = mysql.connection.cursor()
        sql = """SELECT bookId from book WHERE bookStatus=%s AND bookName=%s"""
        cursor.execute(sql, [BookStatus.BORROWED.value] + extract_form_data(request.form, ['bookName']))
        book = cursor.fetchone()
        if not book:
            return print_error("Book not found")
        bookId = book['bookId']
        sql = """UPDATE book SET bookStatus=%s WHERE bookId=%s"""
        cursor.execute(sql, [BookStatus.AVAILABLE.value, bookId])
        sql = """DELETE FROM borrowStatus WHERE userId=%s AND bookId=%s"""
        cursor.execute(sql, extract_form_data(request.form, ['userId']) + [bookId])
        mysql.connection.commit()
    except Exception as e:
        return print_error(e)

    return print_success()

@bksfbp.route('/borrowbooks', methods=['POST'])
def borrowbooks():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return print_error(errors)
    try:
        cursor = mysql.connection.cursor()
        sql = """SELECT bookId from book WHERE bookStatus=%s AND bookName=%s"""
        cursor.execute(sql, [BookStatus.AVAILABLE.value] + extract_form_data(request.form, ['bookName']))
        book = cursor.fetchone()
        if not book:
            return print_error("Book not found")
        bookId = book['bookId']
        sql = """UPDATE book SET bookStatus=%s WHERE bookId=%s"""
        cursor.execute(sql, [BookStatus.BORROWED.value, bookId])
        sql = """INSERT INTO borrowStatus (userId, bookId) VALUES (%s, %s)"""
        cursor.execute(sql, extract_form_data(request.form, ['userId']) + [bookId])
        mysql.connection.commit()
    except Exception as e:
        return print_error(e)

    return print_success()

"""
# RestfulAPI
@bksfbp.route('/<int:id>/update', methods=['POST'])
def update(id):
    errors = validate_form_data(request.form, headers())
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        # sql = UPDATE book SET bookName=%s, bookStatus=%s WHERE bookId=%s
        cursor.execute(sql, extract_form_data(request.form, headers()) + [id])
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200
@bksfbp.route('/<int:id>/delete', methods=['POST'])
def delete(id):
    try:
        cursor = mysql.connection.cursor()
        # sql = DELETE FROM book WHERE bookId=%s
        cursor.execute(sql, [id])
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200
"""