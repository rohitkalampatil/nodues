<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            #header {
                background-color: #2c3e50;
                color: #fff;
                padding: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            #nav {
                display: flex;
                align-items: center;
            }

            #nav h1 {
                margin: 0;
            }

            #options {
                display: flex;
            }

            #options a {
                color: #fff;
                text-decoration: none;
                margin-right: 15px;
            }
            #options a:hover{
                color: yellow;
            }
            #aside {

                justify-content: center;
                margin: 20px;
            }

            #change-password-form {
                width: 40%;
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
                width: 97%;
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
            if (session.getAttribute("departmentName") == null) {
                //checking only prn cause if prn gets nulll it will not check further for true
                response.sendRedirect("Department_Login.jsp");
                
            } else {
        %>
        <div id="header">
            <div id="nav">
                <h1><%= session.getAttribute("departmentName").toString().substring(0, 1).toUpperCase() + session.getAttribute("departmentName").toString().substring(1)%></h1>
            </div>
            <div id="options">
                <a href="Department_Dashboard.jsp">No dues requests</a>
                <a href="Department_ChangePassword.jsp">Change Password</a>
                <a href="Logout">Logout</a>
            </div>
        </div>

        <div id="main-content">


            <div id="aside">
                <div id="change-password-form">
                    <h2>Change Password</h2>
                    <form action="DeptChangepass" method="POST">
                        <label for="old-password">Old Password:</label>
                        <input type="password" maxlength="8" id="old-password" name="password" required>

                        <label for="new-password">New Password:</label>
                        <input type="password" maxlength="8" id="new-password" name="pwd1" required>

                        <label for="confirm-new-password">Confirm New Password:</label>
                        <input type="password" maxlength="8" id="confirm-new-password" name="pwd2" required>
                        <span id="error"><%= session.getAttribute("error") == null ? "" : session.getAttribute("error")%></span>
                        <button type="submit">Submit</button>
                    </form>
                </div>
            </div>

        </div>
        <script >

            function alertNamefun() {
                var status = '<%= session.getAttribute("status")%>';

                setTimeout(fundiss, 3000);
                function fundiss() {
                    document.getElementById("error").innerHTML = '<% session.setAttribute("error", "");%>';
                }
                if (status === "success") {
                    alert("Password Changed Successfully")
                }
                if (status === "failed") {
                    alert("failed to set New Password");
                }
            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
        <% session.setAttribute("status", null);%>
        <% session.setAttribute("error", null);%>
    </body>
    <%}%>
</html>
