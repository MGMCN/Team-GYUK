# Fast book borrowing App
Using the app developed by us, you can borrow and return books by scanning the QR code. At the same time, this app realizes a simple registration and login function. This app also implements administrator privileges and normal user privileges. When you are logged in as an administrator, you can add books to the library or delete books.
## Framework & Maintenance technologies & programming languages we use
![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
## Server
The server is written based on the flask framework. It implements communication with the front-end app and communication with the back-end database. The database is using the docker image of mysql. We also packaged the mysql database and the flask-based server into a docker container. It can be started directly using the docker-compose command.
## Client
The front-end mobile application is based on Apple's ios system and written using the api provided by the native swiftUI. It realizes the functions of login, registration, scanning to borrow books, scanning to return books, scanning to add books and scanning to delete books.
## Test
We run the test file with pytest. and write code to test the server interface using the requests library. We also wrote the actions.yml file on github to test the push code and the pull request code.
## More details
You can see our document! Here is the link👇🏻
|resource|link|
|---|---|
|Server project|[link](https://github.com/MGMCN/Team-GYUK/tree/main/Server)|
|Client project|[link](https://github.com/MGMCN/Team-GYUK/tree/main/Client)|
|Tutorials|[link](https://github.com/MGMCN/Team-GYUK/tree/main/Tutorials)|
|PBL tasks|[link](https://github.com/MGMCN/Team-GYUK/tree/main/Tasks)|
## Why we developed this application
This is an assignment for one of our classes, designed to familiarize us with the software development process as well as to get comfortable with collaborative multi-person development.
# Contributions
|task|collaborators|
|---|---|
|Who came up with this idea|[@Uriuriboo](https://github.com/uriuriboo)|
|Who specified the technology used for this PBL project development|[@Me](https://github.com/MGMCN)|
|Who wrote the server code|[@Yuan](https://github.com/WEI44ZHEYUAN)、[@KazukiSenda](https://github.com/KazukiSenda)|
|Who wrote the docker file|[@Me](https://github.com/MGMCN)|
|Who wrote the github workflow script|[@Me](https://github.com/MGMCN)|
|Who wrote the ios application code|[@Me](https://github.com/MGMCN)、[@Uriuriboo](https://github.com/uriuriboo)|
|Who wrote the test code|[@Me](https://github.com/MGMCN)、[@Uriuriboo](https://github.com/uriuriboo)、[@Yuan](https://github.com/WEI44ZHEYUAN)、[@KazukiSenda](https://github.com/KazukiSenda)|
