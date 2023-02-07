"""
    How to create test file
    filename should be like test_xxx.py

    How to test
    step1 : Make sure you download pytest
    step2 : run "pytest" command
"""
import pytest
import sys

sys.path.insert(0, '../Server')
from app import app


@pytest.fixture
def client():
    return app.test_client()


def test_index(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hello World!' in response.data

def test_datebase_creatation(client):
    response = client.get('/database_create')
    assert response.status_code == 200
    assert 'Success' in response.data