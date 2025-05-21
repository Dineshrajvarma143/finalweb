<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/DRV";
    String dbUser = "root";
    String dbPass = "9494136336";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    String type = request.getParameter("type");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        if ("add".equals(action) && "movie".equals(type)) {
            String name = request.getParameter("moviename");
            String imageurl = request.getParameter("imageurl"); // Corrected parameter name
            ps = conn.prepareStatement("INSERT INTO movielist (imageurl, moviename) VALUES (?, ?)");
            ps.setString(1, imageurl);
            ps.setString(2, name);
            ps.executeUpdate();
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if ("movie".equals(type)) {
                // Assuming you want to delete by ID for consistency with other operations
                ps = conn.prepareStatement("DELETE FROM movielist WHERE id = ?");
            } else { // type is "user"
                ps = conn.prepareStatement("DELETE FROM logindata WHERE id = ?");
            }
            ps.setInt(1, id);
            ps.executeUpdate();
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if ("movie".equals(type)) {
                String name = request.getParameter("moviename");
                String image_url = request.getParameter("imageurl");
                ps = conn.prepareStatement("UPDATE movielist SET moviename=?, imageurl=?  WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, image_url);
                ps.setInt(3, id);
                ps.executeUpdate();
            }
        }
    } catch (Exception e) {
        out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            // Log the exception for debugging, but don't show to user
            System.err.println("Database resource closing error: " + ex.getMessage());
        }
    }
%>

<html>
<head>
    <title>Admin Panel - Enhanced</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4A90E2; /* Blue */
            --secondary-color: #50E3C2; /* Green */
            --danger-color: #FF6B6B; /* Red */
            --text-color: #333;
            --light-gray: #f9f9f9;
            --border-color: #e0e0e0;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-medium: rgba(0, 0, 0, 0.12);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--light-gray);
            margin: 0;
            padding: 40px;
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px var(--shadow-medium);
        }

        h2 {
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 30px;
            color: var(--text-color);
            font-weight: 600;
            font-size: 1.8em;
        }

        /* --- Logout Button --- */
        .logout-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .logout-button {
            background-color: var(--danger-color);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 500;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 10px rgba(255, 107, 107, 0.3);
        }

        .logout-button:hover {
            background-color: #e65a5a;
            transform: translateY(-2px);
        }

        /* --- Form Styling --- */
        form.movie-form {
            display: grid;
            grid-template-columns: 1fr 1fr auto; /* Removed the third 1fr as it was unused */
            gap: 20px;
            margin-top: 20px;
            padding-bottom: 30px; /* Add some space below the form */
            border-bottom: 1px dashed var(--border-color); /* Separator */
            margin-bottom: 30px;
        }

        input[type="text"], input[type="email"] {
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1em;
            width: 100%; /* Ensure full width within grid cell */
            box-sizing: border-box; /* Include padding in width */
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus, input[type="email"]:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
            outline: none;
        }

        input[type="submit"] {
            background: var(--primary-color);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 500;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(74, 144, 226, 0.3);
        }

        input[type="submit"]:hover {
            background: #3a7bd2;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(74, 144, 226, 0.4);
        }

        /* --- Table Styling --- */
        .scroll-table {
            max-height: 450px; /* Increased height */
            overflow-y: auto;
            margin-top: 20px;
            border: 1px solid var(--border-color); /* Add border to the scrollable area */
            border-radius: 8px;
            box-shadow: inset 0 0 8px var(--shadow-light); /* Inner shadow for scroll */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px; /* Slightly wider for better content display */
        }

        th, td {
            border: 1px solid var(--border-color);
            padding: 12px 15px;
            text-align: left;
            font-size: 0.95em;
        }

        th {
            background-color: var(--primary-color);
            color: white;
            position: sticky;
            top: 0;
            z-index: 2; /* Ensure sticky header is above other content */
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background-color: var(--light-gray); /* Zebra striping */
        }

        tr:hover {
            background-color: #f0f0f0; /* Hover effect */
        }

        /* --- Actions Column --- */
        .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .actions input[type="submit"] {
            background-color: var(--secondary-color);
            padding: 8px 15px; /* Smaller padding for action buttons */
            font-size: 0.9em;
            box-shadow: 0 3px 8px rgba(80, 227, 194, 0.3);
        }

        .actions input[type="submit"]:hover {
            background-color: #42c2a8;
        }

        .actions .delete-link { /* Using a class for consistency */
            color: var(--danger-color);
            font-weight: 500;
            text-decoration: none;
            padding: 8px 0; /* Align with button height */
            transition: color 0.3s ease;
        }

        .actions .delete-link:hover {
            text-decoration: underline;
            color: #cc0000;
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
        }
    </style>
</head>
<body>
<div class="logout-container">
    <form action="login.jsp" method="post" style="display: inline;">
        <button type="submit" class="logout-button">Logout</button>
    </form>
</div>

<div class="container">
    <h2>Movie Management</h2>

    <form class="movie-form" method="post" action="update.jsp">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="type" value="movie">
        <input type="text" name="moviename" placeholder="Movie Name" required>
        <input type="text" name="imageurl" placeholder="Image URL" required>
        <input type="submit" value="Add Movie">
    </form>

    <div class="scroll-table">
        <table>
            <thead>
                <tr><th>ID</th><th>Name</th><th>Image URL</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <%
                try {
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    ps = conn.prepareStatement("SELECT * FROM movielist ORDER BY id ASC"); // Order by ID
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
                <tr>
                    <form method="post" action="update.jsp">
                        <td>
                            <%= rs.getInt("id") %>
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        </td>
                        <td><input type="text" name="moviename" value="<%= rs.getString("moviename") %>"></td>
                        <td><input type="text" name="imageurl" value="<%= rs.getString("imageurl") %>"></td>
                        
                        <td class="actions">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="type" value="movie">
                            <input type="submit" value="Update">
                            <form method="post" action="update.jsp" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="type" value="movie">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="submit" value="Delete" class="delete-button">
                            </form>
                        </td>
                    </form>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='error-message'>Error loading movies: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException ex) {
                        System.err.println("Database resource closing error: " + ex.getMessage());
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <h2 style="margin-top: 50px;">User Management</h2>
    <table>
        <thead>
            <tr><th>ID</th><th>Email</th><th>Actions</th></tr>
        </thead>
        <tbody>
        <%
            try {
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                ps = conn.prepareStatement("SELECT * FROM logindata ORDER BY id ASC"); // Order by ID
                rs = ps.executeQuery();
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><input type="email" value="<%= rs.getString("email") %>" readonly></td>
                <td class="actions">
                    <form method="post" action="update.jsp" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="type" value="user">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <input type="submit" value="Delete" class="delete-button">
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<div class='error-message'>Error loading users: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    System.err.println("Database resource closing error: " + ex.getMessage());
                }
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>