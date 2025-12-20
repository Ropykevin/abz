import cloudinary
import cloudinary.uploader
import cloudinary.api
from flask import current_app as app

# Cloudinary Configuration
cloudinary.config(
    cloud_name = app.config['CLOUDINARY_CLOUD_NAME'],
    api_key = app.config['CLOUDINARY_API_KEY'],
    api_secret = app.config['CLOUDINARY_API_SECRET']
)

# Cloudinary helper functions
def upload_to_cloudinary(file, folder="expense_receipts"):
    """Upload file to Cloudinary and return the secure URL"""
    try:
        result = cloudinary.uploader.upload(
            file,
            folder=folder,
            resource_type="auto",  # Automatically detect image, video, or raw
            quality="auto:good",   # Optimize quality
            fetch_format="auto"    # Auto format based on browser
        )
        return result.get('secure_url')
    except Exception as e:
        print(f"Cloudinary upload error: {e}")
        return None

def delete_from_cloudinary(public_id):
    """Delete file from Cloudinary using public ID"""
    try:
        result = cloudinary.uploader.destroy(public_id)
        return result.get('result') == 'ok'
    except Exception as e:
        print(f"Cloudinary delete error: {e}")
        return False