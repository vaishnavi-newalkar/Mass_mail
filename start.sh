#!/usr/bin/env bash
set -e

echo "Starting Celery Beat and Worker in background..."
celery -A email_automation worker -l info -B --scheduler django_celery_beat.schedulers:DatabaseScheduler &

echo "Starting Gunicorn Web Server..."
exec gunicorn email_automation.wsgi:application --bind 0.0.0.0:$PORT
