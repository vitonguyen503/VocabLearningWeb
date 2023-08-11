<%@ page import="com.h503.vocablearningwebsite.model.Pair" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: My MSI
  Date: 7/24/2023
  Time: 1:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quizlet Study</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
        }

        h1 {
            margin-top: 30px;
            color: #333;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
        }

        .question-container {
            margin-bottom: 20px;
        }

        .question {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .answer-input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 70%;
            font-size: 16px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .button-container button {
            margin: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.3);
            transition: background-color 0.3s ease;
        }

        .button-container button:hover {
            background-color: #45a049;
        }

        .definition {
            display: none;
            font-size: 18px;
            color: #555;
        }
    </style>
</head>
<body>
<h1>${title}</h1>
<form id="quizForm" action="javascript:void(0);" onsubmit="checkAnswer()">
    <div>
        <div class="question-container">
            <p class="question" id="question"></p>
            <p class="definition" id="definition">Correct Answer: <span id="correctAnswer"></span></p>
            <input type="text" placeholder="Your Answer" class="answer-input" id="userAnswer">
        </div>
        <div class="button-container">
            <button type="button" onclick="checkAnswer()">Check</button>
            <button type="button" onclick="goToPrevious()">Previous</button>
            <button type="button" onclick="goToNext()">Next</button>
            <button type="button" onclick="restartQuiz()">Restart</button>
            <button type="button" onclick="finishQuiz()">Finish</button>
        </div>
    </div>
</form>

<script>
    var termDefinitionPairs = ${termDefinitionPairsJson};
    var currentIndex = 0;

    function displayQuestion(index) {
        var currentPair = termDefinitionPairs[index];
        var term = currentPair.term;

        // Display the question (term) to the user
        document.getElementById("question").innerText = "Term: " + term;

        // Clear the previous user input
        document.getElementById("userAnswer").value = "";

        // Hide the definition from the previous question
        document.getElementById("definition").style.display = "none";
    }

    function checkAnswer() {
        var currentPair = termDefinitionPairs[currentIndex];
        var userAnswer = document.getElementById("userAnswer").value.toLowerCase().trim();
        var correctAnswer = currentPair.definition.toLowerCase().trim();

        // Check if the user's answer is correct
        if (userAnswer === correctAnswer) {
            alert("Correct!");
        } else {
            alert("Incorrect! The correct answer is: " + correctAnswer);
        }

        // Show the definition after checking the answer
        document.getElementById("definition").style.display = "block";
        goToNext();
    }

    function goToNext() {
        currentIndex++;
        if (currentIndex < termDefinitionPairs.length) {
            displayQuestion(currentIndex);
        } else {
            alert("You have completed the quiz!");
        }
    }

    function goToPrevious() {
        currentIndex--;
        if (currentIndex >= 0) {
            displayQuestion(currentIndex);
        } else {
            currentIndex = 0;
        }
    }

    function restartQuiz() {
        currentIndex = 0;
        displayQuestion(currentIndex);
    }

    function finishQuiz(){
        window.location.href = "http://localhost:8080/VocabLearningWebsite/home?user=${user}";
    }

    // Display the first question when the page loads
    displayQuestion(currentIndex);
</script>
</body>
</html>
