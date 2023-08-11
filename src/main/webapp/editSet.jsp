<%@ page import="com.h503.vocablearningwebsite.model.Pair" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: My MSI
  Date: 7/23/2023
  Time: 11:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Set</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
        }

        h1 {
            margin-top: 30px;
            color: #333;
        }

        form {
            margin: 20px auto;
            max-width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
        }

        .form-group {
            display: flex;
            margin-bottom: 10px;
        }

        .form-group input[type="text"] {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            display: block;
            margin: 10px auto;
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Center the buttons */
        .form-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        /* Style the "+" and "-" buttons */
        .form-buttons button {
            flex: 1;
            padding: 6px 12px;
            width: 48%;
        }

        .form-buttons button:first-child {
            margin-right: 5px;
        }

        .form-buttons button:last-child {
            margin-left: 5px;
        }

        /* Style the create button */
        .create-button {
            display: inline-block;
            padding: 12px 24px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
            width: 100%;
        }

        .create-button:hover {
            background-color: #45a049;
        }

        /* Style the title input */
        .title-input {
            align-self: center;
            text-align: center;
            font-size: 20px;
        }

    </style>
</head>
<body>
<form id="myForm" action="/VocabLearningWebsite/edit?user=${username}&id=${id}" method="post">
    <h1>Edit Set</h1>
    <input class="title-input" type="text" value="${title}" name="title" placeholder="Title" required><br><br>
    <div id="fieldsContainer">
        <% List<Pair> content = (List<Pair>) request.getAttribute("content"); %>
        <% for (int i = 0; i < content.size(); i++) { %>
        <% Pair pair = content.get(i); %>
        <div class="form-group">
            <input type="text" name="terms[]" value="<%= pair.getTerm() %>" placeholder="Terms" data-index="<%= i %>" required>
            <input type="text" name="definitions[]" value="<%= pair.getDefinition() %>" placeholder="Definitions" data-index="<%= i %>" required>
        </div>
        <% } %>
    </div>

    <div class="form-buttons">
        <button type="button" onclick="addFields()">Add</button>
        <button type="button" onclick="deleteFields()">Remove</button>
    </div>
    <br>
    <input type="submit" class="create-button" value="Confirm">
</form>

<script>
    function addFields() {
        // Create a new div to hold the input fields
        var newDiv = document.createElement("div");
        newDiv.classList.add("form-group");
        var index = document.querySelectorAll(".form-group").length - 1;

        // Create the input fields and set their attributes
        var termsInput = document.createElement("input");
        termsInput.type = "text";
        termsInput.name = "terms[]";
        termsInput.placeholder = "Terms";
        termsInput.style.flex = "1";
        termsInput.style.padding = "8px";
        termsInput.style.border = "1px solid #ccc";
        termsInput.style.borderRadius = "5px";
        termsInput.required = true;
        termsInput.setAttribute("data-index", index);

        var definitionsInput = document.createElement("input");
        definitionsInput.type = "text";
        definitionsInput.name = "definitions[]";
        definitionsInput.placeholder = "Definitions";
        definitionsInput.style.flex = "1";
        definitionsInput.style.padding = "8px";
        definitionsInput.style.border = "1px solid #ccc";
        definitionsInput.style.borderRadius = "5px";
        definitionsInput.required = true;
        definitionsInput.setAttribute("data-index", index);

        // Append the input fields to the new div
        newDiv.appendChild(termsInput);
        newDiv.appendChild(definitionsInput);

        // Get the container where we want to add the new div
        var container = document.getElementById("fieldsContainer");

        // Append the new div with the input fields to the container
        container.appendChild(newDiv);
    }

    function deleteFields() {
        var container = document.getElementById("fieldsContainer");
        var divs = container.getElementsByClassName("form-group");

        // Ensure that there is at least one pair of fields to delete
        if (divs.length > 1) {
            // Remove the last div (rightmost fields)
            container.removeChild(divs[divs.length - 1]);
        }
    }
</script>
</body>
</html>
