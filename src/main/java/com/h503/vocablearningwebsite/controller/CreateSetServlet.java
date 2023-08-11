package com.h503.vocablearningwebsite.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.Base64;

@WebServlet(name="createSet", value = "/home/add")
public class CreateSetServlet extends HttpServlet {
    private Connection connection = null;
    private Statement statement = null;
    private ResultSet resultSet = null;
    @Override
    public void init() throws ServletException {
        super.init();
        try{
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            String url = getServletContext().getInitParameter("databaseURL");
            String user = getServletContext().getInitParameter("user");
            String pass = getServletContext().getInitParameter("password");
            connection = DriverManager.getConnection(url, user, pass);
            statement = connection.createStatement();
            System.out.println("OK!");
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(check(req, resp)){
            String username = getDecodedUsername(req, resp);
            String title = req.getParameter("title");

            // Get the terms and definitions as arrays from the request
            StringBuilder content = new StringBuilder();
            String[] termsArray = req.getParameterValues("terms[]");
            String[] definitionsArray = req.getParameterValues("definitions[]");

            if (termsArray != null && definitionsArray != null) {
                for (int i = 0; i < termsArray.length; i++) {
                    content.append(termsArray[i] + "</>" + definitionsArray[i] + "\n");
                }
            }
            String insertQuery = "INSERT INTO sets (username, title, content) VALUES (?, ?, ?)";

            // Create a prepared statement for the query
            PreparedStatement preparedStatement = null;
            try {
                preparedStatement = connection.prepareStatement(insertQuery);
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, title);
                preparedStatement.setString(3, content.toString());
                preparedStatement.executeUpdate();
                resp.sendRedirect("http://localhost:8080/VocabLearningWebsite/home?user=" + req.getParameter("user"));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else
            goToIndexPage(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(check(req, resp)){
            req.setAttribute("username", req.getParameter("user"));
            getServletContext().getRequestDispatcher("/createSet.jsp").forward(req, resp);
        }
        else
           goToIndexPage(req, resp);
    }

    private boolean check(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String user = getDecodedUsername(request, response);
        String sql = "SELECT * FROM accounts WHERE username = ?";
        boolean validUser = false;
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            validUser = resultSet.next();
        } catch (Exception exception){
            exception.printStackTrace();
        }
        return validUser;
    }

    private String getDecodedUsername(HttpServletRequest request, HttpServletResponse response){
        String user = request.getParameter("user");
        if(user == null || user.length() < 2)
            return "";
        return new String(Base64.getDecoder().decode(user.getBytes()));
    }
    private void goToIndexPage(HttpServletRequest request, HttpServletResponse response) throws IOException{
        response.sendRedirect("http://localhost:8080/VocabLearningWebsite");
    }
}
