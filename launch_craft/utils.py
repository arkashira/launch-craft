from .db import insert_product

def submit_product(name: str, description: str) -> int:
    """
    Public API used by the CLI and tests.
    Returns the database id of the newly created product.
    """
    if not name.strip():
        raise ValueError("Product name cannot be empty")
    if not description.strip():
        raise ValueError("Product description cannot be empty")
    return insert_product(name, description)