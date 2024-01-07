from flask import Flask, abort
import logging

app = Flask(__name__)

# Configuration: Personalized greetings for customers
CUSTOMER_GREETINGS = {
    'customerA': 'Hi',
    'customerB': 'Dear Sir or Madam',
    'customerC': 'Moin',
}

# Logging configuration: Set up basic logging
logging.basicConfig(level=logging.INFO)

@app.route('/greet/<customer>')
def greet_customer(customer):
    # Check if customer is configured, return personalized greeting
    if customer in CUSTOMER_GREETINGS:
        greeting = CUSTOMER_GREETINGS[customer]
        return f"{greeting}, {customer}!"
    else:
        # Return 404 if customer not found
        abort(404, description="Customer not found")

# Run the Flask app if executed directly
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
