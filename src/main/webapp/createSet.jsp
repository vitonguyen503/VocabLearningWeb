<%--
  Created by IntelliJ IDEA.
  User: My MSI
  Date: 7/22/2023
  Time: 2:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>New Set</title>
  <style>
    body {
      font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    h1 {
      text-align: center;
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

    .title-container {
      display: flex;
      justify-content: center;
      margin-bottom: 10px;
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
      padding: 6px 12px; /* Adjust the padding */
      width: 25%; /* Set the width of the buttons */
    }

    .form-buttons button:first-child {
      margin-right: 5px;
      margin-left: 5px;
    }

    .form-buttons button:last-child {
      margin-left: 5px;
      margin-right: 5px;
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
      width: 100%; /* Set the width of the create button */
    }

    .create-button:hover {
      background-color: #45a049;
    }

  </style>
</head>
<body>
<h1>Create New Set</h1>
<form id="myForm" action="/VocabLearningWebsite/home/add?user=${username}" method="post">
  <div class="title-container">
    <input class="form-group" type="text" name="title" placeholder="Title" required>
  </div>
  <div id="fieldsContainer">
    <div class="form-group">
      <input type="text" name="terms[]" placeholder="Terms" data-index="0" required>
      <input type="text" name="definitions[]" placeholder="Definitions" data-index="0" required>
    </div>
  </div>

  <div class="form-buttons">
    <button type="button" onclick="addFields()">Add</button>
    <button type="button" onclick="deleteFields()">Remove</button>
  </div>
  <br>
  <input type="submit" class="create-button" value="Create">
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
