import sqlite3
from pathlib import Path

# Store DB in the same directory as the package
DB_PATH = Path(__file__).parent / "launch_craft.db"

def init_db() -> None:
    """Create the products table if it doesn't exist."""
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    cur.execute(
        """
        CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
        """
    )
    conn.commit()
    conn.close()

def insert_product(name: str, description: str) -> int:
    """Insert a product and return its id."""
    init_db()
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO products (name, description) VALUES (?, ?)",
        (name, description),
    )
    prod_id = cur.lastrowid
    conn.commit()
    conn.close()
    return prod_id