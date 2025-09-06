# Use official Python image
FROM python:3.12-slim

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip config set global.cert /etc/ssl/certs/ca-certificates.crt || true
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Collect static files (optional)
RUN python manage.py collectstatic --noinput

# Run the app
CMD ["gunicorn", "cinema_service.wsgi:application", "--bind", "0.0.0.0:8000"]
