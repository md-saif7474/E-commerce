package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.UserDao;
import com.entities.User;
import com.helper.FactoryProvider;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
    	response.setContentType("text/html");
    	
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Fetch user by email and password (you'll need to implement encryption handling)
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(email, password);
            HttpSession httpSession = request.getSession();
            if(user==null)
            {
            	httpSession.setAttribute("message", "Invalid credential");
            	response.sendRedirect("login.jsp");
            	return;
            }
            else
            {
            	httpSession.setAttribute("current_user", user);
            	
            	if(user.getUserType().equals("admin"))
            	{
            		response.sendRedirect("admin.jsp");
            	}
            	else if(user.getUserType().equals("normal"))
            	{
            		response.sendRedirect("normal.jsp");
            	}
            	else
            	{
            		out.println("We have not identified user type");
            	}
            	
            }
            
            // Additional logic for checking user authentication can be implemented here.
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
