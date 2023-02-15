# How to testing our server
Please make sure you have downloaded the following two libraries correctly.
```Bash
pytest 7.2.1
requests 2.28.1
```
## How to run our test file
Cd into Server directory.
```Bash
Server
├── Dockerfile
├── README.md
├── Tests
├── __pycache__
├── app.py
├── auth.py
├── bksf.py
├── docker-compose.yml
└── requirements.txt
```
run command
```Bash
$ pytest # Before you run this command, please make sure docker-container is on.
.
.
============================= test session starts ==============================
platform darwin -- Python 3.9.6, pytest-7.2.1, pluggy-1.0.0
rootdir: /your_path/Team-GYUK/Server
collected 1 item                                                               

Tests/test_demo.py .                                                     [100%]

============================== 1 passed in 0.10s ===============================
```
## How to create our test file
Cd into Tests directory.
```Bash
Tests
└── test_demo.py
```
Then create your test file.(filename should be like test_xxxxx.py)
