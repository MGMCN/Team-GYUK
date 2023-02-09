from __init__ import mysql, app
from forms import BookForm, BookUpdateForm
from flask import Blueprint, render_template, redirect, url_for, request
import json

bksfbp = Blueprint('bksfbp',__name__,url_prefix='/books')

@bksfbp.route('/')
def show_all():
   cs = mysql.connection.cursor()
   cs.execute('''SELECT * FROM book''')
   result = json.dumps(cs.fetchall())
   cs.close()
   return result

@bksfbp.route('/register', methods=['POST'])
def register():
    errors = validate_form_data(request.form)
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """INSERT INTO book (bookName, bookStatus) VALUES (%s, %s)"""
        cursor.execute(sql, extract_form_data(request.form))
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

def headers():
    return ['bookName', 'bookStatus']
def validate_form_data(form):
    errors = []
    for header in headers():
        if not form[header]:
            errors.append(f"{header} is empty")
    return errors
def row_count():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM book")
    count = cursor.fetchone()[0] # to get current ID
    return count + 1
def extract_form_data(form):
    values = []
    # values.append(row_count())
    for header in headers():
        values.append(form[header])
    return values

@bksfbp.route('/<int:id>/update', methods=['POST'])
def update(id):
    errors = validate_form_data(request.form)
    if errors:
        return errors, 500
    try:
        cursor = mysql.connection.cursor()
        sql = """UPDATE book SET bookName=%s, bookStatus=%s WHERE bookId=%s"""
        cursor.execute(sql, extract_form_data(request.form) + [id])
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200

@bksfbp.route('/<int:id>/delete', methods=['POST'])
def delete(id):
    try:
        cursor = mysql.connection.cursor()
        sql = """DELETE FROM book WHERE bookId=%s"""
        cursor.execute(sql, [id])
        mysql.connection.commit()
    except Exception as e:
        return str(e), 500

    return  "Success", 200