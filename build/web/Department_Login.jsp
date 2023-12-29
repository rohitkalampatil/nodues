
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>No dues | Department Login  </title>
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

            .form-group select, .form-group input {
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
            <h2>Department Login</h2>
            <form class="login-form" action="Login" method="POST">
                <div class="form-group">
                    <label for="department">Department:</label>
                    <select id="department" name="department" required>
                        <option value="">Select Department</option>
                        <option value="computer">Computer Science</option>
                        <option value="civil">Civil</option>
                        <!-- Add more departments as needed -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <div class="toggle-btn" onclick="togglePasswordVisibility()">
                        <img src="eye-open.png" alt="Toggle Password Visibility" id="eye-icon">
                    </div>
                </div>
                <div class="form-group">
                    <span id="error" ><%= session.getAttribute("error") == null ? "" : session.getAttribute("error")%></span>

                </div>

                <div class="form-group">
                    <input type="submit" class="submit-button" value="Login"/>
                </div>
            </form>
        </div>


        <script >

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
