<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="Retro.png">
<title>RETROMOVIES - Login</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    :root {
        --primary-dark: #1a1a1a; /* Very dark background */
        --accent-orange: #ff9800; /* Vibrant orange for highlights */
        --text-light: #f0f0f0; /* Off-white for general text */
        --form-bg: rgba(255, 255, 255, 0.95); /* Slightly transparent white for the form card */
        --login-button-bg: #2ecc71; /* Green for login button */
        --login-button-hover-bg: #27ae60; /* Darker green on hover */
        --register-button-bg: #3498db; /* Blue for register button */
        --register-button-hover-bg: #2980b9; /* Darker blue on hover */
        --input-border: #ccc;
        --input-focus-border: #2c3e50; /* Dark blue/gray for focus */
        --shadow-strong: rgba(0, 0, 0, 0.6);
        --shadow-medium: rgba(0, 0, 0, 0.3);
        --shadow-light: rgba(0, 0, 0, 0.1);
    }

    body {
        margin: 0;
        font-family: 'Open Sans', sans-serif;
        /* New background image for a modern, cinematic feel */
        background-image: url("pexels-adrien-olichon-1257089-3709369.jpg");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
        color: var(--text-light); /* Light text for contrast on dark background */
        text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7); /* Stronger text shadow for readability */
        box-sizing: border-box;
    }

    /* --- Navbar & Header (New addition for consistency) --- */
    .header-container {
        width: 100%;
        background-color: var(--primary-dark);
        box-shadow: 0 2px 10px var(--shadow-strong);
        position: sticky;
        top: 0;
        z-index: 1000;
        padding: 1rem 0;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
    }

    .navbar-brand {
        font-family: 'Montserrat', sans-serif;
        color: var(--accent-orange);
        font-size: 2.2rem;
        font-weight: 700;
        text-decoration: none;
        letter-spacing: 1.5px;
        transition: color 0.3s ease;
    }

    .navbar-brand:hover {
        color: #ffa726;
    }

    .nav-links {
        display: flex;
        gap: 2rem;
    }

    .navbar a {
        color: var(--text-light);
        text-decoration: none;
        font-weight: 600;
        font-size: 1.1rem;
        transition: color 0.3s ease;
        padding: 0.5rem 0;
    }

    .navbar a:hover {
        color: var(--accent-orange);
    }

    .register-button-nav { /* Specific style for register button in nav */
        background-color: var(--register-button-bg);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1em;
        font-weight: 600;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    .register-button-nav:hover {
        background-color: var(--register-button-hover-bg);
        transform: translateY(-2px);
    }

    /* --- Page Introduction --- */
    .page-intro {
        margin: 50px auto 30px;
        width: 90%;
        max-width: 800px;
        color: white;
        padding: 20px;
        text-align: center;
        font-size: 1.8rem;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.8);
        background-color: rgba(0, 0, 0, 0.7);
        border-radius: 12px;
        box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.6);
        font-family: 'Montserrat', sans-serif;
        font-weight: 600;
        animation: fadeInDown 1s ease-out;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* --- Form Styling --- */
    .form-container {
        width: 90%;
        max-width: 450px;
        margin: 0 auto;
        background-color: var(--form-bg);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0px 0px 20px var(--shadow-medium);
        color: #333;
        text-shadow: none;
        animation: fadeInUp 1s ease-out;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .form-container h1 {
        text-align: center;
        color: var(--primary-dark);
        margin-bottom: 25px;
        font-family: 'Montserrat', sans-serif;
        font-size: 2.2rem;
        font-weight: 700;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-size: 1.1em;
        font-weight: 600;
        color: #555;
    }

    .form-group input {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid var(--input-border);
        border-radius: 8px;
        font-size: 1em;
        background-color: white;
        color: #333;
        box-sizing: border-box;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .form-group input:focus {
        outline: none;
        border-color: var(--input-focus-border);
        box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.2);
    }

    button[type="submit"] {
        width: 100%;
        padding: 15px;
        background-color: var(--login-button-bg);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 1.15rem;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        box-shadow: 0 4px 12px rgba(46, 204, 113, 0.4);
        margin-top: 10px;
    }

    button[type="submit"]:hover {
        background-color: var(--login-button-hover-bg);
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(46, 204, 113, 0.6);
    }

    .form-footer { /* For the register button below login */
        margin-top: 25px;
        text-align: center;
    }

    .form-footer p {
        color: #555;
        font-size: 0.95em;
        margin-bottom: 15px;
    }

    .form-footer a {
        display: inline-block;
        padding: 12px 25px;
        background-color: var(--register-button-bg);
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 1em;
        transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3);
    }

    .form-footer a:hover {
        background-color: var(--register-button-hover-bg);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(52, 152, 219, 0.4);
    }

    /* --- Footer --- */
    .footer {
        width: 100%;
        background-color: var(--primary-dark);
        color: var(--text-light);
        text-align: center;
        padding: 20px 0;
        font-size: 0.9em;
        margin-top: auto;
        box-shadow: 0 -2px 10px var(--shadow-strong);
    }

    /* --- Responsive Adjustments --- */
    @media (max-width: 768px) {
        .navbar { flex-direction: column; gap: 1rem; padding: 1rem; }
        .nav-links { width: 100%; justify-content: center; flex-wrap: wrap; gap: 1rem;}
        .navbar-brand { margin-bottom: 0.5rem; font-size: 1.8rem; }
        .navbar a { padding: 10px 15px; font-size: 0.9em; }
        .page-intro { font-size: 1.4rem; margin-top: 30px; padding: 15px; }
        .form-container { padding: 30px; margin-top: 40px; }
        .form-container h1 { font-size: 1.8rem; }
        .form-group label { font-size: 1em; }
        .form-group input { padding: 10px; }
        button[type="submit"] { padding: 12px; font-size: 1.05rem; }
        .form-footer a { padding: 10px 20px; font-size: 0.95em; }
    }

    @media (max-width: 480px) {
        .page-intro { font-size: 1.2rem; }
        .form-container { padding: 20px; }
        .form-container h1 { font-size: 1.6rem; }
        .form-group input { font-size: 0.9em; }
        button[type="submit"] { font-size: 1rem; }
    }
</style>
</head>
<body>
    <div class="header-container">
        <div class="navbar">
            <a href="home.jsp" class="navbar-brand">RETROMOVIES</a>
            <div class="nav-links">
                <a href="home.jsp">Home</a>
                <a href="cancel.jsp">Cancel Tickets</a>
                <a href="register.jsp" class="register-button-nav">Register</a>
            </div>
        </div>
    </div>

    <h1 class="page-intro">Welcome back, movie lover! Log in to continue your cinematic journey.</h1>

    <div class="form-container">
        <form action="<%=request.getContextPath()%>/Login" method="post">
            <h1><i class="fas fa-sign-in-alt"></i> Login to Your Account</h1>
            <div class="form-group">
                <label for="lemail">Email:</label>
                <input type="email" name="lemail" id="lemail" placeholder="Enter your email..." required>
            </div>
            <div class="form-group">
                <label for="pass">Password:</label>
                <input type="password" name="pass" id="pass" placeholder="Enter your password..." required>
            </div>
            <button type="submit">Login</button>
        </form>

        <div class="form-footer">
            <p>Don't have an account?</p>
            <a href="register.jsp">Register Now</a>
        </div>
    </div>

    <div class="footer">
        &copy; 2025 RETROMOVIES. All rights reserved.
    </div>
</body>
</html>