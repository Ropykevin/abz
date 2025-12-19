from flask import Flask, redirect, render_template
from config.dbconfig import db
from config.appconfig import Config, login_manager

from routes.admin import app_admin
from routes.cashier import app_cashier
from routes.store import app_store

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Init db and login_manager
    db.init_app(app)
    login_manager.init_app(app)

    # Landing page route
    @app.route('/')
    def landing():
        return render_template('landing.html')

    # Register Blueprints - register twice to handle both root and /admin/ paths
    app.register_blueprint(app_admin, url_prefix="/admin")
    app.register_blueprint(app_cashier, url_prefix="/cashier")
    app.register_blueprint(app_store, url_prefix="/store")
    # Create all DB tables
    with app.app_context():
        db.create_all()
    return app

app = create_app()
app.run(debug=True)