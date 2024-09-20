package com.helper;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class Helper {
	
	public static String get10Words(String desc)
	{
		String[] split = desc.split(" ");
		if(split.length>10)
		{
			String res="";
			
			for(int i=0;i<10;i++)
			{
				res += split[i]+" ";
			}
			return (res+"...");
		}
		else 
		{
			return (desc+"....");
		}
	}
	
	public static Long getCountUser(SessionFactory factory)
	{
		Session s = factory.openSession();
		Query q = s.createQuery("Select count(*) from User");
		Long count = (Long) q.list().get(0);
		return count;
	}
	
}
