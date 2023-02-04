FROM python:3.8

LABEL maintainer="GAO SHAN"

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY * /app/Server/
# COPY /mnt/c/Users/zheyuan-w/Documents/Project PBL/git/Team-Gao-Yuan-Uriuriboo-KazukiSenda/Server /app/
WORKDIR /app/Server

CMD ["python3","app.py"]