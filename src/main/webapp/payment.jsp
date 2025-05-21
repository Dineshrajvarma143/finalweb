<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking success</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4fff4;
            text-align: center;
            padding-top: 50px;
        }
        .message {
            color: green;
            font-size: 24px;
            font-weight: bold;
        }
        .button {
            margin-top: 30px;
        }
        .button a {
            padding: 10px 20px;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }
        .button a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
	<div class="message">
        <%
            String msg = (String) request.getAttribute("message");
            if (msg != null) {
        %>
            <%= msg %>
        <%
            } else {
        %>
            Ticket Booked  completed successfully!
        <%
            }
        %>
    </div>

    <div class="button">
        <a href="home.jsp">Go to Home</a>
        <a href="view.jsp">View Bookings</a>
    </div>
</body>
</html>