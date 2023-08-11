package com.h503.vocablearningwebsite.controller;

import com.h503.vocablearningwebsite.model.Sets;
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

@WebServlet(name = "home", value = "/home")
public class HomePageServlet extends HttpServlet {
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
        super.doPost(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String encoded = req.getParameter("user");
        if(encoded == null)
            goToIndexPage(req, resp);
        String user = new String(Base64.getDecoder().decode(encoded));
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

        if(!validUser)
            goToIndexPage(req, resp);
        else {
            List<Sets> content = getContent(user);
            req.setAttribute("user", user);
            req.setAttribute("encodedUser", encoded);
            req.setAttribute("content", content);
            getServletContext().getRequestDispatcher("/homePage.jsp").forward(req, resp);
        }
    }

    private void goToIndexPage(HttpServletRequest request, HttpServletResponse response) throws IOException{
        response.sendRedirect("http://localhost:8080/VocabLearningWebsite");
    }

    private List<Sets> getContent(String user){
        List<Sets> listSets = new LinkedList<>();
        String sql = "SELECT id, title FROM sets WHERE username = ?";
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                listSets.add(new Sets(id, title));
            }
        } catch (Exception exception){
            exception.printStackTrace();
        }
        return listSets;
    }
}
