package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.entities.Category;

public class CategoryDao {
	private SessionFactory factory;
	
	public CategoryDao(SessionFactory factory)
	{
		this.factory=factory;
	}
	
	public int saveCategory(Category cat)
	{
		Session s = this.factory.openSession();
		Transaction tx = s.beginTransaction();
		
		int catId =(int) s.save(cat);
		
		tx.commit();
		s.close();
		return catId;
	}
	
	public List<Category> getCategories()
	{
		Session session = null;
	    List<Category> list = null;
	    try {
	        session = this.factory.openSession();
	        Query<Category> query = session.createQuery("from Category", Category.class); // Specify the Category class
	        list = query.list();  // No casting required since generics are used
	    } catch (Exception e) {
	        e.printStackTrace();  // Handle exceptions properly in a real-world application
	    } finally {
	        if (session != null) {
	            session.close();  // Always close the session in the finally block
	        }
	    }
	    return list;
	}
	
	public Category getCategoryById(int catId)
	{
		
		Category cat = null;
	    try {
	        Session s = this.factory.openSession();
	        cat = s.get(Category.class, catId); // Hibernate returns null if no entity is found
	        s.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    if (cat == null) {
	        System.out.println("No category found with id: " + catId);
	        return null;
	    } else {
	        System.out.println("Category found: " + cat.getCategoryId());
	        return cat;
	    }
	}
	
}
