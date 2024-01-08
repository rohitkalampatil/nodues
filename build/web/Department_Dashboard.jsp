
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
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

                color: #fff;
                padding: 10px;
                border-radius: 8px;
            }

            #left-aside nav ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            #left-aside nav button {
                width: 100%;
                color: #2c3e50;
                display: block;
                padding: 8px;
                margin-bottom: 5px;
                border: 2px solid #007BFF;
                background: transparent;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            #left-aside nav button:hover {
                background-color: #217dbb;
            }

            #right-aside {
                width: 75%;
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

            table {
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

            .actions {
                display: flex;
            }

            .approve, .reject {
                background-color: #28A745;
                color: #fff;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                margin-right: 5px;
            }

            .reject {
                background-color: #DC3545;
            }

            #reason-input {
                margin-top: 10px;
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

            #security-options {
                text-decoration: none;
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
                <div id="left-aside">
                    <nav>
                        <ul>
                            <li><button class="btn" id="approvebtn">Approved</button></li>
                            <li><button class="btn" id="rejectbtn">Rejected</button></li>
                            <li><button class="btn" id="pendingbtn">Pending</button></li>
                            <li><button class="btn" id="allbtn">List All</button></li>
                        </ul>
                    </nav>
                </div>
                <div id="right-aside">
                    <div id="search-bar">
                        <input type="text" placeholder="Search..." id="searchInput">

                    </div>
                    <table id="dataTable">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>ID</th>
                                <th>Contact</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                // Database connection parameters
                                String url = "jdbc:mysql://localhost:3306/noduseclearance";
                                String username = "root";
                                String password = "root";

                                try {
                                    // Load the JDBC driver
                                    Class.forName("com.mysql.jdbc.Driver");

                                    // Establish a connection
                                    Connection connection = DriverManager.getConnection(url, username, password);

                                    String departmentStatus = "";
                                    if (session.getAttribute("departmentName").equals("account")) {
                                        departmentStatus = "accountStatus";
                                    } else if (session.getAttribute("departmentName").equals("library")) {
                                        departmentStatus = "libraryStatus";
                                    } else if (session.getAttribute("departmentName").equals("laboratory")) {
                                        departmentStatus = "laboratoryStatus";
                                    } else if (session.getAttribute("departmentName").equals("hostel")) {
                                        departmentStatus = "hostelStatus";
                                    }
                                    session.setAttribute("departmentStatus", departmentStatus);
                                    // Create a statement for noduse table
                                    Statement noduseStatement = connection.createStatement();
                                    ResultSet noduseResultSet = noduseStatement.executeQuery("SELECT * FROM noduse where " + departmentStatus + "='reject' or " + departmentStatus + "='pending' or " + departmentStatus + "='approve'");
                                    // Display the data in an HTML table
                                    Statement studentsStatement = connection.createStatement();
                                    while (noduseResultSet.next()) {

                                        ResultSet studentsResultSet = studentsStatement.executeQuery("SELECT * FROM students where prn=" + noduseResultSet.getLong("prn"));

                                        while (studentsResultSet.next()) {

                            %>
                            <tr>
                                <td><%= studentsResultSet.getString("name")%></td>
                                <td><%= studentsResultSet.getLong("prn")%></td>
                                <td><%= studentsResultSet.getLong("mobile")%></td>
                                <td><%= studentsResultSet.getString("email")%></td>
                                <td><%= noduseResultSet.getString(departmentStatus)%></td>
                                <td class="actions">
                                    <a class="approve" href="Verify_Department?prn=<%= studentsResultSet.getLong("prn")%>&status=approve">Approve</a>
                                    <a class="reject" href="Verify_Department?prn=<%= studentsResultSet.getLong("prn")%>&status=reject">Reject</a>
                                </td>
                            </tr>
                            <%
                                        }
                                    }
                                    connection.close();
                                } catch (Exception e) {

                                }

                            %>

                            <!-- Add more rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const searchInput = document.getElementById("searchInput");
                const dataTable = document.getElementById("dataTable").getElementsByTagName("tbody")[0].getElementsByTagName("tr");

                const approveButton = document.getElementById("approvebtn");
                const rejectButton = document.getElementById("rejectbtn");
                const pendingButton = document.getElementById("pendingbtn");
                const allButton = document.getElementById("allbtn");

                allButton.addEventListener("click", function () {
                    document.location.href = "Department_Dashboard.jsp";
                });


                approveButton.addEventListener("click", function () {
                    stpTable("approve");
                });

                rejectButton.addEventListener("click", function () {
                    stpTable("reject");
                });

                pendingButton.addEventListener("click", function () {
                    stpTable("pending");
                });

                function stpTable(sts) {
                    for (let i = 0; i < dataTable.length; i++) {
                        const rowData = dataTable[i].textContent;

                        if (rowData.includes(sts)) {
                            dataTable[i].style.display = "";
                        } else {
                            dataTable[i].style.display = "none";
                        }
                    }
                }

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
                    alert("Response Send.")
                }
                if (status === "failed") {
                    alert("failed to set");
                }
            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
        <% session.setAttribute("status", null);%>
    </body>
    <%}%>
</html>
