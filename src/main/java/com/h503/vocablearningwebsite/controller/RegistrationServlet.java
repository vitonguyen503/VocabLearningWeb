package com.h503.vocablearningwebsite.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;


@WebServlet(name = "registrationServlet", value = "/registration")
public class RegistrationServlet extends HttpServlet {
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
        String confirm = req.getParameter("confirmPassword").trim();

        if(!password.equals(confirm)){
            req.setAttribute("error", "Password doesn't match!");
            doGet(req, resp);
        }else {
            String sql = "select password from accounts where username = '" + username + "'";
            String tmpPassword = null;
            try {
                resultSet = statement.executeQuery(sql);
                while (resultSet.next()){
                    tmpPassword = resultSet.getString("password");
                }
            } catch (SQLException ex){
                req.setAttribute("error", "Can't connect to server!");
                doGet(req, resp);
            }
            if(tmpPassword != null){
                req.setAttribute("error", "Username has already existed!");
                doGet(req, resp);
            }else {
                try{
                    sql = "INSERT INTO accounts (username, password) VALUES (?, ?)";
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, username);
                    preparedStatement.setString(2, password);

                    int rowsInserted = preparedStatement.executeUpdate();

                    if (rowsInserted > 0) {
                        req.setAttribute("message", "Account created successfully!");
                        doGet(req, resp);
                    } else {
                        req.setAttribute("message", "Failed to create the account.");
                        System.out.println("Failed to create the account.");
                    }
                } catch (SQLException ex){
                    req.setAttribute("error", "Can't connect to server!");
                    doGet(req, resp);
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/createAccount.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        super.destroy();
        try {
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
