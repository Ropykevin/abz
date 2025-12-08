"""
Standalone entry point for Site Owner Portal
Run with: python main.py
"""
import os
import sys
from pathlib import Path

# Add the current directory to Python path to allow imports
current_dir = Path(__file__).parent
sys.path.insert(0, str(current_dir))

from __init__ import create_app

# Create Flask app
app = create_app()

# Create database tables
with app.app_context():
    from models import db
    db.create_all()
    print("✅ Site Portal database tables created/verified successfully.")

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('FLASK_DEBUG', 'False').lower() == 'true'
    app.run(host='0.0.0.0', port=port, debug=debug)
