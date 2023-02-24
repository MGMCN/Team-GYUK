from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_URL = os.getenv('DATABASE_URL')
DATABASE_NAME = os.getenv('DATABASE_NAME')
USER = os.getenv('USER')
PASSWORD = os.getenv('PASSWORD')
SECRET_KEY = os.getenv('SECRET_KEY')


class Config(object):
    MYSQL_HOST = DATABASE_URL
    MYSQL_USER = USER
    MYSQL_PASSWORD = PASSWORD
    MYSQL_DB = DATABASE_NAME
    MYSQL_CURSORCLASS = 'DictCursor'
    SECRET_KEY = SECRET_KEY
    ITEMS_PER_PAGE = 5
