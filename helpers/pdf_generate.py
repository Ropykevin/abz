# Helper functions for PDF generation
def format_currency(amount):
    """Format currency for PDFs"""
    return f"KSh {amount:,.2f}"

def format_quantity(quantity):
    """Format quantity for PDFs - remove unnecessary decimal places"""
    if quantity is None:
        return "0"
    qty = float(quantity)
    if qty == int(qty):
        return str(int(qty))
    return f"{qty:.2f}".rstrip('0').rstrip('.')

def create_delivery_note_pdf_a4(order, user_data, output_path):
    """
    Create a professional delivery note PDF (A4 size)
    output_path can be a file path (string) or BytesIO object
    """
    from reportlab.lib.pagesizes import A4
    from reportlab.lib import colors
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, Image
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import inch
    from datetime import datetime
    import pytz
    
    # Set timezone to East Africa Time
    EAT = pytz.timezone('Africa/Nairobi')
    
    # Create PDF buffer
    if isinstance(output_path, str):
        # If output_path is a string, create a file
        doc = SimpleDocTemplate(output_path, pagesize=A4, rightMargin=50, leftMargin=50, topMargin=50, bottomMargin=50)
    else:
        # If output_path is BytesIO, use it directly
        doc = SimpleDocTemplate(output_path, pagesize=A4, rightMargin=50, leftMargin=50, topMargin=50, bottomMargin=50)
    
    # Container for the 'Flowable' objects
    elements = []
    
    # Define styles
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=24,
        spaceAfter=30,
        alignment=1,  # Center alignment
        textColor=colors.HexColor('#2c3e50')
    )
    
    heading_style = ParagraphStyle(
        'CustomHeading',
        parent=styles['Heading2'],
        fontSize=16,
        spaceAfter=20,
        textColor=colors.HexColor('#34495e')
    )
    
    normal_style = ParagraphStyle(
        'CustomNormal',
        parent=styles['Normal'],
        fontSize=11,
        spaceAfter=12
    )
    
    # Recreate the ABZ Hardware letterhead manually
    
    # Try to load the logo for the left side
    try:
        logo_path = os.path.join(os.path.dirname(__file__), 'static', 'logo.png')
        if os.path.exists(logo_path):
            logo_image = Image(logo_path, width=1.5*inch, height=1*inch)
            logo_cell = logo_image
        else:
            # Fallback to text if logo not found
            logo_cell = Paragraph('''
            <para align=left>
            <b><font size=24 color="#1a365d">🔧ABZ</font></b><br/>
            <b><font size=16 color="#f4b942">HARDWARE</font></b><br/>
            <b><font size=14 color="#1a365d">LIMITED</font></b>
            </para>
            ''', normal_style)
    except Exception as e:
        print(f"Error loading logo: {e}")
        # Fallback to text if logo fails to load
        logo_cell = Paragraph('''
        <para align=left>
        <b><font size=24 color="#1a365d">🔧ABZ</font></b><br/>
        <b><font size=16 color="#f4b942">HARDWARE</font></b><br/>
        <b><font size=14 color="#1a365d">LIMITED</font></b>
        </para>
        ''', normal_style)
    
    # Create the letterhead table for proper layout
    letterhead_data = [[
        # Left side - Logo Image
        logo_cell,
        
        # Right side - Contact Information
        Paragraph('''
        <para align=right>
        <b><font size=11 color="#1a365d">Kombo Munyiri Road,</font></b><br/>
        <b><font size=11 color="#1a365d">Gikomba, Nairobi, Kenya</font></b><br/>
        <font size=9 color="#666666">0711 732 341 or 0725 000 055</font><br/>
        <font size=9 color="#666666">info@abzhardware.co.ke</font><br/>
        <font size=9 color="#666666">www.abzhardware.co.ke</font>
        </para>
        ''', normal_style)
    ]]
    
    # Create letterhead table
    letterhead_table = Table(letterhead_data, colWidths=[3.5*inch, 3.5*inch])
    letterhead_table.setStyle(TableStyle([
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('LEFTPADDING', (0, 0), (0, 0), 0),
        ('RIGHTPADDING', (1, 0), (1, 0), 0),
    ]))
    
    elements.append(letterhead_table)
    elements.append(Spacer(1, 10))
    
    # Add the colored line separator (yellow)
    separator_data = [[""]]
    separator_table = Table(separator_data, colWidths=[7*inch], rowHeights=[0.05*inch])
    separator_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (0, 0), colors.HexColor('#f4b942')),  # Yellow color
    ]))
    
    elements.append(separator_table)
    elements.append(Spacer(1, 30))
    
    # Delivery Note Title
    elements.append(Paragraph("DELIVERY NOTE", title_style))
    elements.append(Spacer(1, 10))
    
    # Delivery Note Details Section
    delivery_note_details = f"""
    <b>Delivery Note Number:</b> DN-{order.id:06d}<br/>
    <b>Order Number:</b> ORD-{order.id:06d}<br/>
    <b>Date:</b> {order.created_at.strftime('%B %d, %Y') if order.created_at else 'N/A'}<br/>
    <b>Branch:</b> {order.branch.name if order.branch else 'N/A'}<br/>
    """
    elements.append(Paragraph(delivery_note_details, normal_style))
    elements.append(Spacer(1, 20))
    
    # Items Table
    if order.order_items:
        elements.append(Paragraph("ITEMS FOR DELIVERY", heading_style))
        
        # Table data - No, Product Name - Code, Quantity
        data = [['No', 'Product Name', 'Quantity']]
        
        # Create a style for product names that allows wrapping
        product_name_style = ParagraphStyle(
            'ProductName',
            parent=styles['Normal'],
            fontSize=11,
            spaceAfter=0,
            spaceBefore=0,
            leading=13,  # Line spacing for multi-line text
            alignment=0,  # Left alignment
            fontName='Helvetica'
        )
        
        for idx, item in enumerate(order.order_items, 1):
            # Get product name
            if item.product_name:
                product_name = item.product_name
            elif item.branch_product and item.branch_product.catalog_product:
                product_name = item.branch_product.catalog_product.name
            else:
                product_name = 'N/A'
            
            # Get product code
            product_code = ''
            if item.branch_product and item.branch_product.catalog_product:
                product_code = item.branch_product.catalog_product.productcode or ''
            
            # Combine product name and code
            if product_code:
                product_display = f"{product_name} - {product_code}"
            else:
                product_display = product_name
            
            quantity = item.quantity
            
            # Format quantity
            quantity_text = format_quantity(quantity)
            
            data.append([
                str(idx),
                Paragraph(product_display.upper(), product_name_style),
                quantity_text
            ])
        
        # Create table with 3 columns
        table = Table(data, colWidths=[0.6*inch, 5.4*inch, 1*inch])
        table.setStyle(TableStyle([
            # Header row
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#1a365d')),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, 0), 12),
            
            # Data rows
            ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
            ('FONTSIZE', (0, 1), (-1, -1), 11),
            ('GRID', (0, 0), (-1, -1), 1, colors.HexColor('#4a5568')),
            
            # Alternating row colors
            ('BACKGROUND', (0, 1), (-1, -1), colors.HexColor('#f7fafc')),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.HexColor('#f7fafc'), colors.white]),
            
            # Alignment adjustments
            ('ALIGN', (0, 1), (0, -1), 'CENTER'),  # No column center
            ('ALIGN', (1, 1), (1, -1), 'LEFT'),    # Product Name left
            ('ALIGN', (2, 1), (2, -1), 'CENTER'),  # Quantity center
            
            # Padding
            ('TOPPADDING', (0, 0), (-1, -1), 8),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
        ]))
        
        elements.append(table)
        elements.append(Spacer(1, 30))
    else:
        elements.append(Paragraph("No items in this delivery note.", normal_style))
        elements.append(Spacer(1, 30))
    
    # Signature Section
    elements.append(Spacer(1, 50))
    
    signature_data = [
        ['Prepared By:', 'Received By:'],
        ['', ''],
        ['', ''],
        [f'Name: {user_data.firstname} {user_data.lastname}', 'Name: _______________________'],
        [f'Date: {datetime.now(EAT).strftime("%B %d, %Y")}', 'Date: _______________________'],
        ['Signature: _______________________', 'Signature: _______________________']
    ]
    
    signature_table = Table(signature_data, colWidths=[3.5*inch, 3.5*inch])
    signature_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 11),
        ('TOPPADDING', (0, 0), (-1, -1), 6),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
        ('LINEABOVE', (0, 0), (-1, 0), 1, colors.HexColor('#cbd5e0')),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
    ]))
    
    elements.append(signature_table)
    elements.append(Spacer(1, 20))
    
    # Footer
    footer_text = f"""
    <para align=center>
    <font size=8 color="#95a5a6">
    Generated on {datetime.now(EAT).strftime('%B %d, %Y at %I:%M %p')} by {user_data.firstname} {user_data.lastname}<br/>
    This is a computer-generated document and does not require a signature.<br/>
    Please inspect all items upon delivery. Report any discrepancies immediately.
    </font>
    </para>
    """
    elements.append(Spacer(1, 30))
    elements.append(Paragraph(footer_text, normal_style))
    
    # Build PDF
    doc.build(elements)
    
    return output_path