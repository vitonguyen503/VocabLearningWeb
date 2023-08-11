<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
    <style>
        body {
            background-image: url('https://i.pinimg.com/736x/46/51/4a/46514a91ebe599944d246f4337e2bb7c.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            background-color: #f1f1f1;
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

        .container .content {
            background-color: #fff;
            border: 2px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            max-width: 400px;
            width: 100%;
        }

        .container h1 {
            align-self: center;
            margin-bottom: 20px;
            color: #060606;
        }

        .input-field {
            margin-bottom: 10px;
        }

        .input-field input[type="text"],
        .input-field input[type="password"] {
            width: 300px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background-color: #fff;
        }

        .create-button {
            padding: 12px 24px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .create-button:hover {
            background-color: #45a049;
        }

        .return-button {
            margin-top: 10px;
            text-decoration: none;
            color: #4c56af;
            cursor: pointer;
            font-size: 14px;
        }

        .return-button:hover {
            color: #5a659d;
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
    <div class="content">
        <h1>Create New Account</h1>
        <div class="error-message">${error}</div>
        <div class="success-message">${message}</div>
        <form method="post" action="/VocabLearningWebsite/registration">
            <div class="input-field">
                <input type="text" id="username" name="username" placeholder="Username" required>
            </div>
            <div class="input-field">
                <input type="password" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="input-field">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
            </div>
            <br>
            <button type="submit" class="create-button">Create</button>
        </form>

    </div>
    <a style="padding-top: 10px" href="login.jsp" class="return-button">Return to Login Page</a>
</div>
</body>
</html>
