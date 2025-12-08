from flask import Flask
from config.dbconfig import db
from config.appconfig import Config, login_manager

from routes.admin import app_admin
# from routes.cashier import app
# from routes.customer import app
# from routes.sales import app
# from routes.store import app

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Init db and login_manager
    db.init_app(app)
    login_manager.init_app(app)

    # Register Blueprints
    app.register_blueprint(app_admin)
    # app.register_blueprint(app2)
    # app.register_blueprint(app3)
    return app

app = create_app()
app.run()