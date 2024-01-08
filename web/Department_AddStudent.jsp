<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Student</title>
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

            

            #registration-form {
                width: 50%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            #registration-form h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #2c3e50;
            }

            #registration-form label {
                display: block;
                margin-bottom: 8px;
                color: #2c3e50;
            }

            #registration-form input,
            #registration-form select {
                width: 97%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            #registration-form button {
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
            if (session.getAttribute("hodid") == null) {
                //checking only prn cause if prn gets nulll it will not check further for true
                response.sendRedirect("Hod_Login.jsp");
            }else {
            
            Connection c1=null;
            Statement st = null;
            Long id=0l;
            String url="jdbc:mysql://localhost:3306/noduseclearance",user="root",pass="root";
            try{
                
                Class.forName("com.mysql.jdbc.Driver");
                c1= DriverManager.getConnection(url,user,pass);
                st =c1.createStatement();
                
                String sql="select count(prn) as id from students";
                ResultSet r = st.executeQuery(sql);
                
                if(r.next()){
                    if(r.getLong("id")==0){
                        id = 1l;
                    }else   
                        id = (r.getLong("id")+1);
                }
                c1.close();
            }catch(Exception e){
                out.print(e);
            }
        %>
        <div id="header">
            <div id="nav">
                <h1><%= session.getAttribute("department").toString().substring(0,1).toUpperCase()+session.getAttribute("department").toString().substring(1)%></h1>
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
                
                
                    <div id="registration-form">
                        <h2>Student Registration</h2>
                        <form action="RegisterStudent" method="POST">
                            <label for="department">Department:</label>
                            <select id="department" name="department" required="">
                                <option value="computer">Computer Science</option>
                                <option value="civil">Civil</option>
                                <!-- Add more options as needed -->
                            </select>

                            <label for="year">Year:</label>
                            <select id="year" name="year" required="">
                                <option value="First year">First Year</option>
                                <option value="Second year">Second Year</option>
                                <option value="Third year">Third Year</option>
                            </select>

                            <label for="name">Name:</label>
                            <input required="" type="text" id="name" name="name" onkeyup="this.value = this.value.replace(/[^A-Z a-z]/g, '')" >

                            <label for="prn">Student ID:</label>
                            <input required="" minlength="16" value="<%= id %>" maxlength="16" type="text" id="prn" onkeyup="this.value = this.value.replace(/[^0-9]/g, '')" readonly="true" name="prn">

                            <label for="contact">Contact:</label>
                            <input type="tel" minlength="10" maxlength="10" id="contact" name="contact" onkeyup="this.value = this.value.replace(/[^0-9]/g, '')" required>

                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required="">

                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address" required="">

                            <button type="submit">Register</button>
                        </form>
                    </div>
                
            </div>
        </div>

        <script >
            function alertNamefun() {
            var status = '<%= session.getAttribute("status")%>';
                if (status === "success") {
                    alert("Student Added");
                }
                if (status === "failed") {
                    alert("Failed to add Student");
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
