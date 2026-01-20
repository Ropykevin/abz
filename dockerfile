# Use the tiangolo/uwsgi-nginx-flask image with Python 3.9
FROM tiangolo/uwsgi-nginx-flask:python3.9

# Set environment variables to prevent Python from buffering outputs
ENV PYTHONUNBUFFERED=1

# Copy requirements.txt into a temporary location in the container
COPY requirements.txt /tmp/

# Upgrade pip and install Python packages listed in requirements.txt
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /tmp/requirements.txt

RUN pip install psycopg2-binary

# Copy over the Flask application code to the app directory in the container
# The tiangolo/uwsgi-nginx-flask image expects the app in /app
COPY main.py /app/main.py
COPY config /app/config
COPY routes /app/routes
COPY models /app/models
COPY helpers /app/helpers
COPY templates /app/templates
COPY static /app/static

# Copy .env file 
COPY .env /app/.env