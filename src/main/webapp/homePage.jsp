<%@ page import="com.h503.vocablearningwebsite.model.Sets" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #f2f2f2;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .logout-button {
            background-color: #ff3333;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .hello-text {
            font-size: 15px;
            margin-top: 10px;
            margin-right: 20px;
        }

        h1 {
            margin-top: 30px;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 60%;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }

        th {
            background-color: #f2f2f2;
        }

        .add-button {
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 10px;
            text-align: center;
            font-size: 5px;
            text-decoration: none;
            cursor: pointer;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
        }

        .add-icon {
            font-size: 15px;
            margin-right: 5px;
        }

        .operation-links {
            display: flex;
            justify-content: center;
        }

        .operation-links a {
            text-decoration: none;
            margin-right: 10px;
            background-color: #6078e0;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .study-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Add more CSS styles as needed */

    </style>
</head>
<body>
<header>
    <div class="logo">Vocabulary Learning Website</div>
    <div>
        <span class="hello-text">Hello, ${user}</span>
        <a href="/VocabLearningWebsite/login.jsp">
            <button class="logout-button">Log Out</button>
        </a>
    </div>
</header>

<h1>Your Sets</h1>

<div>
    <a href="home/add?user=${encodedUser}" class="add-button">
        <span class="add-icon">Add new set</span>
    </a>
</div>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Operations</th>
    </tr>
    </thead>
    <tbody>
    <%List<Sets> content = (List<Sets>) request.getAttribute("content");%>
    <% for (Sets set : content) { %>
    <tr>
        <td><%= set.getId() %></td>
        <td><%= set.getTitle() %></td>
        <td class="operation-links">
            <a href="edit?user=${encodedUser}&id=<%= set.getId() %>" class="study-button">Edit</a>
            <a href="delete?user=${encodedUser}&id=<%= set.getId() %>" class="study-button">Delete</a>
            <a href="study?user=${encodedUser}&id=<%= set.getId() %>" class="study-button">Study</a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
</body>
</html>
