#!/bin/bash

# Set Python path for AWS environment
export PYTHONPATH="/app:/app/deployment:$PYTHONPATH"

# Debugging information
echo "=== Directory Structure ==="
ls -al
echo "=== Python Path ==="
echo $PYTHONPATH
echo "=== Python Version ==="
python3.11 --version

# Django operations
python3.11 manage.py migrate --noinput
python3.11 manage.py collectstatic --noinput

# Start Gunicorn with explicit configuration
exec python3.11 -m gunicorn deployment.wsgi:application \
  --workers 2 \
  --bind 0.0.0.0:$PORT \
  --timeout 120 \
  --access-logfile -