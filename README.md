# Team Task Manager

A full-stack Team Task Manager application with a Flask REST API backend and React frontend featuring a Kanban-style board for managing tasks.

## Tech Stack

### Frontend
- React 18 with TypeScript
- Vite for build tooling
- Tailwind CSS for styling
- Lucide React for icons
- React Router for navigation and protected routes

### Backend
- Python Flask REST API
- Flask-SQLAlchemy for database ORM
- Flask-CORS for cross-origin requests
- PyJWT for JWT authentication
- PostgreSQL database

## Project Structure

```
team-task-manager/
├── frontend/                 # React frontend (Vite)
│   ├── src/
│   │   ├── components/      # React components
│   │   ├── services/        # API service layer
│   │   ├── types/          # TypeScript types
│   │   └── App.tsx         # Main app component
│   ├── package.json
│   └── vite.config.ts
├── backend/                 # Flask backend
│   ├── app/
│   │   ├── __init__.py     # Application factory
│   │   ├── models.py       # SQLAlchemy models
│   │   └── routes.py       # API endpoints
│   ├── requirements.txt
│   ├── schema.sql          # Database schema
│   └── run.py             # Application entry point
└── README.md
```

## Features

- Kanban-style dashboard with 3 columns (To Do, In Progress, Done)
- Drag and drop tasks between columns
- Create, read, update, and delete tasks
- Task priorities (low, medium, high)
- Responsive design for mobile and desktop
- RESTful API architecture with JWT authentication
- Login/logout functionality with persisted sessions
- Protected routes that require authentication
- Pre-seeded demo users for testing

## Prerequisites

- Python 3.8 or higher
- Node.js 16 or higher
- npm or yarn
- PostgreSQL 12 or higher

## Setup Instructions

### 1. Database Setup

First, ensure PostgreSQL is installed and running on your system.

Create a new PostgreSQL database:

```bash
psql -U postgres
CREATE DATABASE taskmanager;
\q
```

Initialize the database schema:

```bash
psql -U postgres -d taskmanager -f backend/schema.sql
```

This will create the tasks table and insert sample data.

### 2. Backend Setup

Navigate to the backend directory:

```bash
cd backend
```

Create a Python virtual environment:

```bash
python3 -m venv venv
```

Activate the virtual environment:

**On macOS/Linux:**
```bash
source venv/bin/activate
```

**On Windows:**
```bash
venv\Scripts\activate
```

Install Python dependencies:

```bash
pip install -r requirements.txt
```

Create a `.env` file in the backend directory:

```bash
cp .env.example .env
```

Edit the `.env` file and update the database connection string:

```
DATABASE_URL=postgresql://your_username:your_password@localhost/taskmanager
PORT=5000
FLASK_ENV=development
```

Run the Flask application:

```bash
python run.py
```

The backend API will be available at `http://localhost:5000`

### 3. Frontend Setup

Open a new terminal window and navigate to the project root directory.

Install frontend dependencies:

```bash
npm install
```

Create a `.env` file in the root directory:

```bash
cp .env.example .env
```

The default configuration should work:

```
VITE_API_URL=http://localhost:5000/api
```

Run the development server:

```bash
npm run dev
```

The frontend will be available at `http://localhost:5173`

## API Endpoints

### Authentication

- **POST** `/api/auth/login` - Login with username and password
  - Request: `{ "username": "admin", "password": "admin123" }`
  - Response: `{ "token": "jwt_token", "user": { "id": 1, "username": "admin" } }`

### Tasks (Protected - Requires Authorization Header)

All task endpoints require an `Authorization: Bearer <token>` header.

- **GET** `/api/tasks` - Get all tasks
- **POST** `/api/tasks` - Create a new task
- **PUT** `/api/tasks/:id` - Update a task
- **DELETE** `/api/tasks/:id` - Delete a task

### Task Schema

```json
{
  "id": 1,
  "title": "Task title",
  "description": "Task description",
  "priority": "low | medium | high",
  "status": "todo | in_progress | done",
  "created_at": "2024-01-01T00:00:00",
  "updated_at": "2024-01-01T00:00:00"
}
```

## Building for Production

### Frontend

Build the frontend for production:

```bash
npm run build
```

This creates optimized static files in the `dist/` directory that can be:
- Served by Flask using `flask.send_from_directory()`
- Deployed to any static hosting service (Netlify, Vercel, etc.)
- Served by any web server (Nginx, Apache, etc.)

Preview the production build:

```bash
npm run preview
```

### Backend

For production deployment:

1. Set `FLASK_ENV=production` in your environment
2. Use a production WSGI server like Gunicorn:

```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 'app:create_app()'
```

## Authentication

### Login Flow

1. Navigate to the landing page at `http://localhost:5173`
2. Click "Get Started" to go to the login page
3. Use demo credentials:
   - **Admin account:** username: `admin`, password: `admin123`
   - **User account:** username: `user`, password: `user123`
4. Upon successful login, you'll be redirected to the dashboard
5. The auth token is stored in `localStorage` and persists across page refreshes
6. Click "Logout" to clear the session

### JWT Token

- Tokens are valid for the session and stored in localStorage
- Tokens are automatically included in all API requests via the Authorization header
- Invalid or expired tokens will redirect you to the login page

## Development Workflow

1. Start PostgreSQL database
2. Run backend: `cd backend && source venv/bin/activate && python run.py`
3. Run frontend: `npm run dev`
4. Access the application at `http://localhost:5173`
5. Use demo credentials to login and manage tasks

## Database Management

### Reset Database

To reset the database and reload sample data:

```bash
psql -U postgres -d taskmanager -f backend/schema.sql
```

### Backup Database

```bash
pg_dump -U postgres taskmanager > backup.sql
```

### Restore Database

```bash
psql -U postgres taskmanager < backup.sql
```

## Troubleshooting

### Backend Issues

**Issue:** `ModuleNotFoundError: No module named 'flask'`
- Solution: Make sure you've activated the virtual environment and installed requirements

**Issue:** `sqlalchemy.exc.OperationalError: could not connect to server`
- Solution: Ensure PostgreSQL is running and connection details in `.env` are correct

**Issue:** `CORS errors in browser`
- Solution: Verify Flask-CORS is installed and the backend is running

### Frontend Issues

**Issue:** `Failed to fetch tasks`
- Solution: Check that the backend is running on port 5000 and VITE_API_URL is correct

**Issue:** Redirect to login when accessing dashboard
- Solution: Make sure you've logged in with valid credentials. Check that the token is stored in localStorage.

**Issue:** `Unauthorized` error on API calls
- Solution: The token may have expired. Try logging out and logging back in.

**Issue:** Build errors
- Solution: Delete `node_modules` and `package-lock.json`, then run `npm install` again

### Authentication Issues

**Issue:** `Invalid username or password`
- Solution: Use the correct demo credentials. The default accounts are `admin/admin123` and `user/user123`

**Issue:** Forgot password?
- Solution: This demo application doesn't have a password reset feature. Contact an administrator to reset your password or edit the database directly.

## License

MIT License - feel free to use this project for learning and development purposes.

## Contributing

This is a learning project demonstrating full-stack development with Flask and React. Feel free to fork and modify for your own use.
