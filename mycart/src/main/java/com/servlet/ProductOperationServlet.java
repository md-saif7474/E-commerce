package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import com.dao.CategoryDao;
import com.dao.ProductDao;
import com.entities.Category;
import com.entities.Product;
import com.helper.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
    	response.setContentType("text/html");
		// firstly i will check which operation it is..
		try {
			String op = request.getParameter("operation");
			if(op.trim().equals("addcategory"))
			{
				String title = request.getParameter("catTitle");
				String description= request.getParameter("catDescription");
				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);
				
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				int catId = categoryDao.saveCategory(category);
				HttpSession httpsession = request.getSession();
				httpsession.setAttribute("message", "Category added successfully");
				response.sendRedirect("admin.jsp");
				return;
			}
			else if(op.trim().equals("addproduct"))
			{
				// add product
				
				String pName = request.getParameter("pName");
				String pDesc= request.getParameter("pDescription");
				
				
				
				 int pPrice = 0, pDiscount = 0, pQuantity = 0, catId = 0;
			    try {
			        pPrice = Integer.parseInt(request.getParameter("pPrice"));
			        pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
			        pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
			        catId = Integer.parseInt(request.getParameter("catId"));
			    } catch (NumberFormatException e) {
			        e.printStackTrace();
			        // Handle parsing error, maybe set default values or show an error message
			    }
			    System.out.println(catId);
			    Part part = request.getPart("pPic");
			    
			    Product p = new Product();
				p.setpName(pName);
				p.setpDescription(pDesc);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPrice(pPrice);
				p.setpPhoto(part.getSubmittedFileName());
				
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);
				p.setCategory(category);
				
				// Save product
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				pdao.saveProduct(p);
				
//				find out the path to upload the photo
				
				String path = getServletContext().getRealPath("img")+File.separator+"product"+File.separator+part.getSubmittedFileName();
				System.out.println(path);
				
//				uploading code
				try
				{
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();
					
					byte[] data = new byte[is.available()];
					is.read(data);
					
//					writing the data
					
					fos.write(data);
					fos.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
				HttpSession httpsession = request.getSession();
				httpsession.setAttribute("message", "Product is added succsessfully!!");
				response.sendRedirect("admin.jsp");
				return;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

}
