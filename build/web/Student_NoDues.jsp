<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>No Dues Clearance</title>
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
                margin-bottom: 20px;
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

            #sub-nav {
                background-color: #333;
                margin-bottom: 10px;
                color: #fff;
                padding: 10px;
                display: flex;
                justify-content: center;
            }

            #sub-nav a {
                margin: 0 15px;
                text-decoration: none;
                color: #fff;
                transition: color 0.3s;
            }

            #sub-nav a.active {
                color: #ffd700;
            }

            #no-dues-heading {
                text-align: center;
                font-size: 24px;
                margin-bottom: 20px;
            }

            #no-dues-table {
                width: 100%;
                margin: 0 auto;
                border-collapse: collapse;
            }

            #no-dues-table th,
            #no-dues-table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            #no-dues-table th {
                background-color: #2c3e50;
                color: #fff;
            }

            #no-dues-table td {
                background-color: #fff;
            }

            .status-check {

                align-items: center;
            }

            .status-check .checked,
            .status-check .unchecked,
            .status-check .na {
                width: 20px;
                height: 20px;
                border-radius: 50%;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 14px;
            }

            .checked {
                background-color: #28A745; /* Green */
            }

            .unchecked {
                background-color: #DC3545; /* Red */
            }

            .na {
                background-color: #808080; /* Gray */
            }

            .remark-input {
                width: 95%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-top: 5px;

            }
            .login-button {
                text-decoration: none;
                background: #3498db;
                color: #fff;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
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
                <a href="Student_NoDues.jsp" class="active">My No Dues</a>
                <a href="Student_ChangePassword.jsp">Change Password</a>
                <a href="Logout">Logout</a>
            </div>
        </div>

        <div id="sub-nav">
            <a href="Student_NoDues.jsp" class="active">My No Dues</a>

        </div>

        <table id="no-dues-table">
            <thead>
                <tr>
                    <th>Department</th>
                    <th>Status</th>
                    <th>Remark</th>
                    <th>Send Request</th>
                </tr>
            </thead>
            <tbody>
                <%
                Statement st;
                Connection c1;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseclearance","root","root");
                    st  = c1.createStatement();
                    String q = "select * from noduse where  prn="+session.getAttribute("prn");
                    ResultSet r = st.executeQuery(q);
                    if(r.next()){
                        String library = r.getString("libraryStatus");
                    }
                    
                }
                catch(Exception  e){
                    
                }
                %>
                <tr>
                    <td>Library</td>
                    <td class="status-check"><div class="checked">&#10004;</div></td>
                    <td><input type="text" class="remark-input" readonly value="Nill"></td>
                    <td><button class="login-button">Verify</button></td>
                </tr>
                <tr>
                    <td>Account</td>
                    <td class="status-check"><div class="unchecked">&#10008;</div></td>
                    <td><input type="text" class="remark-input" readonly value="Pending Dues"></td>
                    <td><button class="login-button">Verify</button></td>
                </tr>
                <tr>
                    <td>Hostel</td>
                    <td class="status-check"><div class="checked">&#10004;</div></td>
                    <td><input type="text" class="remark-input" readonly value="Nill"></td>
                    <td><button class="login-button">Verify</button></td>
                </tr>
                <tr>
                    <td>Laboratory</td>
                    <td class="status-check"><div class="checked">&#10004;</div></td>
                    <td><input type="text" class="remark-input" readonly value="Nill"></td>
                    <td><button class="login-button">Verify</button></td>
                </tr>
                <!-- Add more rows as needed -->
            </tbody>
        </table>
    </body>
</html>
