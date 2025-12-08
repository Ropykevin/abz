

def send_welcome_email(user):
    """Send welcome email to newly registered user using Brevo API"""
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
        "to": [{"email": user.email, "name": f"{user.firstname} {user.lastname}"}],
        "subject": "Welcome to ABZ Hardware! 🛠️",
        "htmlContent": f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Welcome to ABZ Hardware</title>
            <style>
                body {{
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    margin: 0;
                    padding: 0;
                    background-color: #f4f4f4;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #ffffff;
                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                }}
                .header {{
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 40px 30px;
                    text-align: center;
                }}
                .header h1 {{
                    margin: 0;
                    font-size: 28px;
                    font-weight: 700;
                }}
                .header p {{
                    margin: 10px 0 0 0;
                    font-size: 16px;
                    opacity: 0.9;
                }}
                .content {{
                    padding: 40px 30px;
                }}
                .welcome-section {{
                    text-align: center;
                    margin-bottom: 30px;
                }}
                .welcome-section h2 {{
                    color: #2c3e50;
                    margin-bottom: 15px;
                    font-size: 24px;
                }}
                .account-details {{
                    background-color: #f8f9fa;
                    border-left: 4px solid #ffd700;
                    padding: 20px;
                    margin: 25px 0;
                    border-radius: 5px;
                }}
                .account-details h3 {{
                    color: #2c3e50;
                    margin-top: 0;
                    font-size: 18px;
                }}
                .account-details p {{
                    margin: 8px 0;
                    color: #555;
                }}
                .features {{
                    margin: 30px 0;
                }}
                .features h3 {{
                    color: #2c3e50;
                    margin-bottom: 15px;
                    font-size: 18px;
                }}
                .feature-list {{
                    list-style: none;
                    padding: 0;
                }}
                .feature-list li {{
                    padding: 10px 0;
                    border-bottom: 1px solid #eee;
                    position: relative;
                    padding-left: 30px;
                }}
                .feature-list li:before {{
                    content: "✓";
                    position: absolute;
                    left: 0;
                    color: #27ae60;
                    font-weight: bold;
                    font-size: 16px;
                }}
                .cta-button {{
                    display: inline-block;
                    background: linear-gradient(45deg, #ffd700, #ffed4e);
                    color: #1a1a1a;
                    padding: 15px 30px;
                    text-decoration: none;
                    border-radius: 50px;
                    font-weight: 600;
                    margin: 20px 0;
                    box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
                    transition: all 0.3s ease;
                }}
                .cta-button:hover {{
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(255, 215, 0, 0.4);
                }}
                .footer {{
                    background-color: #2c3e50;
                    color: white;
                    padding: 30px;
                    text-align: center;
                }}
                .footer h4 {{
                    margin: 0 0 15px 0;
                    color: #ffd700;
                }}
                .footer p {{
                    margin: 5px 0;
                    font-size: 14px;
                    opacity: 0.8;
                }}
                .social-links {{
                    margin: 20px 0;
                }}
                .social-links a {{
                    color: #ffd700;
                    text-decoration: none;
                    margin: 0 10px;
                    font-weight: 600;
                }}
                .disclaimer {{
                    font-size: 12px;
                    opacity: 0.6;
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 1px solid #444;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>🛠️ ABZ Hardware</h1>
                    <p>Your Trusted Partner for Quality Tools & Equipment</p>
                </div>
                
                <div class="content">
                    <div class="welcome-section">
                        <h2>Welcome to the Family! 🎉</h2>
                        <p>Dear <strong>{user.firstname} {user.lastname}</strong>,</p>
                        <p>We're thrilled to welcome you to ABZ Hardware! Your account has been successfully created and you're now part of our growing community of professionals and DIY enthusiasts.</p>
                    </div>
                    
                    <div class="account-details">
                        <h3>📋 Your Account Details</h3>
                        <p><strong>Email:</strong> {user.email}</p>
                        <p><strong>Name:</strong> {user.firstname} {user.lastname}</p>
                        <p><strong>Member Since:</strong> {user.created_at.strftime('%B %d, %Y')}</p>
                        <p><strong>Account Type:</strong> Customer</p>
                    </div>
                    
                    <div class="features">
                        <h3>🚀 What You Can Do Now</h3>
                        <ul class="feature-list">
                            <li>Browse our extensive catalog of professional tools and equipment</li>
                            <li>Place orders for quality hardware with secure checkout</li>
                            <li>Track your order history and delivery status</li>
                            <li>Update your profile and manage account settings</li>
                            <li>Access exclusive customer support and expert advice</li>
                            <li>Receive notifications about new products and special offers</li>
                        </ul>
                    </div>
                    
                    <div style="text-align: center; margin: 40px 0;">
                        <a href="https://abzhardware.co.ke" class="cta-button">
                            🛒 Start Shopping Now
                        </a>
                    </div>
                    
                 
                </div>
                
                <div class="footer">
                    <h4>ABZ Hardware</h4>
                    <p>Your trusted partner for premium tools and equipment</p>
                    <div class="social-links">
                        <a href="#">📧 Email Support</a> |
                        <a href="#">📞 Phone Support</a> |
                        <a href="#">🌐 Website</a>
                    </div>
                    <div class="disclaimer">
                        <p>This is an automated welcome message. Please do not reply to this email.</p>
                        <p>For support, visit our website or contact our customer service team.</p>
                    </div>
                </div>
            </div>
        </body>
        </html>
        """
    }
    try:
        response = requests.post(url, headers=headers, json=data)
        if response.status_code == 201:
            print(f"✅ Welcome email sent to {user.email}")
        else:
            print(f"❌ Failed to send welcome email to {user.email}: {response.text}")
    except Exception as e:
        print(f"❌ Exception sending welcome email to {user.email}: {str(e)}")

def send_password_reset_email(user, reset_token):
    """Send password reset email using Brevo API"""
    api_key = app.config['BREVO_API_KEY']
    sender_email = app.config['BREVO_SENDER_EMAIL']
    sender_name = app.config['BREVO_SENDER_NAME']
    url = 'https://api.brevo.com/v3/smtp/email'
    headers = {
        'accept': 'application/json',
        'api-key': api_key,
        'content-type': 'application/json',
    }
    
    reset_url = f"https://abzhardware.co.ke/reset-password/{reset_token}"
    
    # Debug: Print the request data
    print(f"🔍 Debug: Sending password reset email to {user.email}")
    print(f"🔍 Debug: API Key: {api_key[:20]}...")
    print(f"🔍 Debug: Sender Email: {sender_email}")
    print(f"🔍 Debug: Reset URL: {reset_url}")
    
    data = {
        "sender": {"name": sender_name, "email": sender_email},
        "to": [{"email": user.email, "name": f"{user.firstname} {user.lastname}"}],
        "subject": "Password Reset Request - ABZ Hardware 🔐",
        "htmlContent": f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Password Reset - ABZ Hardware</title>
            <style>
                body {{
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    margin: 0;
                    padding: 0;
                    background-color: #f4f4f4;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #ffffff;
                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                }}
                .header {{
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 40px 30px;
                    text-align: center;
                }}
                .header h1 {{
                    margin: 0;
                    font-size: 28px;
                    font-weight: 700;
                }}
                .header p {{
                    margin: 10px 0 0 0;
                    font-size: 16px;
                    opacity: 0.9;
                }}
                .content {{
                    padding: 40px 30px;
                }}
                .alert-box {{
                    background-color: #fff3cd;
                    border: 1px solid #ffeaa7;
                    border-radius: 8px;
                    padding: 20px;
                    margin: 20px 0;
                }}
                .reset-button {{
                    display: inline-block;
                    background: linear-gradient(45deg, #ffd700, #ffed4e);
                    color: #1a1a1a;
                    padding: 15px 30px;
                    text-decoration: none;
                    border-radius: 50px;
                    font-weight: 600;
                    margin: 20px 0;
                    box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
                }}
                .code-box {{
                    background-color: #f8f9fa;
                    border: 2px solid #dee2e6;
                    border-radius: 8px;
                    padding: 15px;
                    margin: 20px 0;
                    text-align: center;
                    font-family: 'Courier New', monospace;
                    font-size: 18px;
                    font-weight: bold;
                    color: #495057;
                }}
                .footer {{
                    background-color: #2c3e50;
                    color: white;
                    padding: 30px;
                    text-align: center;
                }}
                .footer h4 {{
                    margin: 0 0 15px 0;
                    color: #ffd700;
                }}
                .disclaimer {{
                    font-size: 12px;
                    opacity: 0.6;
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 1px solid #444;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>🔐 ABZ Hardware</h1>
                    <p>Password Reset Request</p>
                </div>
                
                <div class="content">
                    <h2 style="color: #2c3e50; text-align: center;">Password Reset Request</h2>
                    
                    <p>Dear <strong>{user.firstname} {user.lastname}</strong>,</p>
                    
                    <p>We received a request to reset your password for your ABZ Hardware account. If you didn't make this request, you can safely ignore this email.</p>
                    
                    <div class="alert-box">
                        <h3 style="color: #856404; margin-top: 0;">⚠️ Security Notice</h3>
                        <p style="margin: 0;">This link will expire in 1 hour for your security.</p>
                    </div>
                    
                    <div style="text-align: center; margin: 30px 0;">
                        <a href="{reset_url}" class="reset-button">
                            🔑 Reset My Password
                        </a>
                    </div>
                    
                    <p><strong>Or copy this verification code:</strong></p>
                    <div class="code-box">
                        {reset_token[:8].upper()}
                    </div>
                    
                    <p><strong>What happens next?</strong></p>
                    <ul>
                        <li>Click the button above or use the verification code</li>
                        <li>You'll be taken to a secure page to set your new password</li>
                        <li>Your new password will be active immediately</li>
                        <li>You'll receive a confirmation email once the password is changed</li>
                    </ul>
                    
                    <p><strong>Need help?</strong> If you're having trouble, contact our support team.</p>
                </div>
                
                <div class="footer">
                    <h4>ABZ Hardware</h4>
                    <p>Your trusted partner for premium tools and equipment</p>
                    <div class="disclaimer">
                        <p>This is an automated security message. Please do not reply to this email.</p>
                        <p>If you didn't request this password reset, please contact us immediately.</p>
                    </div>
                </div>
            </div>
        </body>
        </html>
        """
    }
    try:
        print(f"🔍 Debug: Making API request to Brevo...")
        response = requests.post(url, headers=headers, json=data)
        print(f"🔍 Debug: Response status code: {response.status_code}")
        print(f"🔍 Debug: Response text: {response.text}")
        
        if response.status_code == 201:
            print(f"✅ Password reset email sent to {user.email}")
            return True
        else:
            print(f"❌ Failed to send password reset email to {user.email}: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Exception sending password reset email to {user.email}: {str(e)}")
        return False

def send_password_change_alert(user):
    """Send password change confirmation email using Brevo API"""
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
        "to": [{"email": user.email, "name": f"{user.firstname} {user.lastname}"}],
        "subject": "Password Changed Successfully - ABZ Hardware ✅",
        "htmlContent": f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Password Changed - ABZ Hardware</title>
            <style>
                body {{
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    margin: 0;
                    padding: 0;
                    background-color: #f4f4f4;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #ffffff;
                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                }}
                .header {{
                    background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
                    color: white;
                    padding: 40px 30px;
                    text-align: center;
                }}
                .header h1 {{
                    margin: 0;
                    font-size: 28px;
                    font-weight: 700;
                }}
                .header p {{
                    margin: 10px 0 0 0;
                    font-size: 16px;
                    opacity: 0.9;
                }}
                .content {{
                    padding: 40px 30px;
                }}
                .success-box {{
                    background-color: #d4edda;
                    border: 1px solid #c3e6cb;
                    border-radius: 8px;
                    padding: 20px;
                    margin: 20px 0;
                }}
                .info-box {{
                    background-color: #f8f9fa;
                    border-left: 4px solid #17a2b8;
                    padding: 20px;
                    margin: 25px 0;
                    border-radius: 5px;
                }}
                .cta-button {{
                    display: inline-block;
                    background: linear-gradient(45deg, #ffd700, #ffed4e);
                    color: #1a1a1a;
                    padding: 15px 30px;
                    text-decoration: none;
                    border-radius: 50px;
                    font-weight: 600;
                    margin: 20px 0;
                    box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
                }}
                .footer {{
                    background-color: #2c3e50;
                    color: white;
                    padding: 30px;
                    text-align: center;
                }}
                .footer h4 {{
                    margin: 0 0 15px 0;
                    color: #ffd700;
                }}
                .disclaimer {{
                    font-size: 12px;
                    opacity: 0.6;
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 1px solid #444;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>✅ ABZ Hardware</h1>
                    <p>Password Changed Successfully</p>
                </div>
                
                <div class="content">
                    <h2 style="color: #2c3e50; text-align: center;">Password Updated Successfully!</h2>
                    
                    <p>Dear <strong>{user.firstname} {user.lastname}</strong>,</p>
                    
                    <div class="success-box">
                        <h3 style="color: #155724; margin-top: 0;">🎉 Password Change Confirmed</h3>
                        <p style="margin: 0;">Your ABZ Hardware account password has been successfully updated.</p>
                    </div>
                    
                    <div class="info-box">
                        <h3 style="color: #2c3e50; margin-top: 0;">📋 Change Details</h3>
                        <p><strong>Account:</strong> {user.email}</p>
                        <p><strong>Changed At:</strong> {datetime.utcnow().strftime('%B %d, %Y at %I:%M %p UTC')}</p>
                        <p><strong>Status:</strong> ✅ Successfully Updated</p>
                    </div>
                    
                    <p><strong>What you should know:</strong></p>
                    <ul>
                        <li>Your new password is now active</li>
                        <li>You can log in with your new password immediately</li>
                        <li>All your account data and settings remain unchanged</li>
                        <li>If you didn't make this change, contact us immediately</li>
                    </ul>
                    
                    <div style="text-align: center; margin: 30px 0;">
                        <a href="http://localhost:5000/login" class="cta-button">
                            🔐 Login to Your Account
                        </a>
                    </div>
                    
                    <p><strong>Security Tips:</strong></p>
                    <ul>
                        <li>Use a strong, unique password</li>
                        <li>Never share your password with anyone</li>
                        <li>Log out from shared devices</li>
                        <li>Enable two-factor authentication if available</li>
                    </ul>
                </div>
                
                <div class="footer">
                    <h4>ABZ Hardware</h4>
                    <p>Your trusted partner for premium tools and equipment</p>
                    <div class="disclaimer">
                        <p>This is an automated security notification. Please do not reply to this email.</p>
                        <p>If you didn't change your password, contact our support team immediately.</p>
                    </div>
                </div>
            </div>
        </body>
        </html>
        """
    }
    try:
        response = requests.post(url, headers=headers, json=data)
        if response.status_code == 201:
            print(f"✅ Password change alert sent to {user.email}")
            return True
        else:
            print(f"❌ Failed to send password change alert to {user.email}: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Exception sending password change alert to {user.email}: {str(e)}")
        return False