from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_URL = os.getenv('DATABASE_URL')
DATABASE_NAME = os.getenv('DATABASE_NAME')
USER = os.getenv('USER')
PASSWORD = os.getenv('PASSWORD')
SECRET_KEY = os.getenv('SECRET_KEY')

class Config(object):
    SQLALCHEMY_DATABASE_URI = f'mysql://{USER}:{PASSWORD}@{DATABASE_URL}/{DATABASE_NAME}'
    SECRET_KEY = SECRET_KEY
    ITEMS_PER_PAGE = 5