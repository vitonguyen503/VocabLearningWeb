package com.h503.vocablearningwebsite.controller;

import com.h503.vocablearningwebsite.model.Pair;
import com.mysql.cj.conf.ConnectionUrlParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;

@WebServlet(name = "editSet", value = "/edit")
public class EditSetServlet extends HttpServlet {
    private Connection connection = null;
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
            System.out.println("OK!");
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(check(req, resp)){
            String title = req.getParameter("title");
            int id = Integer.parseInt(req.getParameter("id"));
            // Get the terms and definitions as arrays from the request
            StringBuilder content = new StringBuilder();
            String[] termsArray = req.getParameterValues("terms[]");
            String[] definitionsArray = req.getParameterValues("definitions[]");

            if (termsArray != null && definitionsArray != null) {
                for (int i = 0; i < termsArray.length; i++) {
                    content.append(termsArray[i] + "</>" + definitionsArray[i] + "\n");
                }
            }
            String sqlQuery = "UPDATE sets SET title = ?, content = ? WHERE id = ?";
            PreparedStatement preparedStatement = null;
            try {
                preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, title);
                preparedStatement.setString(2, content.toString());
                preparedStatement.setInt(3, id);
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
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                List<Pair> content = getContent(id);
                String title = getTitle(id);
                req.setAttribute("title", title);
                req.setAttribute("id", id);
                req.setAttribute("username", req.getParameter("user"));
                req.setAttribute("content", content);
                getServletContext().getRequestDispatcher("/editSet.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        else
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
    private List<Pair> getContent(int id) throws SQLException {
        String selectQuery = "SELECT content FROM sets WHERE id = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
        preparedStatement.setInt(1, id);
        resultSet = preparedStatement.executeQuery();

        List<Pair> res = new LinkedList<>();
        if (resultSet.next()) {
            // Get the content from the result set
            String content = resultSet.getString("content");
            String[] lines = content.split("\n");
            for(String line : lines){
                String[] pair = line.split("</>");
                res.add(new Pair(pair[0], pair[1]));
            }
        }
        preparedStatement.close();
        return res;
    }
    private String getTitle(int id) throws SQLException {
        String selectQuery = "SELECT title FROM sets WHERE id = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
        preparedStatement.setInt(1, id);
        resultSet = preparedStatement.executeQuery();

        String res = "";
        if(resultSet.next()){
            res = resultSet.getString("title");
        }
        return res;
    }
}
