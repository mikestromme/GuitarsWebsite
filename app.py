
from flask import Flask, render_template
import pyodbc
from dotenv import load_dotenv
import os

load_dotenv()
database_server = os.getenv("database_server")
database = os.getenv("database")
db_user = os.getenv("db_user")
db_password = os.getenv("db_password")

app = Flask(__name__)

# Connection string to SQL Server
conn_str = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={{{database_server}}};DATABASE={{{database}}};UID={{{db_user}}};PWD={{{db_password}}}'

def get_products():
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    cursor.execute("SELECT product_id, name, description, price, stock_quantity FROM Products")
    products = cursor.fetchall()
    conn.close()
    return products

@app.route('/')
def inventory():
    products = get_products()
    return render_template('inventory.html', products=products)

if __name__ == '__main__':
    app.run(debug=True)
