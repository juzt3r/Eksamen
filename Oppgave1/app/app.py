from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
import os
import pymysql
import time

pymysql.install_as_MySQLdb()

app = Flask(__name__)

DB_USER = os.getenv("DB_USER", "product-api")
DB_PASSWORD = os.getenv("DB_PASSWORD", "securepass")
DB_HOST = os.getenv("DB_HOST", "db")
DB_NAME = os.getenv("DB_NAME", "product_db")

app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Produktmodell
class Product(db.Model):
    __tablename__ = 'products'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    brand = db.Column(db.String(255), nullable=False)
    stock = db.Column(db.Integer, nullable=False)

# Vent til databasen er klar før vi prøver å opprette tabellen
def wait_for_db():
    retries = 10
    while retries > 0:
        try:
            db.create_all()
            print("Database tilkoblet og tabell opprettet.")
            return
        except Exception as e:
            print(f"Venter på database... ({retries} forsøk igjen)")
            time.sleep(3)
            retries -= 1
    print("Kunne ikke koble til databasen!")

@app.route('/api/products', methods=['GET'])
def get_products():
    products = Product.query.all()
    return jsonify([{
        'id': product.id,
        'name': product.name,
        'price': float(product.price),
        'brand': product.brand,
        'stock': product.stock
    } for product in products])

@app.route('/api/products/<int:id>', methods=['GET'])
def get_product_by_id(id):
    product = Product.query.get(id)
    if product is None:
        return jsonify({'error': 'Product not found'}), 404
    return jsonify({
        'id': product.id,
        'name': product.name,
        'price': float(product.price),
        'brand': product.brand,
        'stock': product.stock
    })

@app.route('/api/health', methods=['GET'])
def health_check():
    return "API OK"

if __name__ == '__main__':
    with app.app_context():
        wait_for_db()  # Sørger for at databasen er tilgjengelig før serveren starter
    app.run(host="0.0.0.0", port=8080, debug=True)
