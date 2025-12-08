from flask import Flask, render_template, request, redirect, url_for, flash, jsonify, session
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from datetime import datetime, timezone, timedelta
from sqlalchemy.orm import joinedload
import os
import cloudinary
import cloudinary.uploader
import cloudinary.api
from models import *

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key-here'
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:%23Deno0707@69.197.187.23:5432/abzone'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Cloudinary configuration
cloudinary.config(
    cloud_name=os.environ.get('CLOUDINARY_CLOUD_NAME', 'dxyewzvnr'),
    api_key=os.environ.get('CLOUDINARY_API_KEY', '171127627627327'),
    api_secret=os.environ.get('CLOUDINARY_API_SECRET', 'zgKkOpX35l93D7CdwnWOWGF2mk8')
)

# Initialize extensions
db.init_app(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
login_manager.login_message = 'Please log in to access this page.'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
# with app.app_context():
#     db.create_all()
#     print("✅ All tables created successfully in PostgreSQL.")
# EAT timezone
EAT = timezone(timedelta(hours=3))

# Routes
@app.route('/')
@login_required
def dashboard():
    """Main dashboard for store keeper"""
    # Get accessible branches for current user
    accessible_branches = current_user.get_accessible_branches()
    
    # Get inventory summary
    total_products = 0
    low_stock_products = 0
    out_of_stock_products = 0
    
    for branch in accessible_branches:
        branch_products = BranchProduct.query.filter_by(branchid=branch.id).all()
        total_products += len(branch_products)
        
        for bp in branch_products:
            if bp.stock is not None:
                if bp.stock <= 0:
                    out_of_stock_products += 1
                elif bp.stock <= 10:  # Assuming 10 is low stock threshold
                    low_stock_products += 1
    
    # Recent stock transactions
    recent_transactions = StockTransaction.query.join(BranchProduct).filter(
        BranchProduct.branchid.in_([b.id for b in accessible_branches])
    ).order_by(StockTransaction.created_at.desc()).limit(10).all()
    
    return render_template('dashboard.html', 
                         total_products=total_products,
                         low_stock_products=low_stock_products,
                         out_of_stock_products=out_of_stock_products,
                         recent_transactions=recent_transactions,
                         accessible_branches=accessible_branches)

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page"""
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = User.query.filter_by(email=email).first()
        
        # Debug information
        print(f"DEBUG: Login attempt for email: {email}")
        if user:
            print(f"DEBUG: User found - ID: {user.id}, Role: {user.role}")
            print(f"DEBUG: Password is hashed: {user.is_password_hashed()}")
            print(f"DEBUG: Password check result: {user.check_password(password)}")
        else:
            print("DEBUG: No user found with this email")
        
        if user and user.check_password(password):
            # Check if user has store keeper role or similar
            if user.role in ['store_keeper', 'inventory_keeper', 'admin', 'Store', 'store', 'STORE']:
                login_user(user)
                return redirect(url_for('dashboard'))
            else:
                flash(f'Access denied. Your role "{user.role}" does not have permission to access this portal. Required roles: Store, store_keeper, inventory_keeper, or admin.', 'error')
        else:
            if user:
                flash('Invalid password. Please check your password and try again.', 'error')
            else:
                flash('Invalid email. No user found with this email address.', 'error')
    
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    """Logout user"""
    logout_user()
    return redirect(url_for('login'))

@app.route('/products')
@login_required
def products():
    """Product catalog management"""
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', '')
    
    query = ProductCatalog.query
    if search:
        query = query.filter(ProductCatalog.name.ilike(f'%{search}%'))
    
    products = query.paginate(page=page, per_page=20, error_out=False)
    categories = Category.query.all()
    subcategories = SubCategory.query.all()
    
    return render_template('products.html', products=products, categories=categories, subcategories=subcategories)

@app.route('/products/add', methods=['GET', 'POST'])
@login_required
def add_product():
    """Add new product to catalog"""
    if request.method == 'POST':
        name = request.form['name']
        productcode = request.form.get('productcode', '')
        image_url = request.form.get('image_url', '')
        subcategory_id = request.form.get('subcategory_id')
        
        # Handle image upload to Cloudinary
        if 'image' in request.files:
            image_file = request.files['image']
            if image_file and image_file.filename != '':
                try:
                    # Upload to Cloudinary
                    upload_result = cloudinary.uploader.upload(
                        image_file,
                        folder="products",
                        resource_type="image"
                    )
                    image_url = upload_result.get('secure_url')
                except Exception as e:
                    flash(f'Error uploading image: {str(e)}', 'warning')
        
        product = ProductCatalog(
            name=name,
            productcode=productcode,
            image_url=image_url,
            subcategory_id=subcategory_id if subcategory_id else None
        )
        
        try:
            db.session.add(product)
            db.session.commit()
            flash('Product added successfully!', 'success')
            return redirect(url_for('products'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error adding product: {str(e)}', 'error')
    
    categories = Category.query.all()
    subcategories = SubCategory.query.all()
    return render_template('add_product.html', categories=categories, subcategories=subcategories)

@app.route('/products/edit/<int:product_id>', methods=['GET', 'POST'])
@login_required
def edit_product(product_id):
    """Edit product in catalog"""
    product = ProductCatalog.query.get_or_404(product_id)
    
    if request.method == 'POST':
        product.name = request.form['name']
        product.productcode = request.form.get('productcode', '')
        image_url = request.form.get('image_url', '')
        product.subcategory_id = request.form.get('subcategory_id') if request.form.get('subcategory_id') else None
        
        # Handle image upload to Cloudinary
        if 'image' in request.files:
            image_file = request.files['image']
            if image_file and image_file.filename != '':
                try:
                    # Upload to Cloudinary
                    upload_result = cloudinary.uploader.upload(
                        image_file,
                        folder="products",
                        resource_type="image"
                    )
                    image_url = upload_result.get('secure_url')
                except Exception as e:
                    flash(f'Error uploading image: {str(e)}', 'warning')
        
        product.image_url = image_url
        
        try:
            db.session.commit()
            flash('Product updated successfully!', 'success')
            return redirect(url_for('products'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error updating product: {str(e)}', 'error')
    
    categories = Category.query.all()
    subcategories = SubCategory.query.all()
    return render_template('edit_product.html', product=product, categories=categories, subcategories=subcategories)

@app.route('/branch-products')
@login_required
def branch_products():
    """Branch products management"""
    page = request.args.get('page', 1, type=int)
    branch_id = request.args.get('branch_id', type=int)
    search = request.args.get('search', '')
    
    # Get accessible branches
    accessible_branches = current_user.get_accessible_branches()
    
    query = BranchProduct.query.join(ProductCatalog).join(Branch)
    
    # Filter by accessible branches
    if accessible_branches:
        query = query.filter(Branch.id.in_([b.id for b in accessible_branches]))
    
    # Filter by specific branch
    if branch_id:
        query = query.filter(BranchProduct.branchid == branch_id)
    
    # Search filter
    if search:
        query = query.filter(ProductCatalog.name.ilike(f'%{search}%'))
    
    # Get all products for statistics (without pagination)
    all_products = query.all()
    
    # Calculate statistics
    total_products = len(all_products)
    total_asset_value = sum((bp.buyingprice or 0) * (bp.stock or 0) for bp in all_products)
    total_retail_value = sum((bp.sellingprice or 0) * (bp.stock or 0) for bp in all_products)
    low_stock_count = sum(1 for bp in all_products if bp.stock is not None and 0 < bp.stock <= 10)
    out_of_stock_count = sum(1 for bp in all_products if bp.stock is None or bp.stock <= 0)
    in_stock_count = sum(1 for bp in all_products if bp.stock is not None and bp.stock > 10)
    
    # Format currency values - remove unnecessary decimals but keep meaningful ones
    def format_currency(value):
        # Convert to float and check if it has meaningful decimals
        num = float(value)
        if num == int(num):
            # No decimals needed, format with commas only
            return "{:,.0f}".format(num)
        else:
            # Has decimals, show up to 2 decimal places
            formatted = "{:,.2f}".format(num)
            # Remove trailing zeros after decimal point
            if '.' in formatted:
                formatted = formatted.rstrip('0').rstrip('.')
            return formatted
    
    total_asset_value_formatted = format_currency(total_asset_value)
    total_retail_value_formatted = format_currency(total_retail_value)
    
    # Get paginated products
    branch_products_paginated = query.paginate(page=page, per_page=20, error_out=False)
    
    return render_template('branch_products.html', 
                         branch_products=branch_products_paginated, 
                         accessible_branches=accessible_branches,
                         selected_branch=branch_id,
                         total_products=total_products,
                         total_asset_value=total_asset_value_formatted,
                         total_retail_value=total_retail_value_formatted,
                         low_stock_count=low_stock_count,
                         out_of_stock_count=out_of_stock_count,
                         in_stock_count=in_stock_count)

@app.route('/branch-products/add', methods=['GET', 'POST'])
@login_required
def add_branch_product():
    """Add product to branch"""
    if request.method == 'POST':
        branch_id = request.form['branch_id']
        catalog_id = request.form['catalog_id']
        buyingprice = request.form.get('buyingprice', type=float)
        sellingprice = request.form.get('sellingprice', type=float)
        stock = request.form.get('stock', type=int)
        display = 'display' in request.form
        
        # Check if user has access to this branch
        if not current_user.has_branch_access(int(branch_id)):
            flash('You do not have access to this branch.', 'error')
            return redirect(url_for('add_branch_product'))
        
        branch_product = BranchProduct(
            branchid=branch_id,
            catalog_id=catalog_id,
            buyingprice=buyingprice,
            sellingprice=sellingprice,
            stock=stock,
            display=display
        )
        
        try:
            db.session.add(branch_product)
            db.session.commit()
            flash('Product added to branch successfully!', 'success')
            return redirect(url_for('branch_products'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error adding product to branch: {str(e)}', 'error')
    
    accessible_branches = current_user.get_accessible_branches()
    catalog_products = ProductCatalog.query.all()
    return render_template('add_branch_product.html', 
                         accessible_branches=accessible_branches, 
                         catalog_products=catalog_products)

@app.route('/branch-products/edit/<int:branch_product_id>', methods=['GET', 'POST'])
@login_required
def edit_branch_product(branch_product_id):
    """Edit branch product"""
    branch_product = BranchProduct.query.get_or_404(branch_product_id)
    
    # Check access
    if not current_user.has_branch_access(branch_product.branchid):
        flash('You do not have access to this branch product.', 'error')
        return redirect(url_for('branch_products'))
    
    if request.method == 'POST':
        branch_product.buyingprice = request.form.get('buyingprice', type=float)
        branch_product.sellingprice = request.form.get('sellingprice', type=float)
        branch_product.stock = request.form.get('stock', type=int)
        branch_product.display = 'display' in request.form
        
        try:
            db.session.commit()
            flash('Branch product updated successfully!', 'success')
            return redirect(url_for('branch_products'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error updating branch product: {str(e)}', 'error')
    
    accessible_branches = current_user.get_accessible_branches()
    return render_template('edit_branch_product.html', 
                         branch_product=branch_product, 
                         accessible_branches=accessible_branches)

@app.route('/stock-transfers')
@login_required
def stock_transfers():
    """Stock transfer management"""
    page = request.args.get('page', 1, type=int)
    
    # Get accessible branches
    accessible_branches = current_user.get_accessible_branches()
    branch_ids = [b.id for b in accessible_branches]
    
    # Get stock transfers where user has access to either source or destination branch
    transfers = StockTransfer.query.join(
        BranchProduct, StockTransfer.from_branch_product_id == BranchProduct.id
    ).filter(
        BranchProduct.branchid.in_(branch_ids)
    ).order_by(StockTransfer.created_at.desc()).paginate(page=page, per_page=20, error_out=False)
    
    return render_template('stock_transfers.html', 
                         transfers=transfers, 
                         accessible_branches=accessible_branches)

@app.route('/stock-transfers/initiate', methods=['GET', 'POST'])
@login_required
def initiate_stock_transfer():
    """Initiate stock transfer between branches"""
    if request.method == 'POST':
        from_branch_id = request.form['from_branch_id']
        to_branch_id = request.form['to_branch_id']
        branch_product_id = request.form['branch_product_id']
        quantity = request.form.get('quantity', type=float)
        notes = request.form.get('notes', '')
        
        # Check access to both branches
        if not (current_user.has_branch_access(int(from_branch_id)) and 
                current_user.has_branch_access(int(to_branch_id))):
            flash('You do not have access to one or both branches.', 'error')
            return redirect(url_for('initiate_stock_transfer'))
        
        # Get the source branch product
        source_bp = BranchProduct.query.get(branch_product_id)
        if not source_bp or source_bp.branchid != int(from_branch_id):
            flash('Invalid source product.', 'error')
            return redirect(url_for('initiate_stock_transfer'))
        
        if source_bp.stock < quantity:
            flash('Insufficient stock for transfer.', 'error')
            return redirect(url_for('initiate_stock_transfer'))
        
        # Check if destination branch has this product (same catalog_id)
        dest_bp = BranchProduct.query.filter_by(
            branchid=to_branch_id, 
            catalog_id=source_bp.catalog_id
        ).first()
        
        # If destination doesn't have product, create it first
        if not dest_bp:
            dest_bp = BranchProduct(
                branchid=to_branch_id,
                catalog_id=source_bp.catalog_id,
                buyingprice=source_bp.buyingprice,
                sellingprice=source_bp.sellingprice,
                stock=0,
                display=source_bp.display
            )
            db.session.add(dest_bp)
            db.session.flush()  # Get the ID for the stock transfer
        
        try:
            # Create the StockTransfer record
            stock_transfer = StockTransfer(
                from_branch_product_id=source_bp.id,
                to_branch_product_id=dest_bp.id,
                catalog_product_id=source_bp.catalog_id,
                quantity=quantity,
                initiated_by=current_user.id,
                status='completed',
                notes=notes
            )
            db.session.add(stock_transfer)
            db.session.flush()  # Get the transfer ID
            
            # Create stock transaction for removal from source
            removal_transaction = StockTransaction(
                branch_productid=source_bp.id,
                userid=current_user.id,
                transaction_type='remove',
                quantity=quantity,
                previous_stock=source_bp.stock,
                new_stock=source_bp.stock - quantity,
                stock_transfer_id=stock_transfer.id,
                notes=f"Transfer to {dest_bp.branch.name}"
            )
            db.session.add(removal_transaction)
            
            # Update source stock
            source_bp.stock -= quantity
            
            # Create stock transaction for addition to destination
            addition_transaction = StockTransaction(
                branch_productid=dest_bp.id,
                userid=current_user.id,
                transaction_type='add',
                quantity=quantity,
                previous_stock=dest_bp.stock,
                new_stock=dest_bp.stock + quantity,
                stock_transfer_id=stock_transfer.id,
                notes=f"Transfer from {source_bp.branch.name}"
            )
            db.session.add(addition_transaction)
            
            # Update destination stock
            dest_bp.stock += quantity
            
            db.session.commit()
            flash('Stock transfer completed successfully!', 'success')
            return redirect(url_for('stock_transfers'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error processing stock transfer: {str(e)}', 'error')
    
    accessible_branches = current_user.get_accessible_branches()
    return render_template('initiate_stock_transfer.html', accessible_branches=accessible_branches)

@app.route('/api/branch-products/<int:branch_id>')
@login_required
def get_branch_products(branch_id):
    """API endpoint to get products for a specific branch"""
    if not current_user.has_branch_access(branch_id):
        return jsonify({'error': 'Access denied'}), 403
    
    try:
        products = BranchProduct.query.filter_by(branchid=branch_id).all()
        result = [{
            'id': bp.id,
            'name': bp.catalog_product.name,
            'stock': float(bp.stock) if bp.stock is not None else 0,
            'sellingprice': float(bp.sellingprice) if bp.sellingprice else None,
            'catalog_id': bp.catalog_id
        } for bp in products]
        print(f"DEBUG: Found {len(result)} products for branch {branch_id}")
        return jsonify(result)
    except Exception as e:
        print(f"ERROR in get_branch_products: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/transfer-products/<int:from_branch_id>/<int:to_branch_id>')
@login_required
def get_transfer_products(from_branch_id, to_branch_id):
    """API endpoint to get products that exist in both branches (same catalog_id)"""
    print(f"\n=== API CALL: get_transfer_products ===")
    print(f"From Branch: {from_branch_id}, To Branch: {to_branch_id}")
    print(f"User: {current_user.email}")
    
    if not (current_user.has_branch_access(from_branch_id) and current_user.has_branch_access(to_branch_id)):
        print(f"Access denied for user {current_user.email}")
        return jsonify({'error': 'Access denied'}), 403
    
    try:
        print(f"Querying products from branch {from_branch_id}...")
        
        # Get products from source branch with stock > 0
        from_products = BranchProduct.query.filter(
            BranchProduct.branchid == from_branch_id,
            BranchProduct.stock > 0
        ).all()
        
        print(f"Found {len(from_products)} products with stock > 0 in source branch")
        
        # Get catalog IDs from destination branch
        to_products = BranchProduct.query.filter_by(branchid=to_branch_id).all()
        to_catalog_ids = {bp.catalog_id for bp in to_products}
        
        print(f"Destination branch has {len(to_catalog_ids)} unique catalog IDs")
        
        # Build result list
        result = []
        for bp in from_products:
            product_data = {
                'id': bp.id,
                'name': bp.catalog_product.name,
                'stock': float(bp.stock),
                'catalog_id': bp.catalog_id,
                'exists_in_destination': bp.catalog_id in to_catalog_ids
            }
            result.append(product_data)
            print(f"  - {bp.catalog_product.name}: stock={bp.stock}, catalog_id={bp.catalog_id}, in_dest={bp.catalog_id in to_catalog_ids}")
        
        print(f"Returning {len(result)} products")
        print(f"=== END API CALL ===\n")
        return jsonify(result)
    except Exception as e:
        print(f"ERROR in get_transfer_products: {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

@app.route('/inventory-report')
@login_required
def inventory_report():
    """Generate inventory report"""
    accessible_branches = current_user.get_accessible_branches()
    branch_id = request.args.get('branch_id', type=int)
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 50, type=int)  # Allow customizable page size
    
    if branch_id and not current_user.has_branch_access(branch_id):
        flash('You do not have access to this branch.', 'error')
        return redirect(url_for('inventory_report'))
    
    # Build query with eager loading to prevent N+1 queries
    query = BranchProduct.query.options(
        joinedload(BranchProduct.catalog_product),
        joinedload(BranchProduct.branch)
    ).join(ProductCatalog).join(Branch)
    
    if branch_id:
        query = query.filter(BranchProduct.branchid == branch_id)
    else:
        query = query.filter(Branch.id.in_([b.id for b in accessible_branches]))
    
    # Get paginated results
    branch_products_paginated = query.paginate(page=page, per_page=per_page, error_out=False)
    
    # Calculate statistics from all products (not just current page)
    # Use a separate count query for better performance
    stats_query = BranchProduct.query.join(ProductCatalog).join(Branch)
    if branch_id:
        stats_query = stats_query.filter(BranchProduct.branchid == branch_id)
    else:
        stats_query = stats_query.filter(Branch.id.in_([b.id for b in accessible_branches]))
    
    # Get counts efficiently using database aggregation
    from sqlalchemy import func, case
    stats = db.session.query(
        func.count(BranchProduct.id).label('total_products'),
        func.sum(case((BranchProduct.stock > 10, 1), else_=0)).label('in_stock_count'),
        func.sum(case(((BranchProduct.stock > 0) & (BranchProduct.stock <= 10), 1), else_=0)).label('low_stock_count'),
        func.sum(case(((BranchProduct.stock == None) | (BranchProduct.stock <= 0), 1), else_=0)).label('out_of_stock_count')
    ).select_from(BranchProduct).join(ProductCatalog).join(Branch)
    
    if branch_id:
        stats = stats.filter(BranchProduct.branchid == branch_id)
    else:
        stats = stats.filter(Branch.id.in_([b.id for b in accessible_branches]))
    
    stats_result = stats.first()
    
    return render_template('inventory_report.html', 
                         branch_products=branch_products_paginated, 
                         accessible_branches=accessible_branches,
                         selected_branch=branch_id,
                         total_products=stats_result.total_products or 0,
                         in_stock_count=stats_result.in_stock_count or 0,
                         low_stock_count=stats_result.low_stock_count or 0,
                         out_of_stock_count=stats_result.out_of_stock_count or 0)

@app.route('/products/delete/<int:product_id>', methods=['POST'])
@login_required
def delete_product(product_id):
    """Delete product from catalog"""
    product = ProductCatalog.query.get_or_404(product_id)
    
    try:
        # Check if product is used in any branch
        if BranchProduct.query.filter_by(catalog_id=product.id).first():
            flash('Cannot delete product. It is being used in one or more branches.', 'error')
            return redirect(url_for('products'))
        
        db.session.delete(product)
        db.session.commit()
        flash('Product deleted successfully!', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error deleting product: {str(e)}', 'error')
    
    return redirect(url_for('products'))

@app.route('/branch-products/adjust-stock/<int:branch_product_id>', methods=['POST'])
@login_required
def adjust_stock(branch_product_id):
    """Adjust stock for branch product"""
    branch_product = BranchProduct.query.get_or_404(branch_product_id)
    
    # Check access
    if not current_user.has_branch_access(branch_product.branchid):
        flash('You do not have access to this branch product.', 'error')
        return redirect(url_for('branch_products'))
    
    adjustment_type = request.form['adjustment_type']
    quantity = float(request.form['quantity'])
    notes = request.form.get('notes', '')
    
    if adjustment_type == 'add':
        new_stock = (branch_product.stock or 0) + quantity
        transaction_type = 'add'
    elif adjustment_type == 'remove':
        if (branch_product.stock or 0) < quantity:
            flash('Insufficient stock for removal.', 'error')
            return redirect(url_for('branch_products'))
        new_stock = (branch_product.stock or 0) - quantity
        transaction_type = 'remove'
    elif adjustment_type == 'set':
        new_stock = quantity
        transaction_type = 'add' if quantity > (branch_product.stock or 0) else 'remove'
        quantity = abs(quantity - (branch_product.stock or 0))
    
    # Create stock transaction
    transaction = StockTransaction(
        branch_productid=branch_product_id,
        userid=current_user.id,
        transaction_type=transaction_type,
        quantity=quantity,
        previous_stock=branch_product.stock or 0,
        new_stock=new_stock,
        notes=notes
    )
    
    # Update stock
    branch_product.stock = new_stock
    
    try:
        db.session.add(transaction)
        db.session.commit()
        flash('Stock adjusted successfully!', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error adjusting stock: {str(e)}', 'error')
    
    return redirect(url_for('branch_products'))

@app.route('/debug/users')
def debug_users():
    """Debug route to check users and their roles"""
    users = User.query.all()
    user_info = []
    for user in users:
        user_info.append({
            'id': user.id,
            'email': user.email,
            'firstname': user.firstname,
            'lastname': user.lastname,
            'role': user.role,
            'password_hashed': user.is_password_hashed(),
            'accessible_branches': user.accessible_branch_ids
        })
    return jsonify(user_info)

@app.route('/debug/fix-user/<int:user_id>')
def fix_user(user_id):
    """Debug route to fix user role and password"""
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'User not found'})
    
    # Update role to Store if it's not one of the allowed roles
    if user.role not in ['store_keeper', 'inventory_keeper', 'admin', 'Store', 'store', 'STORE']:
        user.role = 'Store'
        db.session.commit()
        return jsonify({'message': f'Updated user {user.email} role to Store'})
    
    return jsonify({'message': f'User {user.email} already has correct role: {user.role}'})

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
