package com.h503.vocablearningwebsite.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet(name="changePassServlet", value = "/changePassword")
public class ChangePassServlet extends HttpServlet {
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
        String oldPass = req.getParameter("oldPassword").trim();
        String newPass = req.getParameter("newPassword").trim();
        String confirm = req.getParameter("confirmPassword").trim();

        if(!newPass.equals(confirm)) {
            req.setAttribute("error", "New password doesn't match!");
            doGet(req, resp);
        }else {
            String sql = "SELECT password FROM accounts WHERE username = '" + username + "';";
            String actualPass = "";
            try {
                resultSet = statement.executeQuery(sql);
                while (resultSet.next()){
                    actualPass = resultSet.getString("password");
                }
            } catch (SQLException ex){
                req.setAttribute("error", "Can't connect to server!");
                doGet(req, resp);
            }
            if(!actualPass.equals(oldPass)){
                req.setAttribute("error", "Wrong username or password!");
                doGet(req, resp);
            }else {
                sql = "update accounts set password = '" + newPass + "' where username = '" + username + "';";
                try {
                    statement.executeUpdate(sql);
                } catch (SQLException e) {
                    req.setAttribute("error", "Can't connect to server!");
                    doGet(req, resp);
                }
                req.setAttribute("message", "Update successfully!");
                doGet(req, resp);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/changePassword.jsp").forward(req, resp);
    }
}
