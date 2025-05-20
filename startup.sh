#!/bin/bash

# Run migrations (optional but useful)
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start gunicorn with proper host and port binding
gunicorn deployment.wsgi:application --workers 2 --bind 0.0.0.0:$PORT
