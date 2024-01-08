
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
                
                justify-content: center;
                margin: 20px;
            }

            

            #dataTable {
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

            #searchInput {
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
                
            } else if (session.getAttribute("hodid") == null) {
                response.sendRedirect("Hod_Login.jsp");
                
            } else {
                Statement st = null;
                Connection c1 = null;
                String q = "";
        %>
        <div id="header">
            <div id="nav">
                <h1><%= session.getAttribute("department").toString().substring(0, 1).toUpperCase() + session.getAttribute("department").toString().substring(1)%></h1>
            </div>
            <div id="options">
                
                <a href="Department_AddStudent.jsp">Add Student</a>
                <a href="Department_ViewStudent.jsp">View Student</a>

                <a href="Hod_ChangePassword.jsp">Change Password</a>
                <a href="Logout">Logout</a>
            </div>
        </div>

        <div id="main-content">
            <div id="aside">
                
              
                    <div id="search-bar">
                        <input type="text" placeholder="Search..." id="searchInput">

                    </div>
                    <table id="dataTable">
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
                                    q = "select * from students where department='"+session.getAttribute("department")+"';";
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const searchInput = document.getElementById("searchInput");
                const dataTable = document.getElementById("dataTable").getElementsByTagName("tbody")[0].getElementsByTagName("tr");

                searchInput.addEventListener("keyup", function () {
                    const searchValue = searchInput.value.toLowerCase();

                    for (let i = 0; i < dataTable.length; i++) {
                        const rowData = dataTable[i].textContent.toLowerCase();

                        if (rowData.includes(searchValue)) {
                            dataTable[i].style.display = "";
                        } else {
                            dataTable[i].style.display = "none";
                        }
                    }
                });
            });
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
