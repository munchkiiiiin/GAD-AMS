# GAD_AMS - Setup Instructions

## Issues Fixed

1. **Missing Database Configuration**: Created `backend/app/Config/Database.php` with proper MySQL configuration pointing to `gad_submission_system` database
2. **Incorrect Backend API URLs**: Added deployment-aware API base handling so the frontend can target a Render backend instead of hardcoded localhost paths
3. **Database Name**: Updated `.env` file to use correct database name `gad_submission_system`

## How to Run

### 1. Start the Backend Server
Run the provided batch script:
```
START_BACKEND.bat
```

Or manually from command prompt:
```
cd backend
php spark serve --host localhost --port 8080
```

The backend will start on `http://localhost:8080`

### 2. Start the Frontend Development Server
In a separate terminal:
```
cd frontend
npm run dev
```

The frontend will typically start on `http://localhost:5173`

### 3. Access the Application
- Open your browser and navigate to the frontend URL (usually `http://localhost:5173`)
- Login with one of the test accounts in `users.sql`

## Database Setup
The `gad_submission_system` database must exist with the `users` table. Import the `users.sql` file if not already done:
```sql
mysql -u root < users.sql
```

## Test Credentials
- **Admin**: `Gender And Development` / password in users.sql
- **College**: `ca@bsu.edu.ph` / password in users.sql
- **GAD Staff**: `gad.staff@bsu.edu.ph` / password in users.sql

## Architecture
- **Backend**: CodeIgniter 4 REST API running on port 8080
- **Frontend**: Vue 3 with Vite running on port 5173
- **Database**: MySQL/MariaDB with `gad_submission_system` database

## Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for the Appwrite, Render, and Aiven configuration values.
