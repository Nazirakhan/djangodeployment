#!/bin/bash

# Run migrations
python3 manage.py migrate --noinput

# Collect static files
python3 manage.py collectstatic --noinput

# Start gunicorn explicitly using the Python module path
python3 -m gunicorn deployment.wsgi:application --workers 2 --bind 0.0.0.0:$PORT