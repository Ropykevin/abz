from config.dbconfig import db, EAT, datetime, secrets, string
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin

# ============================================================================
# SITE PORTAL SPECIFIC MODELS
# ============================================================================

class SiteOwner(UserMixin, db.Model):
    """Site Owner model for the portal"""
    __tablename__ = 'site_owners'

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255), nullable=False, unique=True, index=True)
    password = db.Column(db.String(255), nullable=False)
    firstname = db.Column(db.String(100), nullable=False)
    lastname = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(20), nullable=True)
    is_active = db.Column(db.Boolean, default=True, nullable=False)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    # Relationships
    sites = db.relationship('Site', backref='owner',
                            lazy=True, cascade='all, delete-orphan')

    @property
    def is_authenticated(self):
        return True

    @property
    def is_anonymous(self):
        return False

    def get_id(self):
        return str(self.id)

    def check_password(self, password):
        """Check if the provided password matches the stored hash"""
        return check_password_hash(self.password, password)

    def set_password(self, password):
        """Set a new password with proper hashing"""
        self.password = generate_password_hash(password)

    def __repr__(self):
        return f'<SiteOwner {self.email}>'


class Site(db.Model):
    """Site model linking site owners to construction sites"""
    __tablename__ = 'sites'

    id = db.Column(db.Integer, primary_key=True)
    site_owner_id = db.Column(db.Integer, db.ForeignKey(
        'site_owners.id'), nullable=False, index=True)
    site_name = db.Column(db.String(255), nullable=False)
    location = db.Column(db.String(255), nullable=False)
    address = db.Column(db.Text, nullable=True)
    contact_person = db.Column(db.String(255), nullable=True)
    contact_phone = db.Column(db.String(20), nullable=True)
    contact_email = db.Column(db.String(255), nullable=True)
    is_active = db.Column(db.Boolean, default=True, nullable=False)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    # Relationships - defined using string references to avoid forward reference issues
    # quotations = relationship defined via Quotation.site_id foreign key
    # orders = relationship defined via Order.site_id foreign key

    def __repr__(self):
        return f'<Site {self.site_name}>'


class QuotationRequest(db.Model):
    """Quotation Request model - requests made by site owners"""
    __tablename__ = 'quotation_requests'

    id = db.Column(db.Integer, primary_key=True)
    site_id = db.Column(db.Integer, db.ForeignKey(
        'sites.id'), nullable=False, index=True)
    site_owner_id = db.Column(db.Integer, db.ForeignKey(
        'site_owners.id'), nullable=False, index=True)
    branch_id = db.Column(db.Integer, db.ForeignKey(
        'branch.id'), nullable=False)
    items_json = db.Column(db.Text, nullable=False)  # JSON string of items
    notes = db.Column(db.Text, nullable=True)
    # pending, reviewing, quoted, cancelled
    status = db.Column(db.String(50), default='pending', nullable=False)
    quotation_id = db.Column(db.Integer, db.ForeignKey(
        'quotations.id'), nullable=True)  # Link to created quotation
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    # Relationships
    site = db.relationship('Site', backref='quotation_requests')
    site_owner = db.relationship('SiteOwner', backref='quotation_requests')
    branch = db.relationship('Branch', backref='quotation_requests')
    quotation = db.relationship(
        'Quotation', backref='quotation_request', uselist=False)

    def get_items(self):
        """Parse items JSON and return as list"""
        import json
        try:
            return json.loads(self.items_json) if self.items_json else []
        except:
            return []

    def set_items(self, items_list):
        """Set items as JSON string"""
        import json
        self.items_json = json.dumps(items_list)

    def __repr__(self):
        return f'<QuotationRequest {self.id} - Site {self.site_id}>'


# ============================================================================
# SHARED MODELS FROM SALES PORTAL (for database access)
# ============================================================================

class Branch(db.Model):
    __tablename__ = 'branch'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    location = db.Column(db.String, nullable=False)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    image_url = db.Column(db.String, nullable=True)
    branch_products = db.relationship(
        'BranchProduct', backref='branch', lazy=True)
    orders = db.relationship('Order', backref='branch', lazy=True)


class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    image_url = db.Column(db.String, nullable=True)
    sub_categories = db.relationship(
        'SubCategory', backref='category', lazy=True)


class SubCategory(db.Model):
    __tablename__ = 'sub_category'
    id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(db.Integer, db.ForeignKey(
        'category.id'), nullable=False)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    image_url = db.Column(db.String, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String, nullable=False, unique=True)
    firstname = db.Column(db.String, nullable=False)
    lastname = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=False)
    role = db.Column(db.String, nullable=False)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    phone = db.Column(db.String, nullable=True)
    accessible_branch_ids = db.Column(db.JSON, nullable=True, default=list)
    orders = db.relationship('Order', backref='user', lazy=True)
    payments = db.relationship('Payment', backref='user', lazy=True)


class OrderType(db.Model):
    __tablename__ = 'ordertypes'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    orders = db.relationship('Order', backref='ordertype', lazy=True)


class Order(db.Model):
    __tablename__ = 'orders'
    id = db.Column(db.Integer, primary_key=True)
    userid = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    ordertypeid = db.Column(db.Integer, db.ForeignKey(
        'ordertypes.id'), nullable=False)
    branchid = db.Column(db.Integer, db.ForeignKey(
        'branch.id'), nullable=False)
    site_id = db.Column(db.Integer, db.ForeignKey(
        'sites.id'), nullable=True, index=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))
    approvalstatus = db.Column(db.Boolean, default=False)
    approved_at = db.Column(db.DateTime, nullable=True)
    # pending, paid, failed, refunded
    payment_status = db.Column(db.String, default='pending')

    order_items = db.relationship('OrderItem', backref='order', lazy=True)
    payments = db.relationship('Payment', backref='order', lazy=True)
    invoices = db.relationship('Invoice', backref='order', lazy=True)
    receipts = db.relationship('Receipt', backref='order', lazy=True)
    deliveries = db.relationship('Delivery', backref='order', lazy=True)


class OrderItem(db.Model):
    __tablename__ = 'orderitems'
    id = db.Column(db.Integer, primary_key=True)
    orderid = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    productid = db.Column(db.Integer, nullable=True)
    branch_productid = db.Column(db.Integer, db.ForeignKey(
        'branch_products.id'), nullable=True)
    product_name = db.Column(db.String(255), nullable=True)
    quantity = db.Column(db.Numeric(10, 3), nullable=False)
    buying_price = db.Column(db.Numeric(10, 2), nullable=True)
    original_price = db.Column(db.Numeric(10, 2), nullable=True)
    negotiated_price = db.Column(db.Numeric(10, 2), nullable=True)
    final_price = db.Column(db.Numeric(10, 2), nullable=True)
    negotiation_notes = db.Column(db.String, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    branch_product = db.relationship(
        "BranchProduct", back_populates="order_items")


class Payment(db.Model):
    __tablename__ = 'payments'
    id = db.Column(db.Integer, primary_key=True)
    orderid = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    userid = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    amount = db.Column(db.Numeric(10, 2), nullable=False)
    payment_method = db.Column(db.String, nullable=False)
    payment_status = db.Column(db.String, nullable=False)
    transaction_id = db.Column(db.String, nullable=True)
    reference_number = db.Column(db.String, nullable=True)
    notes = db.Column(db.String, nullable=True)
    payment_date = db.Column(db.DateTime, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    receipts = db.relationship('Receipt', backref='payment', lazy=True)


class Invoice(db.Model):
    __tablename__ = 'invoices'
    id = db.Column(db.Integer, primary_key=True)
    orderid = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    invoice_number = db.Column(db.String, nullable=False, unique=True)
    total_amount = db.Column(db.Numeric(10, 2), nullable=False)
    tax_amount = db.Column(db.Numeric(10, 2), default=0.00)
    discount_amount = db.Column(db.Numeric(10, 2), default=0.00)
    subtotal = db.Column(db.Numeric(10, 2), nullable=False)
    status = db.Column(db.String, default='pending')
    due_date = db.Column(db.DateTime, nullable=True)
    notes = db.Column(db.String, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))


class Receipt(db.Model):
    __tablename__ = 'receipts'
    id = db.Column(db.Integer, primary_key=True)
    paymentid = db.Column(db.Integer, db.ForeignKey(
        'payments.id'), nullable=False)
    orderid = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    receipt_number = db.Column(db.String, nullable=False, unique=True)
    payment_amount = db.Column(db.Numeric(10, 2), nullable=False)
    previous_balance = db.Column(db.Numeric(10, 2), nullable=False)
    remaining_balance = db.Column(db.Numeric(10, 2), nullable=False)
    payment_method = db.Column(db.String, nullable=False)
    reference_number = db.Column(db.String, nullable=True)
    transaction_id = db.Column(db.String, nullable=True)
    notes = db.Column(db.String, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))


class Delivery(db.Model):
    __tablename__ = 'deliveries'
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.Integer, db.ForeignKey(
        'orders.id'), nullable=False)
    delivery_amount = db.Column(db.Numeric(10, 2), nullable=False)
    delivery_location = db.Column(db.String, nullable=False)
    customer_phone = db.Column(db.String, nullable=False)
    delivery_status = db.Column(db.String, default='pending')
    payment_status = db.Column(db.String, default='pending')
    agreed_delivery_time = db.Column(db.DateTime, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    notes = db.Column(db.String, nullable=True)


class Quotation(db.Model):
    __tablename__ = 'quotations'
    id = db.Column(db.Integer, primary_key=True)
    quotation_number = db.Column(db.String, unique=True, nullable=False)
    customer_name = db.Column(db.String, nullable=False)
    customer_email = db.Column(db.String, nullable=True)
    customer_phone = db.Column(db.String, nullable=True)
    created_by = db.Column(
        db.Integer, db.ForeignKey('users.id'), nullable=False)
    branch_id = db.Column(db.Integer, db.ForeignKey(
        'branch.id'), nullable=False)
    site_id = db.Column(db.Integer, db.ForeignKey(
        'sites.id'), nullable=True, index=True)
    subtotal = db.Column(db.Numeric(10, 2), nullable=False, default=0.00)
    discount_percentage = db.Column(
        db.Numeric(5, 2), nullable=True, default=0.00)
    total_amount = db.Column(db.Numeric(10, 2), nullable=False, default=0.00)
    include_vat = db.Column(db.Boolean, default=False, nullable=False)
    vat_rate = db.Column(db.Numeric(5, 2), default=16.00, nullable=False)
    show_quantity_in_pdf = db.Column(db.Boolean, default=True, nullable=False)
    status = db.Column(db.String, default='pending')
    valid_until = db.Column(db.DateTime, nullable=True)
    notes = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    items = db.relationship(
        'QuotationItem', backref='quotation', lazy=True, cascade='all, delete-orphan')
    creator = db.relationship('User', backref='quotations_created')
    branch = db.relationship('Branch', backref='quotations')

    @property
    def discount_amount(self):
        """Calculate discount amount based on subtotal and discount_percentage"""
        from decimal import Decimal
        if self.discount_percentage and self.subtotal:
            return Decimal(str(self.subtotal)) * (Decimal(str(self.discount_percentage)) / Decimal('100'))
        return Decimal('0.00')

    @property
    def subtotal_after_discount(self):
        """Calculate subtotal after discount"""
        from decimal import Decimal
        return Decimal(str(self.subtotal)) - self.discount_amount

    @property
    def vat_amount(self):
        """Calculate VAT amount based on subtotal after discount and vat_rate"""
        from decimal import Decimal
        if self.include_vat:
            return self.subtotal_after_discount * (Decimal(str(self.vat_rate)) / Decimal('100'))
        return Decimal('0.00')

    def calculate_totals(self):
        """Recalculate subtotal and total_amount based on items"""
        from decimal import Decimal
        self.subtotal = sum(
            item.total_price for item in self.items) if self.items else Decimal('0.00')
        self.total_amount = self.subtotal_after_discount + self.vat_amount


class QuotationItem(db.Model):
    __tablename__ = 'quotationitems'
    id = db.Column(db.Integer, primary_key=True)
    quotation_id = db.Column(db.Integer, db.ForeignKey(
        'quotations.id'), nullable=False)
    product_id = db.Column(db.Integer, nullable=True)
    branch_productid = db.Column(db.Integer, db.ForeignKey(
        'branch_products.id'), nullable=True)
    quantity = db.Column(db.Numeric(10, 3), nullable=False)
    unit = db.Column(db.String(50), nullable=True)
    unit_price = db.Column(db.Numeric(10, 2), nullable=False)
    price_unit = db.Column(db.String(50), nullable=True)
    total_price = db.Column(db.Numeric(10, 2), nullable=False)
    notes = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    product_name = db.Column(db.String(255), nullable=True)

    branch_product = db.relationship(
        "BranchProduct", back_populates="quotation_items")


# Relationships will be set up automatically via foreign keys
# Site.quotations and Site.orders are accessible via the foreign key relationships


class ProductCatalog(db.Model):
    __tablename__ = 'product_catalog'
    id = db.Column(db.Integer, primary_key=True, index=True)
    name = db.Column(db.String, nullable=False)
    productcode = db.Column(db.String, nullable=True)
    image_url = db.Column(db.String, nullable=True)
    subcategory_id = db.Column(db.Integer, nullable=True)
    branch_products = db.relationship(
        "BranchProduct", back_populates="catalog_product")


class BranchProduct(db.Model):
    __tablename__ = 'branch_products'
    id = db.Column(db.Integer, primary_key=True, index=True)
    branchid = db.Column(db.Integer, db.ForeignKey(
        'branch.id'), nullable=False, index=True)
    catalog_id = db.Column(db.Integer, db.ForeignKey(
        'product_catalog.id'), nullable=False, index=True)
    buyingprice = db.Column(db.Numeric(10, 2), nullable=True)
    sellingprice = db.Column(db.Numeric(10, 2), nullable=True)
    stock = db.Column(db.Integer, nullable=True)
    display = db.Column(db.Boolean, default=True, index=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(
        EAT), onupdate=lambda: datetime.now(EAT))

    catalog_product = db.relationship(
        "ProductCatalog", back_populates="branch_products")
    order_items = db.relationship("OrderItem", back_populates="branch_product")
    quotation_items = db.relationship(
        "QuotationItem", back_populates="branch_product")
