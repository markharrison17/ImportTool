"""Common Base that we can use in our models this enables us to seperate our models
neatly into seperate files in the models directory"""

from sqlalchemy.ext.declarative import declarative_base
base = declarative_base()
