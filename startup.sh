#!/bin/bash

# Set Python path for AWS environment
export PYTHONPATH="/app:/app/deployment:$PYTHONPATH"

# Enhanced debugging information
echo "=== STARTING DEPLOYMENT ==="
echo "=== ULTIMATE DEBUGGING OUTPUT ==="

echo "1. Directory Structure:"
ls -al
echo -e "\n2. Python Path:"
echo $PYTHONPATH
echo -e "\n3. Python Version:"
python3.11 --version
echo -e "\n4. Installed Packages:"
python3.11 -m pip list
echo -e "\n5. Django Version Check:"
python3.11 -m django --version || echo "Django not found"

echo -e "\n=== EXECUTING DJANGO OPERATIONS ==="
# Django operations with error trapping
set -o errexit
python3.11 manage.py migrate --noinput
python3.11 manage.py collectstatic --noinput

echo -e "\n=== STARTING GUNICORN ==="
exec python3.11 -m gunicorn deployment.wsgi:application \
  --workers 2 \
  --bind 0.0.0.0:$PORT \
  --timeout 120 \
  --access-logfile - \
  --log-level debug