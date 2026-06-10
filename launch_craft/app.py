import json
import uuid
from pathlib import Path
from typing import List, Dict

from flask import Flask, request, jsonify, abort
from models import db, Product

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///products.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db.init_app(app)

# --------------------------------------------------------------------------- #
# Load static directory catalogue
# --------------------------------------------------------------------------- #
DATA
