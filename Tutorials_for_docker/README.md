# Why we use Docker
Using docker allows you to unify your development environment while being able to use your respective database tests separately. It is also easier to deploy our services to the production environment.
## Before you start
First make sure you have Docker and Docker-Compose tools installed on your computer 
## All operations will be performed under this directory
```Bash
Server
├── Dockerfile
├── README.md
├── app.py
├── .
├── .
├── .
├── docker-compose.yml
└── requirements.txt
```
# Build your own Docker-container
## Export the libraries
Execute this command in this directory to export the libraries needed to run the flask project.
```Bash
pip freeze > requirements.txt
```
## Edit the python version in Dockerfile
Edit the python version in the first line to the version you are using.   
ps:We usually don't need to change this version setting
```Dockerfile
FROM python:3.8
LABEL maintainer="GAO SHAN"
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY * /app/Server/
WORKDIR /app/Server
CMD ["python3","app.py"]
```
## Edit the image of mysql in docker-compose.yml to mysql:5.7.    
ps:Because my computer's cpu is arm architecture so I changed to other docker image, if your computer is intel or amd cpu then you should use mysql:5.7
```yaml
version: "3"
services:
  server:
    build: .
    ports:
      - "8883:5000"
    volumes:
      - .:/app/Server
    environment:
      FLASK_DEBUG: "true"
    depends_on:
      - mysql
  mysql:
    restart: always
    image: zhonghl003/mysql-server:5.7.34-37 # you should modify this (mysql:5.7)
    container_name: mysql
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: Serverdb
    volumes:
      - mysql-data:/var/lib/mysql
volumes:
  mysql-data:
```
## Run docker-compose!
After executing this command you will see that your computer is successfully running a container with the flask service and mysql service inside
```Bash
$ docker-compose up -d # <- run this
.
.
.
Creating network "server_default" with the default driver
Creating server_server_1 ... done
Creating mysql           ... done

```
If you get an ${\color{red}ERROR}$ when installing the library, it is likely that the python version you edited and the version of the library in your exported requirements.txt do not match. Solution 1 delete those mismatched libraries in requirements.txt, solution 2 adjust python version.
## Stop docker container
```Bash
$ docker-compose down
```
## Let's learn the docker-compose file
Our flask container's external port is 8883, and then we mapped the container's internal port 5000 to the external port 8883. So the address to access our service is 127.0.0.1:8883.   
Similarly our access to the database will be through the container's external port 3306 to access the container's internal port 3306.   
Our password to connect to the database is 123456, the user name is root, and the database name is Serverdb
## Connecting to the database through Terminal
```Bash
$ sudo docker exec -it mysql mysql -u root -p
```
## Connecting to the database via code
[@Yuan](https://github.com/WEI44ZHEYUAN) and I have tested the code, if you want to connect to the database through the code please use Yuan's code directly.
## Acknowledgements
Thanks to [@Yuan](https://github.com/WEI44ZHEYUAN) for testing docker-compose.
