package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;
import org.hibernate.Session;
import org.hibernate.Transaction;


import com.entities.User;
import com.helper.FactoryProvider;

public class RegisterSevlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        try {
            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userPhone = request.getParameter("user_phone");
            String userAddress = request.getParameter("user_address");  
            
            Session s = FactoryProvider.getFactory().openSession();
            Transaction tx = s.beginTransaction();
            
            Query query = s.createQuery("from User where user_email = :email");
            query.setParameter("email", userEmail);
            User existingUser = (User) query.uniqueResult();

            if (existingUser != null) {
                // Email already exists
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Email ID already registered. Please use a different email.");
                response.sendRedirect("register.jsp");
                s.close();
                return;
            }
            
         // Encrypt the password using BCrypt
            String hashedPassword = BCrypt.hashpw(userPassword, BCrypt.gensalt());

            // Create new user object with encrypted password
            User user = new User(userName, userPhone, userEmail, hashedPassword, "default.jpg", userAddress, "normal");
            
            int userId = (int) s.save(user);
            
            tx.commit();
            s.close();
            
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("message", "Registration successful !!" + userId);
            response.sendRedirect("register.jsp");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("message", "An error occurred during registration: " + e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}
