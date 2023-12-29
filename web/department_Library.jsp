<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
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

        #middle-section {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .card {
            width: 30%;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
        }

        .card h3 {
            margin: 0;
            color: #2c3e50;
        }

        .card span {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 18px;
            color: #2c3e50;
        }

        #transaction-history {
            width: 100%;
            border-collapse: collapse;
        }

        #transaction-history th, #transaction-history td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        #transaction-history th {
            background-color: #2c3e70;
            color: #fff;
        }

        #transaction-history td {
            background-color: #fff;
        }
    </style>
</head>

<body>

    <div id="navbar">
        <div id="logo">Add No Dues Clearance</div>
        <div id="nav-links">
            <a href="Student_DashBoard.jsp">Home</a>
                <a href="Student_Profile.jsp">My Profile</a>
                <a href="Student_NoDues.jsp">My NoDues</a>
                <a href="Student_ChangePassword.jsp">Change Password</a>
                <a href="Logout.jsp">Logout</a>
        </div>
    </div>

    <div id="sub-nav">
        <a href="Student_NoDues.jsp" >No Dues</a>
        <a href="department_Account.jsp" >Department 1</a>
        <a href="department_Library.jsp" class="active">Department 2</a>
    </div>

    <div id="middle-section">
        <div class="card" style="background-color: #EC8F5E;">
            <h3>Issued Items</h3>
            <span>0</span>
        </div>
        <div class="card" style="background-color: #88AB8E;">
            <h3>Suggestions</h3>
            <span>0</span>
        </div>
        <div class="card" style="background-color: #FF8F8F;">
            <h3>Library Fine</h3>
            <span>0</span>
        </div>
    </div>

    <table id="transaction-history">
        <thead>
            <tr>
                <th>Title</th>
                <th>Item Type</th>
                <th>Issue Date</th>
                <th>Due Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <!-- Sample data, replace with actual transaction history -->
            <tr>
                <td>Book Title 1</td>
                <td>Book</td>
                <td>2023-01-01</td>
                <td>2023-01-15</td>
                <td>Issued</td>
            </tr>
            <tr>
                <td>Magazine Title 1</td>
                <td>Magazine</td>
                <td>2023-02-01</td>
                <td>2023-02-15</td>
                <td>Returned</td>
            </tr>
            <!-- Add more rows as needed -->
        </tbody>
    </table>
    </body>
</html>
