from flask import Flask
from config.dbconfig import db
from config.appconfig import Config, login_manager

from routes.admin import app_admin

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Init db and login_manager
    db.init_app(app)
    login_manager.init_app(app)

    # Register Blueprints
    app.register_blueprint(app_admin,  url_prefix="/admin")

    # Create all DB tables
    with app.app_context():
        db.create_all()
    return app

app = create_app()
app.run(debug=True)