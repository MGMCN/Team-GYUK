from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, TextAreaField
from wtforms.fields import DateField
# from wtforms import DateField
from wtforms.validators import DataRequired


class BookForm(FlaskForm):
    bookName = StringField('Name', validators=[DataRequired()])
    bookStatus = StringField('Status', validators=[DataRequired()])
    submit = SubmitField('登録')


class BookUpdateForm(BookForm):
    submit = SubmitField('修正')


class SearchForm(FlaskForm):
    title = StringField('書籍')
    author = SelectField('著者', coerce=int)
    start_date = DateField('検索開始日', format="%Y-%m-%d")
    end_date = DateField('検索終了日', format="%Y-%m-%d")
    submit = SubmitField('検索')
