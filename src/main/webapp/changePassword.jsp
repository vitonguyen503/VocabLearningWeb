<%--
  Created by IntelliJ IDEA.
  User: My MSI
  Date: 7/21/2023
  Time: 12:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://i.pinimg.com/736x/46/51/4a/46514a91ebe599944d246f4337e2bb7c.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            text-align: center;
            margin: 20px;
            background-color: #f1f1f1;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            border: 1px solid #ccc;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            display: inline-block;
            text-align: left;
            padding: 20px;
            border-radius: 5px;
            background-color: #fff;
            min-width: 300px;
        }

        h1 {
            align-self: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            max-width: 280px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            margin-bottom: 10px;
        }

        .success-message {
            color: #4CAF50;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <form class="form-container" method="post" action="/VocabLearningWebsite/changePassword">
        <h1>Change Password</h1>
        <div class="error-message">${error}</div>
        <div class="success-message">${message}</div>

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="oldPassword">Old Password:</label>
        <input type="password" id="oldPassword" name="oldPassword" required>

        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required>

        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <div style="text-align: center;">
            <input type="submit" value="Save">

        </div>
    </form>
    <a style="text-align: center; margin-top: 10px" href="login.jsp">Return to Login Page</a>
</div>
</body>
</html>
