<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vocabulary Learning Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://img.freepik.com/free-vector/hand-drawn-minimal-background_23-2149001650.jpg?w=2000');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .header {
            font-size: 32px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin-bottom: 20px;
            color: #353737;
        }

        .login-button {
            padding: 12px 24px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .login-button:hover {
            background-color: #45a049;
        }

        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #dedbe375;
            color: black;
            padding: 10px 0;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">Welcome to Vocabulary Learning Website</h1>
    <p style="font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 25px;">PLEASE <a href="login.jsp" class="login-button">LOGIN</a> TO CONTINUE</p>
</div>
<div class="footer">
    &copy; 2023 Vocabulary Learning Website. All rights reserved.
</div>
</body>
</html>
