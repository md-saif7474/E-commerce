<%@page import="com.helper.Helper"%>
<%@page import="com.entities.Category"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyCart - Home</title>
<%@include file="component/common_css_js.jsp"%>

</head>
<body>

	<%@ include file="component/navbar.jsp"%>
	<div class="container-fluid" style="padding-top: 50px;">
		<div class="row mt-3 mx-2">

			<%
			String cat = request.getParameter("category");
			ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

			List<Product> list = null;
			if (cat == null || cat.trim().equals("all")) {
				list = pdao.getAllProducts();
			} else {
				int cid = Integer.parseInt(cat.trim());
				list = pdao.getAllProductsById(cid);
			}

			CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
			List<Category> clist = cdao.getCategories();
			%>


			<!-- show categories -->
			<div class="col-md-2">

				<div class="list-group mt-4">
					<a style="font-size: 16px; text-align: center;"
						href="index.jsp?category=all"
						class="list-group-item list-group-item-action active"> All
						Product </a>
					<%
					for (Category c : clist) {
					%>
					<a style="text-align: center;"
						href="index.jsp?category=<%=c.getCategoryId()%>"
						class="list-group-item list-group-item-action 
    <%if (cat != null && cat.equals(String.valueOf(c.getCategoryId()))) {
	out.print("custom-active"); // Add 'custom-active' class for the active link
}%>">
						<%=c.getCategoryTitle()%>
					</a>
					<%
					}
					%>
				</div>

			</div>

			<!-- show products -->
			<div class="col-md-10">
				<div class="row mt-4">
					<div class="col-md-12">
						<div class="card-columns">
							<%
							for (Product p : list) {
							%>

							<div class="card product-card">

								<div class="container text-center">
									<img class="card-img-top m-2"
										src="img/product/<%=p.getpPhoto()%>"
										style="max-height: 200px; max-width: 100%; width: auto;"
										alt="Card image cap">
								</div>
								<div class="card-body">
									<h5 class="card-title"><%=p.getpName()%></h5>
									<p><%=Helper.get10Words(p.getpDescription())%></p>
								</div>
								<div class="card-footer text-center">
									<button class="btn custom-bg text-white" onclick="add_to_cart(<%=p.getpId() %>,'<%=p.getpName() %>',<%=p.getPriceAfterDiscount() %>)" >Add to cart</button>
									<button class="btn btn-outline-success">
										&#8377;<%=p.getPriceAfterDiscount()%>/- <span class="text-secondary discount-label-price">&#8377;<%=p.getpPrice() %></span> <span class="text-secondary discount-label">   <%=p.getpDiscount() %> %off</span></button>
								</div>
							</div>


							<%
							}
							if (list.size() == 0) {
								out.println("<h5>No item in this category</h5>");
								}
							%>

						</div>

					</div>
				</div>




			</div>


		</div>
		</div>
		
		<%@ include file="component/common_modal.jsp" %>
</body>
</html>