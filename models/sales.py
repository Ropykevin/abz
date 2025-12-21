from config.dbconfig import db, EAT, datetime

# ============================================================================
# SALES PORTAL SPECIFIC MODELS
# Note: Most models are defined in models.admin.py and should be imported from there
# ============================================================================

class SiteOwner(db.Model):
    """Site Owner model - shared from site portal"""
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

    def __repr__(self):
        return f'<SiteOwner {self.email}>'


class Site(db.Model):
    """Site model - shared from site portal"""
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
    # Note: Branch and Quotation are defined in models.admin
    site = db.relationship('Site', backref='quotation_requests')
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
