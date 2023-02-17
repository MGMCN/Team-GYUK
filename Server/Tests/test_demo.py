"""
    How to create test file
    filename should be like test_xxx.py

    How to test
    step1 : Make sure you download pytest
    step2 : run "pytest" command
"""
import requests


def test_hello_world():
    response = requests.request(url='http://127.0.0.1:8883/test_demo', method='GET')
    assert response.status_code == 200
    assert 'Hello World!' in response.text

def test_datebase_creatation():
    response =  requests.request(url='http://127.0.0.1:8883/database_create',method='GET')
    assert response.status_code == 200
    # assert 'Success' in response.data

body = {'email': 'user1@gmail.com', 'password': '123123', 'name' : 'Jack'}

def test_register():
    response = requests.request.post(url='http://127.0.0.1:8883/register', data=body)
    assert response.status_code == 200
    assert response.data['code'] == 1