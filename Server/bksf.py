from __init__ import mysql, app
from forms import BookForm, BookUpdateForm
from flask import Blueprint, render_template, redirect, url_for, request
import json

bksfbp = Blueprint('bksfbp',__name__) #,url_prefix='/books')

@bksfbp.route('/getbooklist')
def show_all():
   cs = mysql.connection.cursor()
   cs.execute('''SELECT * FROM book''')
   result = str(cs.fetchall())
   cs.close()
   return result

def validate_form_data(form, headers):
    errors = []
    for header in headers:
        if not form[header]:
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

def add_headers():
    return ['bookName']
@bksfbp.route('/addbooks', methods=['POST'])
def register():
    errors = validate_form_data(request.form, add_headers())
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """INSERT INTO book (bookName, bookStatus) VALUES (%s, %s)"""
        cursor.execute(sql, extract_form_data(request.form, add_headers()) + ['available'])
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

def update_headers():
    return ['bookId']
@bksfbp.route('/deletebooks', methods=['POST'])
def delete():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """DELETE FROM book WHERE bookId=%s"""
        cursor.execute(sql, extract_form_data(request.form, update_headers()))
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

@bksfbp.route('/returnbooks', methods=['POST'])
def returnbooks():
    errors = validate_form_data(request.form, update_headers())
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """UPDATE book SET bookStatus=%s WHERE bookId=%s"""
        cursor.execute(sql, ['available'] + extract_form_data(request.form, update_headers()))
        sql = """DELETE FROM borrowStatus WHERE bookId = %s"""
        cursor.execute(sql, extract_form_data(request.form, update_headers()))
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

def borrow_headers():
    return ['bookId', 'userId']
@bksfbp.route('/borrowbooks', methods=['POST'])
def borrowbooks():
    errors = validate_form_data(request.form, borrow_headers())
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """UPDATE book SET bookStatus=%s WHERE bookId=%s"""
        cursor.execute(sql, ['renting', request.form['bookId']])
        sql = """INSERT INTO borrowStatus (bookId, userId) VALUES (%s, %s)"""
        cursor.execute(sql, extract_form_data(request.form, borrow_headers()))
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

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