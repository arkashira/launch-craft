import os
import sqlite3
from pathlib import Path
import pytest

from launch_craft.utils import submit_product
from launch_craft.db import DB_PATH

@pytest.fixture(autouse=True)
def clean_db(tmp_path):
    """Ensure a fresh DB for each test."""
    # Remove any existing DB file
    Path(DB_PATH).unlink(missing_ok=True)
    yield
    Path(DB_PATH).unlink(missing_ok=True)

def test_submit_product_creates_record():
    prod_id = submit_pro
