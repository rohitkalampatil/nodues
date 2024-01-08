

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Login</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #2c3e50;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }

            .login-container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            .login-container h2 {
                text-align: center;
                color: #2c3e50;
            }

            .login-form {
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 15px;
                position: relative;
                width: auto;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #2c3e50;
            }

            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-group button {
                width: 100%;
                padding: 10px;
                background-color: #2c3e50;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .submit-button {
                background-color: #2c3e50;
                color: #fff;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;

            }

            .submit-button:hover {
                background-color: #ggg;
            }
            #eye-icon {
                width: 25px;
                margin-top: 15px;
                margin-right: 12px;
                opacity: 60%;
            }
            #user{
                width: 20px;
                margin-top: 15px;
                margin-right: 12px;
                opacity: 60%;
            }
            #username{
                width: calc(100% - 30px); /* Adjusted width to accommodate the eye icon */
                padding: 10px;
                margin-bottom: 10px;
                width: 94%;
            }
            #password {
                width: calc(100% - 30px); /* Adjusted width to accommodate the eye icon */
                padding: 10px;
                margin-bottom: 10px;
            }

            .toggle-btn {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            
            <form class="login-form" action="Student_Login" method="POST">
                
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" maxlength="16" onkeyup="this.value = this.value.replace(/[^0-9]/g, '')" name="username" value="<%= session.getAttribute("prn") == null ? "" : session.getAttribute("prn")%>" required>
                    <div  class="toggle-btn" >
                        <img src="user.png" alt="user-icon" id="user" >
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" maxlength="8" id="password" name="password" required>
                    <div class="toggle-btn" onclick="togglePasswordVisibility()">
                        <img src="eye-open.png" alt="Toggle Password Visibility" id="eye-icon">
                    </div>
                </div>
                
                <div class="form-group">
                    <span id="error" ><%= session.getAttribute("error") == null ? "" : session.getAttribute("error")%></span>
                </div>
                
                <div class="form-group">
                    <input type="submit" value="Login" class="submit-button"/> 
                </div>

            </form>
        </div>


        <script>
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById('password');
                const eyeIcon = document.getElementById('eye-icon');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.src = 'eye-closed.png';
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.src = 'eye-open.png';
                }
            }
            function alertNamefun() {

                setTimeout(fundiss, 3000);
                function fundiss() {
                    document.getElementById("error").innerHTML = '<% session.setAttribute("error", "");%>';
                }

            }
        </script>
        <script>
            window.onload = alertNamefun;
        </script>
    </body>
</html>
