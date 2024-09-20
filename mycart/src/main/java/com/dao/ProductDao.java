package com.dao;

import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.entities.Product;

public class ProductDao {
	private SessionFactory factory;

	public ProductDao(SessionFactory factory)
	{
		this.factory=factory;
	}
	
	public boolean saveProduct(Product product)
	{
		Boolean f = false;
		try
		{
			Session s = this.factory.openSession();
			Transaction tx = s.beginTransaction();
			
			s.save(product);
			f = true;
			tx.commit();
			s.close();
		}catch (Exception e) {
			e.printStackTrace();
			f = false;
		}
		return f;
	}
	
	public List<Product> getAllProducts()
	{
		Session s = this.factory.openSession();
		Query q = s.createQuery("from Product");
		List<Product> list = q.list();
		s.close();
		return list;
	}
	
//	getting product by category id
	public List<Product> getAllProductsById(int cid)
	{
		Session s = this.factory.openSession();
		Query q = s.createQuery("from Product as p where p.category.categoryId=:id");
		q.setParameter("id", cid);
		List<Product> list = q.list();
		s.close();
		return list;
	}
}
