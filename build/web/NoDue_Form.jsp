<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>No dues Form</title>
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
                display: flex;
                justify-content: space-between;
                margin: 20px;
            }

            #left-aside {
                width: 20%;
                background-color: #2c3e50;
                color: #fff;
                padding: 10px;
                border-radius: 8px;
            }

            #left-aside nav ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            #left-aside nav a {
                text-decoration: none;
                color: #fff;
                display: block;
                padding: 8px;
                margin-bottom: 5px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            #left-aside nav a:hover {
                background-color: #217dbb;
            }

            #right-aside {
                width: 75%;
            }

            #nodue-form {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            #nodue-form h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #2c3e50;
            }

            #nodue-form label {
                display: block;
                margin-bottom: 8px;
                color: #2c3e50;
            }

            #nodue-form input,
            #nodue-form select {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            #nodue-form button {
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
            if (session.getAttribute("department") == null) {
                //checking only prn cause if prn gets nulll it will not check further for true
                response.sendRedirect("Department_Login.jsp");
            }
        %>
        <div id="header">
            <div id="nav">
                <h1>Department Name</h1>
            </div>
            <div id="options">
                <a href="Department_AddStudent.jsp">Add Student</a>
                <a href="Department_ViewStudent.jsp">View Student</a>
               
                <a href="Department_ChangePassword.jsp">Change Password</a>
                <a href="Logout">Logout</a>
            </div>
        </div>

        <div id="main-content">
            <div id="aside">
                <div id="left-aside">
                    <nav>
                        <ul>
                            <li><a href="Department_Dashboard.jsp">pending</a></li>
                            <li><a href="#">Approved</a></li>
                            <li><a href="#">Rejected</a></li>
                        </ul>
                    </nav>
                </div>
                <div id="right-aside">
                    <div id="nodue-form">
                        <h2>Allot No Dues</h2>
                       
                        <form action="NoDueForm" method="POST">
                            <label for="prn">PRN:</label>
                            <input type="text" readonly="true" value="<%= request.getParameter("prn") != null ? request.getParameter("prn"):0%>" onkeyup="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="10" id="prn" name="prn" required>

                            <label for="year">Year:</label>
                            <input type="text" value="<%= request.getParameter("year") %>" id="year" name="year" required readonly="true">

                            <label>Status for Hostel Department:</label>
                            <select id="status_hostel" name="status_hostel" required>
                                
                                <option value="NA">NA</option>
                                <option value="allot">Allot</option>
                            </select>

                            <label>Status for Account Department:</label>
                            <select id="status_account" name="status_account" required>
                              
                                <option value="NA">NA</option>
                                <option value="allot">Allot</option>
                            </select>

                            <label>Status for Library Department:</label>
                            <select id="status_library" name="status_library" required>
                                
                                <option value="NA">NA</option>
                                <option value="allot">Allot</option>
                            </select>

                            <label>Status for Laboratory Department:</label>
                            <select id="status_laboratory" name="status_laboratory" required>
                                
                                <option value="NA">NA</option>
                                <option value="allot">Allot</option>
                            </select>

                            <button type="submit" >Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>
