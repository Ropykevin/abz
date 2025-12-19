from config.dbconfig import db, EAT, datetime, secrets, string









class ExpenseV2(db.Model):
    __tablename__ = 'expenses_v2'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.Text, nullable=True)
    amount = db.Column(db.Numeric(10, 2), nullable=False)  # Total expense amount
    category = db.Column(db.String, nullable=False)  # rent, utilities, salaries, supplies, marketing, etc.
    expense_date = db.Column(db.Date, nullable=False)
    receipt_urls = db.Column(db.JSON, nullable=True)  # Array of URLs to uploaded receipt images
    branch_id = db.Column(db.Integer, db.ForeignKey('branch.id'), nullable=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)  # Who created the expense
    approved_by = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=True)  # Who approved the expense
    status = db.Column(db.String, default='pending')  # pending, approved, rejected
    approval_notes = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT), onupdate=lambda: datetime.now(EAT))
    
    # Relationships
    branch = db.relationship('Branch', backref='expenses_v2', lazy=True)
    user = db.relationship('User', foreign_keys=[user_id], backref='expenses_v2_recorded', lazy=True)
    approver = db.relationship('User', foreign_keys=[approved_by], backref='expenses_v2_approved', lazy=True)
    payments = db.relationship('ExpensePayment', backref='expense', lazy=True, cascade='all, delete-orphan')
    
    @property
    def total_paid(self):
        """Calculate total amount paid for this expense"""
        return sum(payment.amount for payment in self.payments if payment.status == 'completed')
    
    @property
    def balance(self):
        """Calculate remaining balance for this expense"""
        return float(self.amount) - self.total_paid
    
    @property
    def is_fully_paid(self):
        """Check if expense is fully paid"""
        return self.balance <= 0
    
    @property
    def payment_status(self):
        """Get payment status as string"""
        if self.is_fully_paid:
            return 'fully_paid'
        elif self.total_paid > 0:
            return 'partially_paid'
        else:
            return 'unpaid'
    
    @property
    def receipt_list(self):
        """Get receipt URLs as a list"""
        if self.receipt_urls:
            return self.receipt_urls if isinstance(self.receipt_urls, list) else [self.receipt_urls]
        return []
    
    @property
    def has_receipts(self):
        """Check if expense has any receipts"""
        return len(self.receipt_list) > 0


class ExpensePayment(db.Model):
    __tablename__ = 'expense_payments'
    id = db.Column(db.Integer, primary_key=True)
    expense_id = db.Column(db.Integer, db.ForeignKey('expenses_v2.id'), nullable=False)
    amount = db.Column(db.Numeric(10, 2), nullable=False)  # Payment amount
    payment_method = db.Column(db.String, nullable=False)  # cash, bank_transfer, card, mobile_money, cheque
    payment_date = db.Column(db.Date, nullable=False)
    payment_reference = db.Column(db.String, nullable=True)  # Transaction reference, cheque number, etc.
    notes = db.Column(db.Text, nullable=True)  # Additional payment notes
    status = db.Column(db.String, default='pending')  # pending, completed, cancelled
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)  # Who recorded the payment
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT))
    updated_at = db.Column(db.DateTime, default=lambda: datetime.now(EAT), onupdate=lambda: datetime.now(EAT))
    
    # Relationships
    user = db.relationship('User', backref='expense_payments_recorded', lazy=True)


