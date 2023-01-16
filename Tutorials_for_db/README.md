# How to use our db
Please first make sure that you are connected to our campus network and can ping the following ip address.
```
ip:163.221.29.193  
port:3306
```
Notice : I'll give you the server and database password in slack.
## Through the terminal
Log in to our server remotely through ssh. You can also tell me your public_key and I will add it to authorized_keys, so that you can log in without password.
```Bash
ssh root@163.221.29.193
```
Then you can use the following command to log in to the mysql server.
```Bash
sudo docker exec -it mysql-server mysql -u root -p
```
## Through the Sequel Pro
![IMAGE](https://github.com/MGMCN/Team-Gao-Yuan-Uriuriboo-KazukiSenda/blob/main/image/Sequelpro.png)
ps : You can also use other software such as mysql workbench to connect.

## Through Code
[Flask-SQLAlchemy](https://pythonbasics.org/flask-sqlalchemy/) is recommended.  
Or you might use another library, which is also possible.
