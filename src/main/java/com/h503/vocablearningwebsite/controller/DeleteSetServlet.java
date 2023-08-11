package com.h503.vocablearningwebsite.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.Base64;

@WebServlet(name = "deleteSet", value = "/delete")
public class DeleteSetServlet extends HttpServlet {
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

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(check(req, resp)){
            String username = getDecodedUsername(req, resp);
            int id = Integer.parseInt(req.getParameter("id"));
            System.out.println(username + " " + id);

            String deleteQuery = "DELETE FROM sets WHERE id = ? AND username = ?";

            // Create a prepared statement for the query
            PreparedStatement preparedStatement = null;
            try {
                preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setString(2, username);
                preparedStatement.setInt(1, id);
                preparedStatement.executeUpdate();
                resp.sendRedirect("http://localhost:8080/VocabLearningWebsite/home?user=" + req.getParameter("user"));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else
            goToIndexPage(req, resp);
    }

    private boolean check(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        if(id == null) return false;
        String user = getDecodedUsername(request, response);
        String sql = "SELECT * FROM sets WHERE username = ? AND id = ?";
        boolean validUser = false;
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            preparedStatement.setInt(2, Integer.parseInt(id));
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
