
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Students</title>
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

            #student-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #2c3e50;
                color: #fff;
            }

            td {
                background-color: #fff;
            }

            #search-bar {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            #search-input {
                flex-grow: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 10px;
            }

            #search-button {
                background-color: #2c3e50;
                color: #fff;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
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
            } else {
                Statement st = null;
                Connection c1 = null;
                String q = "";


        %>
        <div id="header">
            <div id="nav">
                <h1><%= session.getAttribute("department")%></h1>
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
                    <div id="search-bar">
                        <input type="text" placeholder="Search..." id="search-input">
                        <button id="search-button" onclick="search()">Search</button>
                    </div>
                    <table id="student-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>PRN or ID</th>
                                <th>Contact</th>
                                <th>Email</th>
                                <th>Year</th>
                                <th>Department</th>
                                <th>Allot No Due Form</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/noduseclearance", "root", "root");
                                    q = "select * from students;";
                                    st = c1.createStatement();
                                    ResultSet r = st.executeQuery(q);
                                    while (r.next()) {
                            %>
                            <tr>
                                <td><%= r.getString("name")%></td>
                                <td><%= r.getLong("prn")%></td>
                                <td><%= r.getLong("mobile")%></td>
                                <td><%= r.getString("email")%></td>
                                <td><%= r.getString("year")%></td>
                                <td><%= r.getString("department")%></td>
                                <td><a href="NoDue_Form.jsp?prn=<%= r.getLong(2)%>&year=<%= r.getString(4)%>">Allot No Due</a></td>
                            </tr>
                            <%
                                    }
                                    c1.close();
                                } catch (Exception e) {
                                    out.print(e);
                                }%>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function search() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("search-input");
                filter = input.value.toUpperCase();
                table = document.getElementById("student-table");
                tr = table.getElementsByTagName("tr");

                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0]; // Change index based on the column you want to search
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
        <script >
            function alertNamefun() {
                var status = '<%= session.getAttribute("status")%>';
                if (status === "success") {
                    alert("No Dues Alloted Successfully");
                }
                if (status === "failed") {
                    alert("Failed to Allote! Student Doesn't Exist.");
                }
                if (status === "duplicate") {
                    alert("No dues Already Alloted.");
                }
            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
        <% session.setAttribute("status", null);
        %>
    </body>
    <%}%>
    
</html>