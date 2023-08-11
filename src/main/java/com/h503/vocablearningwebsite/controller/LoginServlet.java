package com.h503.vocablearningwebsite.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.*;
import java.util.Base64;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
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
        String username = req.getParameter("username").trim();
        String password = req.getParameter("password").trim();
        boolean validUser = false;
        try{
            String sql = "SELECT * FROM accounts WHERE username = ? AND password = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            resultSet = preparedStatement.executeQuery();
            validUser = resultSet.next();
        } catch (SQLException ex){
            req.setAttribute("error", "Can't connect to database!");
            doGet(req, resp);
        }
        if(!validUser){
            req.setAttribute("error", "Wrong username or password!");
            doGet(req, resp);
        }else{
            // URL of the second servlet (receiver) with data as query parameters
            String receiverServletURL = "http://localhost:8080/VocabLearningWebsite/home";
            String queryString = "user=" + Base64.getEncoder().encodeToString(username.getBytes());
            String completeURL = receiverServletURL + "?" + queryString;

            // Create the HTTP GET request
            URL url = new URL(completeURL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.disconnect();
            resp.sendRedirect(completeURL);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
