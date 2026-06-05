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

## Backend env

Set these in Render:

- `CI_ENVIRONMENT=production`
- `app.baseURL=https://your-render-service.onrender.com/`
- `app.frontendURL=https://your-appwrite-host-or-custom-domain`
- `app.uploadPath=/var/data/uploads`
- `database.default.hostname=your-aiven-host`
- `database.default.database=your-aiven-database`
- `database.default.username=your-aiven-username`
- `database.default.password=your-aiven-password`
- `database.default.port=your-aiven-port`
- `database.default.DBDriver=MySQLi`

## Notes

- The frontend now reads its API origin from `VITE_API_BASE_URL`.
- The backend CORS headers now read the allowed frontend origin from `app.frontendURL`.
- The backend still writes attachments to the configured upload path. If you want direct Appwrite bucket uploads, the upload flow in the backend still needs to be wired to the Appwrite storage API.
