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
    assert "Hello World!" == response.text
