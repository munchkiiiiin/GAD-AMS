@echo off
echo Starting CodeIgniter 4 Development Server...
cd /d "%~dp0backend"
php spark serve --host localhost --port 8080
pause
