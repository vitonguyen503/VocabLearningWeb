<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;;
            background-color: #f1f1f1;
            background-image: url('https://img.freepik.com/free-vector/hand-drawn-minimal-background_23-2149001650.jpg?w=2000');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 300px;
            margin: 100px auto;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
            padding: 20px;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .container .form-group {
            margin-bottom: 20px;
        }

        .container .form-group label {
            display: block;
            font-size: 16px;
            font-weight: bold;
        }

        .container .form-group input[type="text"],
        .container .form-group input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            max-width: 280px;
        }

        .container .form-group .btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #3da162;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .container .form-group .btn:hover {
            background-color: #80a57b;
        }

        .container .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .container .action-buttons {
            text-align: center;
            margin-top: 10px;
        }

        .container .action-buttons a {
            margin-right: 10px;
            color: #4CAF50;
            text-decoration: none;
            font-size: 14px;
        }

        .container .action-buttons a:hover {
            color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form method="post" action="/VocabLearningWebsite/login">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" class="btn" value="Login">
        </div>
    </form>
    <%-- Display error message if exists --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <div class="action-buttons">
        <a href="createAccount.jsp">Create New Account</a>
        <a href="changePassword.jsp">Change Password</a>
    </div>
</div>
</body>
</html>
