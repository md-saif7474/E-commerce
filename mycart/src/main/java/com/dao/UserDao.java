package com.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;

import com.entities.User;

import jakarta.servlet.http.HttpSession;

public class UserDao {
	private SessionFactory factory;
	
	public UserDao(SessionFactory factory)
	{
		this.factory = factory;
	}
	
	public User getUserByEmailAndPassword(String email, String password)
	{
		
		
		try {
			String query = "from User where userEmail =: e";
			Session s = this.factory.openSession();
			Query q = s.createQuery(query);
			q.setParameter("e",email);
			User user = (User) q.uniqueResult();
			s.close();
			if (user != null) {
				System.out.println("User found: " + user.getUserEmail());
		        // Get the hashed password from the database
		        String hashedPasswordFromDB = user.getUserPassword(); 

		        // Compare the provided password with the hashed password in the database
		        if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
		        	System.out.println("Password match");
		            return user;
		        } 
		    } 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}

}
