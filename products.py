from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/products', methods=['GET'])
def get_products():
    return jsonify({"products": ["Product 1", "Product 2", "Product 3"]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
