<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String movieId = request.getParameter("movieId");

    String movieName = "";
    String imageUrl = "";
    // String duration = ""; // Not used, so removed

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DRV", "root", "9494136336");
        PreparedStatement ps = conn.prepareStatement("SELECT moviename, imageurl FROM movielist WHERE id = ?");
        ps.setInt(1, Integer.parseInt(movieId));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            movieName = rs.getString("moviename");
            imageUrl = rs.getString("imageurl");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<div class='error-message'><h3>Error loading movie: " + e.getMessage() + "</h3></div>");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="Retro.png">
<title>Retro Movies - Book Your Tickets</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-dark: #2c3e50; /* Dark blue/gray */
        --primary-light: #34495e; /* Slightly lighter dark */
        --accent-green: #2ecc71; /* Vibrant green for success */
        --accent-red: #e74c3c; /* Red for danger/logout */
        --text-color: #333;
        --light-bg: #ecf0f1; /* Light gray background */
        --form-bg: #ffffff;
        --border-color: #ddd;
        --shadow-light: rgba(0, 0, 0, 0.1);
        --shadow-medium: rgba(0, 0, 0, 0.2);
    }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: var(--light-bg);
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
        box-sizing: border-box;
        color: var(--text-color);
        background-image: url("https://static.vecteezy.com/system/resources/previews/029/928/525/non_2x/get-your-ticket-online-cinema-movie-ticket-online-order-concept-illustration-vector.jpg");
        background-repeat: no-repeat;
        background-position: center top; /* Adjusted to be slightly higher */
        background-size: cover;
        background-attachment: fixed; /* Keep background fixed when scrolling */
    }

    /* --- Navbar --- */
    .navbar {
        background-color: var(--primary-dark);
        overflow: hidden;
        width: 100%;
        box-shadow: 0 4px 8px var(--shadow-medium);
        padding: 10px 0;
        display: flex;
        justify-content: space-between; /* Aligns brand to left, links to right */
        align-items: center;
    }

    .navbar-brand {
        color: white;
        font-size: 1.8em; /* Larger font for brand */
        font-weight: 700;
        padding: 0 20px;
        text-decoration: none;
        letter-spacing: 1px;
    }

    .navbar-links {
        display: flex;
    }

    .navbar a {
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
        font-size: 1.1em;
        transition: background-color 0.3s ease, color 0.3s ease;
        border-radius: 5px; /* Slightly rounded corners for links */
        margin-right: 10px; /* Space between links */
    }

    .navbar a:hover {
        background-color: var(--primary-light);
        color: white;
    }

    .navbar a.logout {
        background-color: var(--accent-red);
    }

    .navbar a.logout:hover {
        background-color: #c0392b; /* Darker red on hover */
    }

    /* --- Page Headers --- */
    h1, h2 {
        color: var(--primary-dark);
        text-align: center;
        margin-top: 40px;
        margin-bottom: 10px;
        font-weight: 700;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }

    h1 {
        font-size: 2.8em;
        color: white; /* Make headings stand out on background image */
        text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }

    h2 {
        font-size: 1.8em;
        color: white;
        margin-bottom: 30px;
    }

    /* --- Form Styling --- */
    .booking-card {
        background-color: var(--form-bg);
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 20px var(--shadow-medium);
        width: 90%;
        max-width: 550px;
        margin-top: 20px;
        box-sizing: border-box;
        border: 1px solid var(--border-color);
        display: flex;
        flex-direction: column;
        align-items: center; /* Center content within the card */
    }

    .movie-display {
        text-align: center;
        margin-bottom: 25px;
        padding-bottom: 20px;
        border-bottom: 1px dashed var(--border-color);
        width: 100%;
    }

    .movie-display img {
        width: 150px; /* Adjust size as needed */
        height: auto;
        border-radius: 8px;
        box-shadow: 0 4px 10px var(--shadow-light);
        margin-bottom: 15px;
        border: 2px solid var(--primary-dark);
    }

    .movie-display h3 {
        color: var(--primary-dark);
        font-size: 1.6em;
        margin: 0;
        font-weight: 600;
    }

    .movie-display p {
        color: #777;
        font-size: 0.95em;
        margin-top: 5px;
    }

    .form-group {
        width: 100%;
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: var(--primary-dark);
        font-weight: 600;
        font-size: 1.05em;
    }

    input[type="text"],
    select {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 1.05em;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    input[type="text"]:focus,
    select:focus {
        border-color: var(--accent-green);
        box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.2);
        outline: none;
    }

    button[type="submit"] {
        background-color: var(--accent-green);
        color: white;
        padding: 15px 25px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1.15em;
        font-weight: 600;
        transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        width: 100%;
        box-sizing: border-box;
        margin-top: 10px;
        box-shadow: 0 4px 10px rgba(46, 204, 113, 0.3);
    }

    button[type="submit"]:hover {
        background-color: #27ae60; /* Darker green on hover */
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(46, 204, 113, 0.4);
    }

    /* --- Error Message Styling --- */
    .error-message {
        background-color: #ffe6e6;
        color: #cc0000;
        padding: 15px;
        border: 1px solid #ffb3b3;
        border-radius: 8px;
        margin-bottom: 20px;
        font-weight: 500;
        text-align: center;
        width: 80%;
        max-width: 500px;
        margin-top: 20px;
    }

    /* --- Footer --- */
    .footer {
        margin-top: auto; /* Pushes footer to the bottom */
        width: 100%;
        background-color: var(--primary-dark);
        color: white;
        text-align: center;
        padding: 20px 0;
        font-size: 0.9em;
        box-shadow: 0 -4px 8px var(--shadow-medium);
    }

    @media (max-width: 768px) {
        h1 { font-size: 2em; }
        h2 { font-size: 1.5em; }
        .navbar-brand { font-size: 1.5em; }
        .navbar a { padding: 10px 15px; font-size: 0.9em; }
        .booking-card { padding: 20px 25px; max-width: 95%; }
        input[type="text"], select, button { font-size: 1em; }
    }
</style>
</head>
<body>
    <div class="navbar">
        <a href="home.jsp" class="navbar-brand">RETRO MOVIES</a>
        <div class="navbar-links">
            <a href="home.jsp">Home</a>
            <a href="cancel.jsp">Cancel Tickets</a>
            <a href="login.jsp" class="logout">Logout</a>
        </div>
    </div>

    <h1>Hello, movie lovers! Ready to book your next show?</h1>
    <h2>Experience movies like never before!</h2>

    <div class="booking-card">
        <div class="movie-display">
            <% if (movieName != null && !movieName.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="<%= movieName %> Poster">
                <h3><%= movieName %></h3>
                <p>Get ready for an unforgettable cinematic journey!</p>
            <% } else { %>
                <h3>Movie Not Selected</h3>
                <p>Please return to the home page to select a movie.</p>
            <% } %>
        </div>

        <form action="<%=request.getContextPath()%>/Booking" method="get" class="form-horizontal">
            <div class="form-group">
                <label for="name">Your Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter Your Full Name" required/>
            </div>

            <div class="form-group">
                <label for="eventId">Selected Movie:</label>
                <select name="eventId" id="eventId" disabled>
                    <option value="<%=movieName%>"><%= movieName%></option>
                </select>
                <input type="hidden" name="movieId" value="<%= movieId %>"> </div>

            <div class="form-group">
                <label for="seatCount">Number of Seats:</label>
                <select name="seatCount" id="seatCount">
                    <% for (int i = 1; i <= 10; i++) { %> <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>

            <button type="submit" name="button1">Book Now</button>
        </form>
    </div>

    <div class="footer">
        &copy; 2025 Retro Movies. All rights reserved.
    </div>
</body>
</html>