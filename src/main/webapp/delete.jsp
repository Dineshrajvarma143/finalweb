<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="Retro.png">
    <title>RETROMOVIES - Ticket Cancellation</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-dark: #1a1a1a; /* Very dark background */
            --accent-orange: #ff9800; /* Vibrant orange for highlights */
            --text-light: #f0f0f0; /* Off-white for general text */
            --card-bg: #ffffff; /* White background for the success message card */
            --danger-red: #e74c3c; /* Red for cancellation/error */
            --success-green: #2ecc71; /* Green for success */
            --info-blue: #3498db; /* Blue for general buttons */
            --shadow-strong: rgba(0, 0, 0, 0.6);
            --shadow-medium: rgba(0, 0, 0, 0.2);
            --shadow-light: rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f4f4f4; /* A light background for the page */
            background-image: linear-gradient(to bottom right, #f8f8f8, #e0e0e0); /* Subtle gradient */
            display: flex;
            flex-direction: column; /* Stack elements vertically */
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-color);
            box-sizing: border-box;
        }

        /* --- Navbar & Header --- */
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
            justify-content: space-between; /* Space out brand and links */
            align-items: center;
            max-width: 1200px; /* Limit navbar width */
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
            color: #ffa726; /* Slightly lighter orange on hover */
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

        .logout-button {
            background-color: var(--danger-red);
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

        .logout-button:hover {
            background-color: #c0392b; /* Darker red on hover */
            transform: translateY(-2px);
        }

        /* --- Main Content Container --- */
        .container {
            background-color: var(--card-bg);
            padding: 50px; /* More padding */
            border-radius: 15px; /* More rounded */
            box-shadow: 0 10px 30px var(--shadow-medium); /* Stronger shadow */
            text-align: center;
            max-width: 600px; /* Max width for better readability */
            margin-top: 80px; /* Space from navbar */
            animation: fadeIn 1s ease-out; /* Fade in animation */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-family: 'Montserrat', sans-serif;
            color: var(--danger-red);
            font-size: 2.8em; /* Larger title */
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
        }

        p {
            font-size: 1.15em; /* Slightly smaller, more readable */
            line-height: 1.6;
            margin-bottom: 30px;
            color: #555;
        }

        .icon {
            font-size: 5em; /* Larger icon */
            color: var(--danger-red);
            margin-bottom: 25px;
            animation: pulse 1.5s infinite alternate;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.8; }
            100% { transform: scale(1.1); opacity: 1; }
        }

        .button {
            display: inline-block;
            padding: 15px 30px; /* More padding */
            background-color: var(--info-blue);
            color: white;
            text-decoration: none;
            border-radius: 8px; /* More rounded */
            font-weight: 600; /* Bolder text */
            font-size: 1.1em;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3); /* Shadow for depth */
        }

        .button:hover {
            background-color: #2980b9;
            transform: translateY(-3px); /* Lift effect */
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
            margin-top: auto; /* Pushes footer to the bottom */
            box-shadow: 0 -2px 10px var(--shadow-strong);
        }

        /* --- Responsive Adjustments --- */
        @media (max-width: 768px) {
            .navbar { flex-direction: column; gap: 1rem; padding: 1rem; }
            .nav-links { width: 100%; justify-content: center; flex-wrap: wrap; gap: 1rem;}
            .navbar-brand { margin-bottom: 0.5rem; font-size: 1.8rem; }
            .navbar a { padding: 10px 15px; font-size: 0.9em; }
            .container { padding: 30px; margin-top: 40px; }
            h1 { font-size: 2em; }
            p { font-size: 1em; }
            .icon { font-size: 4em; }
            .button { padding: 10px 20px; font-size: 1em; }
        }

        @media (max-width: 480px) {
            .container { padding: 20px; }
            h1 { font-size: 1.8em; }
            p { font-size: 0.9em; }
            .icon { font-size: 3.5em; }
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
                <form action="login.jsp" method="post" style="display: inline;">
                    <button type="submit" class="logout-button">Logout</button>
                </form>
            </div>
        </div>
    </div>

    <div class="container">
        <i class="fas fa-times-circle icon"></i>
        <h1>Ticket Cancellation Successful!</h1>
        <p>Your ticket has been successfully cancelled. We're sorry you won't be able to make it to the show.</p>
        <a href="home.jsp" class="button">Return to Home</a>
    </div>

    <div class="footer">
        &copy; 2025 RETROMOVIES. All rights reserved.
    </div>
</body>
</html>