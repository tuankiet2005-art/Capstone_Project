# EIU Capstone Project

A full-stack web application featuring a modern React/Vite frontend and a secure Java Spring Boot backend, integrated with Google OAuth2 authentication restricted to official university domains.

---

## 🛠️ Tech Stack & Key Technologies

### Frontend
* **Core:** React, Vite
* **Styling:** TailwindCSS, PostCSS, Autoprefixer
* **Package Manager:** npm

### Backend
* **Core:** Java 17, Spring Boot 3.2.2
* **Build Tool:** Maven
* **Security:** Google OAuth 2.0 (Token Verification), JSON Web Tokens (JWT)

---

## 📋 Prerequisites

Before running the application, ensure you have the following installed on your machine:
* **Node.js** (v18 or higher recommended)
* **Java Development Kit (JDK) 17**
* **Apache Maven**
* A valid **Google OAuth Client ID**

---

## ⚙️ Initial Setup & Configuration

### 1. Root Configuration
From the project root directory, install the required orchestration dependencies (e.g., `concurrently`) to enable single-command execution:
```bash
npm install

```

### 2. Frontend Setup

Navigate into the frontend directory and install its specific packages (ensuring TailwindCSS and all dependencies are fully loaded):

```bash
cd frontend
npm install
cd ..

```

### 3. Backend Setup

1. Navigate into the backend directory:
```bash
cd backend

```


2. Copy the example environment file to create your active configuration:
```bash
cp .env.example .env

```


*(On Windows Command Prompt, use `copy .env.example .env`)*
3. Open the newly created `.env` file and configure the required variables:
* `GOOGLE_CLIENT_ID`: Your Google Developer Console client ID.
* `JWT_SECRET`: A secure, random string used to sign backend JWTs.
* `FRONTEND_URL`: Usually `http://localhost:5173`.


4. (Optional) Additional application configurations can be adjusted in `backend/src/main/resources/application.yml`.
5. Return to the root directory:
```bash
cd ..

```



---

## 🚀 Running the Application

You no longer need to open separate terminal windows to launch the frontend and backend manually. The project is pre-configured with `concurrently` to run both stacks simultaneously from the root folder.

Simply run the following command in the **root directory**:

```bash
npm start

```

* **Frontend Server:** Will be available at `http://localhost:5173/`
* **Backend Server:** Will be available at `http://localhost:8002/`

> 💡 **Note:** To stop both servers at any time, press `Ctrl + C` in your terminal.

---

## 🔑 Authentication Workflow & Behavior

1. **Token Sign-In:** The frontend prompts users to log in via Google, obtains a Google ID token, and sends it to the backend endpoint: `POST http://localhost:8002/api/auth/google`.
2. **Backend Verification:** The Spring Boot backend securely validates the incoming token using Google's verification API (`https://oauth2.googleapis.com/tokeninfo`).
3. **Domain Restriction:** The backend checks if `email_verified` is true and **strictly enforces** that the email address belongs to the allowed domain: `@eiu.edu.vn`.
4. **Session Issuance:** If valid, the backend issues a signed custom JWT (`accessToken`) with a 1-hour expiration time for subsequent authorized requests.

---

## 📂 Project Structure Overview

```text
capstone/
├── package.json             # Root configuration for running parallel scripts
├── README.md                # Main documentation file
├── frontend/                # React + Vite Client
│   ├── src/                 # Application source code
│   ├── postcss.config.js    # PostCSS & Tailwind styling configurations
│   └── package.json
└── backend/                 # Spring Boot Server
    ├── src/main/            # Java source files & application properties
    ├── .env                 # Local environment variables (Git ignored)
    └── pom.xml              # Maven dependencies

```

```

```