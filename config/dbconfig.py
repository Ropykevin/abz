from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timezone, timedelta
import secrets
import string

db = SQLAlchemy()
EAT = timezone(timedelta(hours=3))