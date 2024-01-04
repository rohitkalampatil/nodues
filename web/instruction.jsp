<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>No Dues Clearance Instructions</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }

            header {
                background: white;
                color: black;
                padding: 2px;
                text-align: center;
            }

            nav {
                display: flex;
                justify-content: center;
                background: #2c3e50;
                padding: 10px;
            }

            nav a {
                color: #fff;
                text-decoration: none;
                padding: 5px 15px;
                border-radius: 5px;
                margin: 0 10px;
            }
            a:hover {
                color: yellow;
            }

            section {
                padding: 2em;
                height: 100vh;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1em;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #007BFF;
                color: #fff;
            }

            .green-check {
                color: #28a745;
            }

            .red-cross {
                color: #dc3545;
            }
            .grey{
                color: grey;
            }
            .blue{
                color: blue;
            }
            footer {
                background: white;
                color: black;
                padding: 10px;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <header>
            <h1>No Dues Application</h1>
        </header>
        <nav>
            <a href="index.html">Home</a>
            <a href="Student_Login.jsp">Student Login</a>
            <a href="Department_Login.jsp">Department Login</a>
            <a href="instruction.jsp">Instructions</a>
        </nav>
        <section>
            <h2>Student Dashboard</h2>
            <p>
                Welcome to your personalized dashboard. Here, you can manage your profile, change password, and check your
                No Dues status.
            </p>

            <h2>My No Dues Section</h2>
            <p>
                In this section, you can view your department-wise clearance status.
            </p>
            <h3>Instructions for No Dues Clearance:</h3>
            <ol>
                <li class="green-check">Green Checkmark: No pending dues in this department. You are clear.</li>
                <li class="red-cross">Red Cross: Click on the red cross to view detailed remarks and understand the
                    outstanding dues.</li>
                <li class="blue"> Blue Checkmark : Blue check mark shows that Request is Pending, No action taken by Department</li>
                <li class="grey">Grey Checkmark : Send request of clearance to Department</li>

            </ol>
        </section>


        <footer>
            Need help? Contact the Support Team at support@example.com
        </footer>

    </body>

</html>

