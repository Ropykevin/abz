import os
from datetime import datetime, timedelta
from dotenv import load_dotenv
from flask_login import LoginManager, login_user, logout_user, current_user
from functools import wraps
from flask import redirect, flash, request, url_for

login_manager = LoginManager()
login_manager.login_message = 'Please log in to access this page.'

# Custom Login required


def login_required(app_name):
    def login_decorator(view_func):
        @wraps(view_func)
        def wrapped_view(*args, **kwargs):
            if current_user.is_authenticated:
                print('niko hapa')
                return view_func(*args, **kwargs)
            next_url = request.url
            print("Next URL: ", next_url)
            return redirect(url_for(f"{app_name}.login", next=next_url))
        return wrapped_view
    return login_decorator


# Custom decorator for role-based access
def role_required(role, app_name):
    def role_decorator(view_func):
        @wraps(view_func)
        def wrapped_view(*args, **kwargs):
            if not current_user.is_authenticated:
                return redirect(url_for(f"{app_name}.login", next=request.url))

            if not hasattr(current_user, 'role') or current_user.role not in role:
                flash('You do not have permission to access this page.', 'danger')
                return redirect(url_for(f"{app_name}.unauthorized"))

            return view_func(*args, **kwargs)
        return wrapped_view
    return role_decorator


# Load environment variables from .env file if it exists
load_dotenv()

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'abz-hardware-secret-key-2024-secure-random-string'
    SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Cloudinary Configuration
    # Use environment variables if available, otherwise use placeholder values
    CLOUDINARY_CLOUD_NAME = os.environ.get('CLOUDINARY_CLOUD_NAME', 'dxyewzvnr')
    CLOUDINARY_API_KEY = os.environ.get('CLOUDINARY_API_KEY', '171127627627327')
    CLOUDINARY_API_SECRET = os.environ.get('CLOUDINARY_API_SECRET', 'zgKkOpX35l93D7CdwnWOWGF2mk8')

    #Brevo Email Configuration
    BREVO_API_KEY = os.getenv('BREVO_API_KEY')
    BREVO_SENDER_EMAIL = os.getenv('ABZ_EMAIL')
    BREVO_SENDER_NAME = os.getenv('COMPANY_EMAIL')
    
    # File Upload Configuration
    UPLOAD_FOLDER = 'static/uploads/products'
    ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'webp', 'avif', 'heic', 'heif'}
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max file size
    
    # Session Configuration
    SESSION_COOKIE_SECURE = False  # Set to True in production with HTTPS
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
    PERMANENT_SESSION_LIFETIME = timedelta(hours=24)  # 24 hour session lifetime 
