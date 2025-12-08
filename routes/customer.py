from flask import Flask, render_template, request, redirect, url_for, flash, session, jsonify
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
import requests
import os
from werkzeug.security import check_password_hash, generate_password_hash
import secrets
from datetime import datetime, timedelta

from models import Branch, Category, User, Product, OrderType, Order, OrderItem, StockTransaction, PasswordReset

#New Compied Code
from flask import Blueprint
from config.appconfig import Config,cloudinary,login_manager,current_user,login_required,datetime,timedelta
from config.dbconfig import db,EAT
from helpers.send_email import *

app = Blueprint('app1', __name__)
app.config.from_object(Config)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@app.route("/")
def index():
    """Home page with featured products"""
    # Get products that are displayed to customers
    products = Product.query.filter_by(display=True).limit(8).all()
    categories = Category.query.all()
    return render_template('index.html', products=products, categories=categories)

@app.route("/products")
def products():
    """Product showcase page with search and filtering"""
    search = request.args.get('search', '')
    category_id = request.args.get('category', '')
    page = request.args.get('page', 1, type=int)
    per_page = 12
    
    query = Product.query.filter_by(display=True)
    
    if search:
        query = query.filter(Product.name.ilike(f'%{search}%'))
    
    if category_id:
        query = query.filter_by(categoryid=category_id)
    
    products = query.paginate(page=page, per_page=per_page, error_out=False)
    categories = Category.query.all()
    
    return render_template('products.html', products=products, categories=categories, search=search, category_id=category_id)

@app.route("/product/<int:product_id>")
def product_detail(product_id):
    """Individual product detail page"""
    product = Product.query.get_or_404(product_id)
    if not product.display:
        flash('Product not found', 'error')
        return redirect(url_for('products'))
    
    return render_template('product_detail.html', product=product)

@app.route("/login", methods=['GET', 'POST'])
def login():
    """User login page"""
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        
        user = User.query.filter_by(email=email).first()
        
        if user and check_password_hash(user.password, password):
            # Check if user has customer role
            if user.role != 'customer':
                flash('Access denied. Only customers can log in to this portal.', 'error')
                return render_template('login.html')
            
            login_user(user)
            flash('Logged in successfully!', 'success')
            next_page = request.args.get('next')
            return redirect(next_page or url_for('index'))
        else:
            flash('Invalid email or password', 'error')
    
    return render_template('login.html')

@app.route("/register", methods=['GET', 'POST'])
def register():
    """User registration page"""
    if request.method == 'POST':
        email = request.form.get('email')
        firstname = request.form.get('firstname')
        lastname = request.form.get('lastname')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        if password != confirm_password:
            flash('Passwords do not match', 'error')
            return render_template('register.html')
        
        # Check password length
        if len(password) < 6:
            flash('Password must be at least 6 characters long', 'error')
            return render_template('register.html')
        
        # Check if user already exists
        existing_user = User.query.filter_by(email=email).first()
        if existing_user:
            flash('This email address is already registered. Please use a different email or try logging in.', 'error')
            return render_template('register.html')
        
        # Create new user
        hashed_password = generate_password_hash(password)
        new_user = User(
            email=email,
            firstname=firstname,
            lastname=lastname,
            password=hashed_password,
            role='customer'
        )
        
        try:
            db.session.add(new_user)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            if 'duplicate key value violates unique constraint "users_email_key"' in str(e):
                flash('This email address is already registered. Please use a different email or try logging in.', 'error')
            else:
                flash('Registration failed. Please try again or contact support if the problem persists.', 'error')
            return render_template('register.html')
        
        # Send welcome email
        send_welcome_email(new_user)
        
        flash('Registration successful! Welcome email sent. Please login.', 'success')
        return redirect(url_for('login'))
    
    return render_template('register.html')

@app.route("/forgot-password", methods=['GET', 'POST'])
def forgot_password():
    """Forgot password page"""
    # Clean up expired tokens first
    cleanup_expired_tokens()
    
    if request.method == 'POST':
        email = request.form.get('email')
        
        user = User.query.filter_by(email=email).first()
        
        if user:
            # Generate a secure reset token
            reset_token = secrets.token_urlsafe(32)
            
            # Create expiry time (1 hour from now)
            expires_at = datetime.utcnow() + timedelta(hours=1)
            
            # Store token in database
            reset_token_obj = PasswordReset(
                user_id=user.id,
                token=reset_token,
                expires_at=expires_at
            )
            db.session.add(reset_token_obj)
            db.session.commit()
            
            # Send password reset email
            email_sent = send_password_reset_email(user, reset_token)
            
            if email_sent:
                flash(f'Password reset email sent to {email}. Please check your inbox.', 'success')
                return redirect(url_for('login'))
            else:
                # If email failed, remove the token from database
                db.session.delete(reset_token_obj)
                db.session.commit()
                flash('Failed to send reset email. Please try again.', 'error')
                return render_template('forgot_password.html')
        else:
            flash('Email not found in our system', 'error')
    
    return render_template('forgot_password.html')

@app.route("/reset-password/<token>", methods=['GET', 'POST'])
def reset_password(token):
    """Reset password page"""
    # Find valid reset token in database
    reset_token_obj = PasswordReset.query.filter_by(token=token).first()
    
    if not reset_token_obj or not reset_token_obj.is_valid():
        if reset_token_obj:
            # Mark expired tokens as used
            reset_token_obj.used = True
            db.session.commit()
        flash('Invalid or expired reset token. Please request a new password reset.', 'error')
        return redirect(url_for('forgot_password'))
    
    user = User.query.get(reset_token_obj.user_id)
    if not user:
        flash('User not found', 'error')
        return redirect(url_for('forgot_password'))
    
    if request.method == 'POST':
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        if password != confirm_password:
            flash('Passwords do not match', 'error')
            return render_template('reset_password.html', token=token)
        
        if len(password) < 6:
            flash('Password must be at least 6 characters long', 'error')
            return render_template('reset_password.html', token=token)
        
        # Update password
        user.password = generate_password_hash(password)
        
        # Mark token as used
        reset_token_obj.used = True
        
        db.session.commit()
        
        # Send password change alert email
        send_password_change_alert(user)
        
        flash('Password reset successfully! Please check your email for confirmation.', 'success')
        return redirect(url_for('login'))
    
    return render_template('reset_password.html', token=token)

@app.route("/logout")
@login_required
def logout():
    """User logout"""
    logout_user()
    flash('Logged out successfully!', 'success')
    return redirect(url_for('index'))

@app.route("/profile")
@login_required
def profile():
    """User profile page with order history"""
    orders = Order.query.filter_by(userid=current_user.id).order_by(Order.created_at.desc()).all()
    
    # Calculate totals for each order
    orders_with_totals = []
    for order in orders:
        total = 0
        for item in order.order_items:
            if item.product and item.product.sellingprice:
                total += item.product.sellingprice * item.quantity
        orders_with_totals.append({
            'order': order,
            'total': total
        })
    
    return render_template('profile.html', orders_with_totals=orders_with_totals)

@app.route("/change-password", methods=['POST'])
@login_required
def change_password():
    """Change user password"""
    current_password = request.form.get('current_password')
    new_password = request.form.get('new_password')
    confirm_password = request.form.get('confirm_password')
    
    # Validate input
    if not current_password or not new_password or not confirm_password:
        flash('All password fields are required', 'error')
        return redirect(url_for('profile'))
    
    # Verify current password
    if not check_password_hash(current_user.password, current_password):
        flash('Current password is incorrect', 'error')
        return redirect(url_for('profile'))
    
    # Check if new passwords match
    if new_password != confirm_password:
        flash('New passwords do not match', 'error')
        return redirect(url_for('profile'))
    
    # Check password length
    if len(new_password) < 6:
        flash('New password must be at least 6 characters long', 'error')
        return redirect(url_for('profile'))
    
    # Update password
    current_user.password = generate_password_hash(new_password)
    db.session.commit()
    
    # Send password change alert email
    print(f"🔍 Sending password change alert to {current_user.email}")
    email_sent = send_password_change_alert(current_user)
    
    if email_sent:
        flash('Password updated successfully! Please check your email for confirmation.', 'success')
    else:
        flash('Password updated successfully! Email notification could not be sent.', 'warning')
    
    return redirect(url_for('profile'))

@app.route("/order/<int:order_id>")
@login_required
def order_detail(order_id):
    """Individual order detail page"""
    order = Order.query.get_or_404(order_id)
    
    # Ensure user can only view their own orders
    if order.userid != current_user.id:
        flash('Access denied', 'error')
        return redirect(url_for('profile'))
    
    # Calculate total from order items
    total = 0
    for item in order.order_items:
        if item.product and item.product.sellingprice:
            total += item.product.sellingprice * item.quantity
    
    return render_template('order_detail.html', order=order, total=total)

@app.route("/add_to_cart", methods=['POST'])
def add_to_cart():
    """Add product to cart (session-based)"""
    product_id = request.form.get('product_id')
    quantity = int(request.form.get('quantity', 1))
    
    product = Product.query.get_or_404(product_id)
    if not product.display:
        return jsonify({'success': False, 'message': 'Product not available'})
    
    if 'cart' not in session:
        session['cart'] = {}
    
    if str(product_id) in session['cart']:
        session['cart'][str(product_id)] += quantity
    else:
        session['cart'][str(product_id)] = quantity
    
    session.modified = True
    return jsonify({'success': True, 'message': 'Added to cart', 'cart_count': len(session['cart'])})

@app.route("/cart")
def cart():
    """Shopping cart page"""
    cart_items = []
    total = 0
    
    if 'cart' in session:
        for product_id, quantity in session['cart'].items():
            product = Product.query.get(product_id)
            if product and product.display:
                item_total = product.sellingprice * quantity if product.sellingprice else 0
                cart_items.append({
                    'product': product,
                    'quantity': quantity,
                    'total': item_total
                })
                total += item_total
    
    return render_template('cart.html', cart_items=cart_items, total=total)

@app.route("/update_cart", methods=['POST'])
def update_cart():
    """Update cart quantities"""
    product_id = request.form.get('product_id')
    quantity = int(request.form.get('quantity', 0))
    
    if 'cart' not in session:
        session['cart'] = {}
    
    if quantity <= 0:
        session['cart'].pop(str(product_id), None)
    else:
        session['cart'][str(product_id)] = quantity
    
    session.modified = True
    return redirect(url_for('cart'))

@app.route("/checkout", methods=['GET', 'POST'])
@login_required
def checkout():
    """Checkout page and order processing"""
    if request.method == 'POST':
        # Get order type (Online for customer portal)
        order_type = OrderType.query.filter_by(name='Online').first()
        if not order_type:
            # Create Online order type if it doesn't exist
            order_type = OrderType(name='Online')
            db.session.add(order_type)
            db.session.commit()
        
        # Create order
        order = Order(
            userid=current_user.id,
            ordertypeid=order_type.id,
            branchid=1,  # Default branch, you might want to make this dynamic
            approvalstatus=False
        )
        db.session.add(order)
        db.session.commit()
        
        # Add order items
        total = 0
        for product_id, quantity in session['cart'].items():
            product = Product.query.get(product_id)
            if product and product.display:
                order_item = OrderItem(
                    orderid=order.id,
                    productid=product.id,
                    quantity=quantity,
                    buying_price=product.buyingprice,  # Capture buying price at time of order
                    original_price=product.sellingprice,  # Capture original selling price
                    final_price=product.sellingprice  # Set final price to selling price initially
                )
                db.session.add(order_item)
                total += (product.sellingprice or 0) * quantity
        
        db.session.commit()
        
        # Clear cart
        session.pop('cart', None)
        
        flash(f'Online order placed successfully! Order ID: {order.id}', 'success')
        return redirect(url_for('order_detail', order_id=order.id))
    
    # GET request - show checkout page
    cart_items = []
    total = 0
    
    if 'cart' in session:
        for product_id, quantity in session['cart'].items():
            product = Product.query.get(product_id)
            if product and product.display:
                item_total = product.sellingprice * quantity if product.sellingprice else 0
                cart_items.append({
                    'product': product,
                    'quantity': quantity,
                    'total': item_total
                })
                total += item_total
    
    if not cart_items:
        flash('Your cart is empty', 'error')
        return redirect(url_for('cart'))
    
    return render_template('checkout.html', cart_items=cart_items, total=total)

@app.route("/api/search_products")
def api_search_products():
    """API endpoint for product search"""
    search = request.args.get('q', '')
    products = Product.query.filter(
        Product.display == True,
        Product.name.ilike(f'%{search}%')
    ).limit(10).all()
    
    results = []
    for product in products:
        results.append({
            'id': product.id,
            'name': product.name,
            'price': product.sellingprice,
            'image_url': product.image_url,
            'category': product.category.name if product.category else ''
        })
    
    return jsonify(results)

def test_brevo_api():
    """Test Brevo API connection"""
    api_key = app.config['BREVO_API_KEY']
    sender_email = app.config['BREVO_SENDER_EMAIL']
    sender_name = app.config['BREVO_SENDER_NAME']
    url = 'https://api.brevo.com/v3/smtp/email'
    headers = {
        'accept': 'application/json',
        'api-key': api_key,
        'content-type': 'application/json',
    }
    
    data = {
        "sender": {"name": sender_name, "email": sender_email},
        "to": [{"email": "test@example.com", "name": "Test User"}],
        "subject": "Test Email - ABZ Hardware",
        "htmlContent": "<h1>Test Email</h1><p>This is a test email to verify Brevo API connection.</p>"
    }
    
    try:
        print(f"🔍 Testing Brevo API connection...")
        print(f"🔍 API Key: {api_key[:20]}...")
        print(f"🔍 Sender Email: {sender_email}")
        print(f"🔍 Sender Name: {sender_name}")
        
        response = requests.post(url, headers=headers, json=data)
        print(f"🔍 Response status code: {response.status_code}")
        print(f"🔍 Response text: {response.text}")
        
        if response.status_code == 201:
            print("✅ Brevo API test successful!")
            return True
        else:
            print(f"❌ Brevo API test failed: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Exception during Brevo API test: {str(e)}")
        return False

@app.route("/test-email")
def test_email():
    """Test email functionality"""
    if test_brevo_api():
        return "Email API test successful! Check console for details."
    else:
        return "Email API test failed! Check console for details."

def cleanup_expired_tokens():
    """Remove expired password reset tokens from database"""
    try:
        expired_tokens = PasswordReset.query.filter(
            PasswordReset.expires_at < datetime.utcnow()
        ).all()
        
        for token in expired_tokens:
            db.session.delete(token)
        
        if expired_tokens:
            db.session.commit()
            print(f"🧹 Cleaned up {len(expired_tokens)} expired password reset tokens")
            
    except Exception as e:
        print(f"❌ Error cleaning up expired tokens: {str(e)}")

if __name__ == '__main__':
    app.run(debug=True)
