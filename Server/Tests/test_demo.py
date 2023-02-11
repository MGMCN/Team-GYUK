"""
    How to create test file
    filename should be like test_xxx.py

    How to test
    step1 : Make sure you download pytest
    step2 : run "pytest" command
"""
import requests


def test_hello_world():
    response = requests.request(url='http://127.0.0.1:8883/', method='GET')
    assert response.status_code == 200
    assert "Hello World!" == response.text


def test_get_booklist():
    reponse = requests.request(url= 'http://127.0.0.1:8883/getbookslist', method='GET')
    assert reponse.status_code == 200

def test_add_books():
    reponse = requests.request(url= 'http://127.0.0.1:8883/addbooks', method='POST')
    assert reponse.status_code == 200

def test_delete_books():
    reponse = requests.request(url= 'http://127.0.0.1:8883/deletebooks', method='POST')
    assert reponse.status_code == 200

def test_borrow_books():
    reponse = requests.request(url='http://127.0.0.1:8883/borrowbooks', method= 'POST')
    assert reponse.status_code == 200

def test_return_books():
    reponse = requests.request(url='http://127.0.0.1:8883/returnbooks', method='POST')
    assert reponse.status_code == 200