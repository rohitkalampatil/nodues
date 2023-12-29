
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
            if (session.getAttribute("department") == null) {
                //checking only prn cause if prn gets nulll it will not check further for true
                response.sendRedirect("Department_Login.jsp");
            }
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
                    <table>
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
                            <tr>
                                <td>John Doe</td>
                                <td>12345</td>
                                <td>123-456-7890</td>
                                <td>john.doe@example.com</td>
                                <td>Null</td>
                                <td class="actions">
                                    <button class="approve" onclick="approve(1)">Approve</button>
                                    <button class="reject" onclick="reject(1)">Reject</button>
                                </td>
                            </tr>
                            <!-- Add more rows as needed -->
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
                table = document.querySelector("table");
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

            function approve(id) {
                alert("Approving: " + id);
                document.querySelector(`#main-content table tbody tr:nth-child(${id}) td:nth-child(5)`).textContent = 'Approved';
            }

            function reject(id) {
                var reason = prompt("Enter reason for rejection:");
                if (reason !== null) {
                    alert("Rejecting: " + id + " with reason: " + reason);
                    document.querySelector(`#main-content table tbody tr:nth-child(${id}) td:nth-child(5)`).textContent = 'Rejected: ' + reason;
                }
            }
        </script>
    </body>
</html>
