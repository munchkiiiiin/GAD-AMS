# Deployment

## Target stack

- Frontend: Appwrite static site hosting
- Backend: Render web service
- Database: Aiven MySQL
- File storage: Appwrite storage bucket or another public file origin

## Frontend env

Set these in the Appwrite-hosted frontend build:

- `VITE_API_BASE_URL=https://your-render-service.onrender.com`
- `VITE_UPLOAD_BASE_URL=https://your-public-file-origin`

If you are using an Appwrite storage bucket with public file URLs, point `VITE_UPLOAD_BASE_URL` to that public bucket origin.

### Appwrite Git Deployment Settings

When deploying the frontend from your GitHub repository, you must specify the folder containing the frontend application in the Appwrite Console under **Settings** / **Build Settings**:

1. **Root Directory**: Change this from `.` to `frontend` (this ensures Appwrite runs build commands inside the folder containing `package.json`).
2. **Build Command**: `npm run build` (or `npm install && npm run build`)
3. **Output / Publish Directory**: `dist` (Vite's default build output folder)

## Backend Deployment (Render Web Service)

Since Render does not have a native PHP runtime, we package the backend as a Docker container.

### 1. Create a Render Web Service
1. In the Render Dashboard, click **New +** and select **Web Service**.
2. Connect your GitHub repository (`munchkiiiiin/GAD-AMS`).
3. Set the following basic settings:
   - **Name**: `gad-ams-backend` (or any custom name)
   - **Root Directory**: `backend` (This is critical: it points Render to the folder containing the `Dockerfile` and CodeIgniter files).
   - **Language**: `Docker` (Render will automatically detect the `Dockerfile` inside the `backend` directory).
   - **Branch**: `main`

### 2. Configure Environment Variables
In your Render Service settings, navigate to **Environment** and add the following keys:

#### Core PHP / CodeIgniter Settings:
- `CI_ENVIRONMENT` = `production`
- `app.baseURL` = `https://your-render-service-url.onrender.com/` (Update this with your actual Render service URL)
- `app.frontendURL` = `https://your-frontend-appwrite-host-or-custom-domain` (The origin URL of your deployed Appwrite frontend)

#### Aiven MySQL Database Settings:
- `database.default.hostname` = `your-aiven-mysql-host`
- `database.default.database` = `your-aiven-database-name`
- `database.default.username` = `your-aiven-username`
- `database.default.password` = `your-aiven-password`
- `database.default.port` = `your-aiven-port`
- `database.default.DBDriver` = `MySQLi`
- `database.default.encrypt` = `true` *(Enables SSL required to connect securely to Aiven)*

#### Appwrite Storage Settings:
If using Appwrite for storage buckets (highly recommended so you don't lose files when the Render container restarts):
- `appwrite.endpoint` = `https://cloud.appwrite.io/v1` *(or your custom endpoint)*
- `appwrite.projectId` = `your-appwrite-project-id`
- `appwrite.apiKey` = `your-appwrite-api-key-with-bucket-scopes`
- `appwrite.bucketId` = `your-appwrite-bucket-id`

*If Appwrite Storage environment variables are not supplied, the backend will fallback to writing attachments locally under `/var/www/html/public/uploads`.*

## Notes

- The frontend now reads its API origin from the global `VITE_API_BASE_URL` environment variable.
- The backend CORS headers now dynamically read the allowed frontend origin from `app.frontendURL`.
- Make sure that the Appwrite Storage bucket permissions are set to allow **Read** access for **`Any`** or **`guests`** so that the frontend can load file previews correctly.

