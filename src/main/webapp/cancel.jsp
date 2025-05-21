<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Webproject.Models.Bookinginfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="Retro.png">
    <title>RETROMOVIES - Cancel Your Ticket</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-dark: #1a1a1a; /* Very dark background */
            --accent-orange: #ff9800; /* Vibrant orange for highlights */
            --text-light: #f0f0f0; /* Off-white for general text */
            --card-bg: rgba(255, 255, 255, 0.95); /* Slightly transparent white for the form card */
            --cancel-button-bg: #e74c3c; /* Red for cancellation */
            --cancel-button-hover-bg: #c0392b; /* Darker red on hover */
            --input-border: #ccc;
            --input-focus-border: #2c3e50;
            --shadow-strong: rgba(0, 0, 0, 0.6);
            --shadow-medium: rgba(0, 0, 0, 0.3);
            --shadow-light: rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background-image: url("https://png.pngtree.com/background/20210710/original/pngtree-movie-ticket-cinema-promotion-banner-picture-image_1050764.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            background-attachment: fixed; /* Keep background fixed for a sleek look */
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            color: var(--text-light); /* Light text for better contrast on background */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5); /* Subtle shadow for readability */
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
            background-color: var(--cancel-button-bg);
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
            background-color: var(--cancel-button-hover-bg);
            transform: translateY(-2px);
        }

        /* --- Main Content Container (Form Card) --- */
        .container {
            background-color: var(--card-bg); /* Use semi-transparent white for modern look */
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 30px var(--shadow-medium);
            text-align: center;
            max-width: 500px; /* Adjust max-width for better form layout */
            margin-top: 80px; /* Space from navbar */
            animation: fadeIn 1s ease-out; /* Fade in animation */
            color: #333; /* Darker text for readability on white card */
            text-shadow: none; /* Remove text shadow for card content */
            border: 1px solid rgba(0,0,0,0.05); /* Subtle border */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-family: 'Montserrat', sans-serif;
            color: var(--primary-dark); /* Dark heading on light card */
            font-size: 2.5em;
            margin-bottom: 30px;
            font-weight: 700;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 25px; /* More space between form elements */
            width: 100%; /* Form takes full width of container */
        }

        label {
            font-size: 1.1em; /* Slightly larger label */
            margin-bottom: 5px;
            display: block;
            text-align: left;
            width: 100%;
            font-weight: 600; /* Bolder label */
            color: #555;
        }

        input[type="text"] {
            padding: 12px 15px; /* More padding */
            border: 1px solid var(--input-border);
            border-radius: 8px; /* More rounded */
            width: 100%;
            box-sizing: border-box;
            font-size: 1em;
            color: #333;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: var(--input-focus-border);
            box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.2);
        }

        button[type="submit"] {
            padding: 15px 30px; /* More padding */
            background-color: var(--cancel-button-bg);
            color: white;
            border: none;
            border-radius: 8px; /* More rounded */
            cursor: pointer;
            font-size: 1.2em; /* Larger text */
            font-weight: 600; /* Bolder */
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            width: 100%; /* Full width button */
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3); /* Shadow for depth */
        }

        button[type="submit"]:hover {
            background-color: var(--cancel-button-hover-bg);
            transform: translateY(-3px); /* Lift effect */
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.4);
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
            h2 { font-size: 2em; }
            input[type="text"] { padding: 10px; }
            button[type="submit"] { padding: 12px 24px; font-size: 1.1em; }
        }

        @media (max-width: 480px) {
            .container { padding: 20px; }
            h2 { font-size: 1.8em; }
            label { font-size: 1em; }
            button[type="submit"] { font-size: 1em; }
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
        <h2><i class="fas fa-ticket-alt"></i> Cancel Your Movie Tickets</h2>
        <form action="<%=request.getContextPath()%>/Cancel" method="get">
            <label for="bookingName">Booking Name:</label>
            <input type="text" id="bookingName" name="bookingName" placeholder="Enter the name used for booking" required>

            <label for="nameToDelete">Name to Delete:</label>
            <input type="text" id="nameToDelete" name="nameToDelete" placeholder="Enter the exact name to cancel" required>

            <button type="submit">Cancel Booking</button>
        </form>
    </div>

    <div class="footer">
        &copy; 2025 RETROMOVIES. All rights reserved.
    </div>
</body>
</html>