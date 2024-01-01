<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>No Dues Clearance | Change password</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            #navbar {
                background-color: #333;
                color: #fff;
                padding: 15px;
                margin-bottom: 20px; /* Added margin at the downside */
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            #logo {
                font-size: 24px;
                font-weight: bold;
            }

            #nav-links {
                display: flex;
            }

            #nav-links a {
                margin-left: 20px;
                text-decoration: none;
                color: #fff;
                transition: color 0.3s;
            }

            #nav-links a:hover {
                color: #ffd700;
            }

            #header {
                background-color: #2c3e50;
                color: #fff;
                padding: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            #nav-icon {
                cursor: pointer;
                font-size: 24px;
            }

            #nav-menu {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                width: 250px;
                background-color: #333;
                padding-top: 60px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                z-index: 1;
            }

            #close-btn {
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
                color: #fff;
                font-size: 20px;
            }

            #nav-menu a {
                display: block;
                padding: 15px;
                color: #fff;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            #nav-menu a:hover {
                background-color: #555;
            }

            #left-aside {
                width: 20%;
                background-color: #555;
                color: #fff;
                padding: 10px;
                border-radius: 8px;
                margin-left: 20px;
            }

            #right-aside {
                width: 75%;
            }

            #profile-info {
                margin-bottom: 20px;
            }

            #profile-info img {
                border-radius: 50%;
                margin-right: 10px;
            }

            #change-password-form {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            #change-password-form h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #2c3e50;
            }

            #change-password-form label {
                display: block;
                margin-bottom: 8px;
                color: #2c3e50;
            }

            #change-password-form input {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            #change-password-form button {
                background-color: #2c3e50;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                display: block;
                margin: 0 auto;
            }
        </style>
    </head>

    <body>
        <%
            // can not store user data on this page ie to prevent back after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if (session.getAttribute("prn") == null) {
                //checking only prn cause if prn gets nulll it will not check further for true
                response.sendRedirect("Student_Login.jsp");
            }
        %>
        <div id="navbar">
            <div id="logo">No Dues Clearance</div>
            <div id="nav-links">
                
                <a href="Student_Profile.jsp">My Profile</a>
                <a href="Student_NoDues.jsp">My NoDues</a>
                <a href="Student_ChangePassword.jsp">Change Password</a>
                <a href="Logout">Logout</a>
            </div>
        </div>

        <div id="aside" style="display: flex;">
            <div id="left-aside">
                <div id="profile-info">
                    <img src="profile-icon.png" alt="Profile Image" width="50" height="50">
                    <span>User Name</span>
                </div>
            </div>
            <div id="right-aside">
                <div id="change-password-form">
                    <h2>Change Password</h2>
                    <form>
                        <label for="current-password">Current Password:</label>
                        <input type="password" id="current-password" name="current-password">

                        <label for="new-password">New Password:</label>
                        <input type="password" id="new-password" name="new-password">

                        <label for="confirm-password">Confirm Password:</label>
                        <input type="password" id="confirm-password" name="confirm-password">

                        <button type="button">Change Password</button>
                    </form>
                </div>
            </div>
        </div>


    </body>
</html>
