"""Setting class"""

import sys
import os.path
from import_tool.models.base import base
from sqlalchemy import Column, String

# setup path so we can import our own models and controllers
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

class Setting(base):
    """
    Settings class that keeps track of information about a
    particular Settings. This class uses SQLAlchemy as an ORM

    """
    __tablename__ = 'settings'

    key = Column(String(20), primary_key=True)
    value = Column(String(200))

    # Returns a printable version of the objects contents
    def __repr__(self):
        return "<Setting('%s %s')>" % (
            self.key,
            self.value)
