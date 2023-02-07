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
    assert b'Hello World!' in response.data

def test_datebase_creatation(client):
    response = client.get('/database_create')
    assert response.status_code == 200
    assert 'Success' in response.data
