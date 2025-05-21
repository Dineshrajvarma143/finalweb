<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="Retro.png">
<title>RETROMOVIES - Your Cinematic Journey Begins</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-dark: #1a1a1a; /* Very dark background */
        --accent-orange: #ff9800; /* Vibrant orange for highlights */
        --text-light: #f0f0f0; /* Off-white for general text */
        --card-bg: rgba(255, 255, 255, 0.08); /* Slightly transparent card background */
        --card-hover-bg: rgba(255, 255, 255, 0.15); /* Lighter on hover */
        --button-bg: #e74c3c; /* Red for actions like logout/book */
        --button-hover-bg: #c0392b; /* Darker red on hover */
        --shadow-strong: rgba(0, 0, 0, 0.6);
        --shadow-light: rgba(0, 0, 0, 0.3);
    }

    body {
        margin: 0;
        padding: 0;
        font-family: 'Open Sans', sans-serif;
        background-image: url('https://media.istockphoto.com/id/1446047204/photo/user-buying-movie-tickets-online.jpg?s=612x612&w=0&k=20&c=j8ktOop0chkbIXL_by-boRmgaRLarw39EGKdSszW25s=');
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
        background-attachment: fixed; /* Keep background fixed for a sleek look */
        min-height: 100vh;
        color: var(--text-light);
        display: flex;
        flex-direction: column; /* Allows content to push footer down */
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
        background-color: var(--button-bg);
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
        background-color: var(--button-hover-bg);
        transform: translateY(-2px);
    }

    h1.page-title {
        text-align: center;
        margin-top: 50px; /* Space from navbar */
        font-family: 'Montserrat', sans-serif;
        font-size: 3.5rem;
        font-weight: 700;
        color: white;
        text-shadow: 0 4px 8px var(--shadow-strong);
        animation: fadeInDown 1s ease-out;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* --- Movie Grid --- */
    .content-wrapper {
        flex-grow: 1; /* Allows content to expand and push footer down */
        padding: 3rem 5%;
        max-width: 1400px;
        margin: 0 auto;
    }

    .section-title {
        font-family: 'Montserrat', sans-serif;
        font-size: 2.5rem;
        font-weight: 600;
        color: var(--text-light);
        text-align: center;
        margin-bottom: 2.5rem;
        text-shadow: 0 2px 5px var(--shadow-strong);
    }

    .movie-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* Slightly larger cards */
        gap: 2.5rem; /* More space between cards */
        justify-content: center; /* Center grid items if they don't fill the row */
    }

    .movie-card {
        background-color: var(--card-bg);
        border-radius: 15px; /* More rounded corners */
        overflow: hidden; /* Ensures image corners are rounded */
        text-align: center;
        box-shadow: 0 8px 20px var(--shadow-strong);
        transition: transform 0.4s ease, box-shadow 0.4s ease, background-color 0.4s ease;
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* Pushes button to bottom */
        animation: fadeInUp 0.8s ease-out; /* Fade in animation */
        opacity: 0; /* Start hidden for animation */
        animation-fill-mode: forwards;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .movie-card:hover {
        transform: translateY(-8px); /* Lift effect */
        box-shadow: 0 12px 25px var(--accent-orange); /* Glowing shadow */
        background-color: var(--card-hover-bg);
    }

    .movie-card img {
        width: 100%;
        height: 350px; /* Fixed height for consistent card size */
        object-fit: cover; /* Ensures image covers area without distortion */
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        transition: transform 0.3s ease;
    }

    .movie-card:hover img {
        transform: scale(1.05); /* Slight zoom on image hover */
    }

    .movie-info {
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        flex-grow: 1; /* Allows info to take available space */
        justify-content: space-between;
    }

    .movie-title {
        font-family: 'Montserrat', sans-serif;
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--text-light);
        margin-top: 0;
        margin-bottom: 1rem;
        text-transform: capitalize; /* Capitalize movie titles */
    }

    .book-button {
        background-color: var(--accent-orange);
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1.1rem;
        font-weight: 600;
        transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        width: 100%;
        margin-top: 1.5rem; /* Space from title */
        box-shadow: 0 4px 10px rgba(255, 152, 0, 0.4);
    }

    .book-button:hover {
        background-color: #ffb347; /* Lighter orange on hover */
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(255, 152, 0, 0.6);
    }

    /* --- Error Message --- */
    .error-message {
        background-color: rgba(255, 99, 71, 0.8); /* Tomato red with transparency */
        color: white;
        padding: 20px;
        border-radius: 10px;
        text-align: center;
        margin: 50px auto;
        max-width: 600px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        font-weight: 600;
        font-size: 1.1rem;
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
    @media (max-width: 1024px) {
        .navbar-brand { font-size: 1.8rem; }
        .nav-links { gap: 1.5rem; }
        .navbar a { font-size: 1rem; }
        h1.page-title { font-size: 2.8rem; }
        .section-title { font-size: 2rem; }
        .movie-card { grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); }
        .movie-card img { height: 300px; }
    }

    @media (max-width: 768px) {
        .navbar { flex-direction: column; gap: 1rem; padding: 1rem; }
        .nav-links { width: 100%; justify-content: center; flex-wrap: wrap; gap: 1rem;}
        .navbar-brand { margin-bottom: 0.5rem; }
        h1.page-title { font-size: 2rem; margin-top: 30px; }
        .section-title { font-size: 1.8rem; margin-bottom: 2rem; }
        .content-wrapper { padding: 2rem 3%; }
        .movie-grid { gap: 1.5rem; }
        .movie-card img { height: 250px; }
        .movie-title { font-size: 1.3rem; }
        .book-button { padding: 10px 20px; font-size: 1rem; }
    }

    @media (max-width: 480px) {
        .navbar a { padding: 8px 12px; font-size: 0.9rem; }
        h1.page-title { font-size: 1.8rem; }
        .section-title { font-size: 1.5rem; }
        .movie-grid { grid-template-columns: 1fr; } /* Single column on very small screens */
        .movie-card img { height: 200px; }
    }
</style>
</head>
<body>

<div class="header-container">
    <div class="navbar">
        <a href="#" class="navbar-brand">RETROMOVIES</a>
        <div class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="cancel.jsp">Cancel Tickets</a>
            <form action="login.jsp" method="post" style="display: inline;">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>
    </div>
</div>

<h1 class="page-title">Your Cinematic Journey Begins Here!</h1>

<div class="content-wrapper">
    <h2 class="section-title">Now Showing</h2>
    <div class="movie-grid">
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/DRV";
            String jdbcUsername = "root";
            String jdbcPassword = "9494136336";

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                String sql = "SELECT id, moviename, imageurl FROM movielist";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                int animationDelay = 0; // For staggered animation
                while(rs.next()) {
                    int movieId = rs.getInt("id");
                    String name = rs.getString("moviename");
                    String imageUrl = rs.getString("imageurl");
        %>
        <div class="movie-card" style="animation-delay: <%= animationDelay %>ms;">
            <img src="<%=imageUrl%>" alt="<%=name%> Poster" />
            <div class="movie-info">
                <h3 class="movie-title"><%=name%></h3>
                <form action="booking.jsp" method="get" style="margin-top:auto;">
                    <input type="hidden" name="movieId" value="<%=movieId%>" />
                    <button type="submit" class="book-button">Book Now</button>
                </form>
            </div>
        </div>
        <%
                    animationDelay += 100; // Increment delay for next card
                }
            } catch(Exception e) {
        %>
            <div class="error-message" style="grid-column: 1 / -1;">
                <strong>Error loading movies:</strong> <%= e.getMessage() %>
            </div>
        <%
            } finally {
                try { if(rs!= null) rs.close(); } catch(Exception ignored) {}
                try { if(ps!= null) ps.close(); } catch(Exception ignored) {}
                try { if(conn!= null) conn.close(); } catch(Exception ignored) {}
            }
        %>
    </div>
</div>

<div class="footer">
    &copy; 2025 RETROMOVIES. All rights reserved.
</div>

</body>
</html>