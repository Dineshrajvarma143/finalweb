<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Webproject.Models.Bookinginfo" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="Retro.png">
    <title>RETROMOVIES - Your Ticket Confirmed!</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-dark: #1a1a1a; /* Very dark background */
            --accent-orange: #ff9800; /* Vibrant orange for highlights */
            --text-light: #f0f0f0; /* Off-white for general text */
            --card-bg: #ffffff; /* White background for the ticket card */
            --ticket-border: #4CAF50; /* Green for success border */
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
            color: #333;
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
            background-color: #e74c3c; /* Red for logout */
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

        /* --- Main Content --- */
        h2.page-heading {
            font-family: 'Montserrat', sans-serif;
            text-align: center;
            color: var(--primary-dark);
            font-size: 2.8em;
            margin-top: 50px;
            margin-bottom: 30px;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
        }

        .ticket-card {
            width: 90%; /* Responsive width */
            max-width: 500px; /* Max width for larger screens */
            margin: 40px auto;
            padding: 30px; /* More padding */
            background: var(--card-bg);
            border-radius: 15px; /* More rounded */
            box-shadow: 0 10px 30px var(--shadow-medium); /* Stronger shadow */
            border-left: 10px solid var(--ticket-border); /* Thicker border */
            text-align: left; /* Align text left within the card */
            animation: fadeInScale 0.8s ease-out forwards; /* Animation for card */
            opacity: 0; /* Start hidden */
            transform: scale(0.95); /* Start slightly smaller */
        }

        @keyframes fadeInScale {
            to { opacity: 1; transform: scale(1); }
        }

        .ticket-card h3 {
            font-family: 'Montserrat', sans-serif;
            margin-top: 0;
            color: var(--ticket-border);
            font-size: 1.8em; /* Larger title */
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px; /* Space between icon and text */
        }

        .ticket-card h3 .icon {
            font-size: 1em; /* Adjust icon size relative to text */
            color: var(--ticket-border);
        }

        .ticket-detail {
            margin: 15px 0; /* More spacing */
            font-size: 1.1em; /* Slightly larger font */
            display: flex;
            align-items: center;
            gap: 15px; /* Space between label and value */
        }

        .ticket-detail .label {
            font-weight: 700; /* Bolder label */
            color: #555;
            flex-basis: 120px; /* Fixed width for labels */
            text-align: right;
            padding-right: 10px;
        }

        .ticket-detail .value {
            color: #333;
            flex-grow: 1; /* Value takes remaining space */
            word-break: break-word; /* Prevents long names from overflowing */
        }

        .ticket-detail .icon-detail {
            font-size: 1.2em;
            color: #888;
        }

        .return-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: var(--accent-orange);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.05em;
            margin-top: 30px;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(255, 152, 0, 0.3);
        }

        .return-button:hover {
            background-color: #ffa726;
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(255, 152, 0, 0.4);
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
            h2.page-heading { font-size: 2.2em; margin-top: 30px; }
            .ticket-card { padding: 25px; margin: 30px auto; }
            .ticket-card h3 { font-size: 1.5em; }
            .ticket-detail { flex-direction: column; align-items: flex-start; gap: 5px; }
            .ticket-detail .label { text-align: left; flex-basis: auto; width: 100%; padding-right: 0; }
            .ticket-detail .value { width: 100%; }
        }

        @media (max-width: 480px) {
            h2.page-heading { font-size: 1.8em; }
            .ticket-card { padding: 20px; }
            .ticket-card h3 { font-size: 1.3em; }
            .ticket-detail { font-size: 1em; }
            .return-button { padding: 10px 20px; font-size: 0.95em; }
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

    <h2 class="page-heading">Your Ticket is Confirmed!</h2>

    <div class="ticket-card">
        <h3><i class="fas fa-ticket-alt icon"></i> Your E-Ticket</h3>
        <div class="ticket-detail">
            <span class="label">Name:</span> <span class="value"><%= request.getAttribute("name") %></span>
        </div>
        <div class="ticket-detail">
            <span class="label">Movie:</span> <span class="value"><%= request.getAttribute("eventId") %></span>
        </div>
        <div class="ticket-detail">
            <span class="label">Seats:</span> <span class="value"><%= request.getAttribute("seatCount") %></span>
        </div>
        <a href="home.jsp" class="return-button">Back to Home</a>
    </div>

    <div class="footer">
        &copy; 2025 RETROMOVIES. All rights reserved.
    </div>
</body>
</html>