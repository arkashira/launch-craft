# tests/test_main.py
import pytest
from fastapi.testclient import TestClient
from app import app

client = TestClient(app)

# ---------- /submit_product ----------
def test_submit_product_success():
    payload = {
        "product_name": "Test Product",
        "product_description": "A test description"
    }
    response = client.post("/submit_product", json=payload)
    assert response.status_code == 200
    assert response.json() == {"message": "Product submitted successfully"}

def test_submit_product_missing_field():
    payload = {"product_name": "Missing description"}
    response = client.post("/submit_product", json=payload)
    assert response.status_code == 422  # Validation error from FastAPI

# ---------- /directories ----------
def test_get_directories():
    response = client.get("/directories")
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert "https://producthunt.com" in data