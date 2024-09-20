<%@page import="com.helper.Helper"%>
<%@page import="com.entities.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.entities.Category"%>
<%@page import="com.helper.FactoryProvider"%>
<%@page import="com.entities.User"%>
<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	session.setAttribute("message", "You are not logged in!! Login first then try");
	response.sendRedirect("login.jsp");
	return;
} else {
	if (user.getUserType().equals("normal")) {
		session.setAttribute("message", "You are not admin! Do not access this page");
		response.sendRedirect("login.jsp");
		return;
	}
}

ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
List<Product> plist = pdao.getAllProducts();

CategoryDao catdao = new CategoryDao(FactoryProvider.getFactory());
List<Category> clist = catdao.getCategories();

Long cnt = Helper.getCountUser(FactoryProvider.getFactory());

%>




<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
	<%@include file="component/navbar.jsp"%>

	<div class="container admin" style="padding-top: 50px;">

		<div class="fluid-container mt-3">
			<%@include file="component/message.jsp"%>
		</div>
		<div class="row mt-4">
			<div class="col-md-4 ">

				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid" alt="user_icon"
								src="img/team.png">
						</div>
						<h1><%=cnt %></h1>
						<h1>Users</h1>
					</div>

				</div>

			</div>

			<div class="col-md-4">
				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid" alt="user_icon"
								src="img/categories.png">
						</div>
						<h1><%=clist.size() %></h1>
						<h1>Categories</h1>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid" alt="user_icon"
								src="img/box.png">
						</div>
						<h1><%=plist.size() %></h1>
						<h1>Products</h1>
					</div>
				</div>
			</div>
		</div>

		<div class="row mt-3 mb-3">
			<div class="col-md-6 text-center">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid" alt="user_icon"
								src="img/category (1).png">
						</div>
						<p class="mt-2">Click here to add new category</p>
						<h1>Add category</h1>
					</div>

				</div>
			</div>

			<div class="col-md-6 text-center">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid" alt="user_icon"
								src="img/plus.png">
						</div>
						<p class="mt-2">Click here to add new product</p>
						<h1>Add product</h1>
					</div>

				</div>
			</div>


		</div>

	</div>

	<!--add category modal  -->


	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Category
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post">
						<input type="hidden" name="operation" value="addcategory" />
						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="Enter category title" required />
						</div>

						<div class="form-group">
							<textarea style="height: 100px" class="form-control"
								placeholder="Enter category description" name="catDescription"
								required></textarea>
						</div>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>

						</div>


					</form>
				</div>
			</div>
		</div>
	</div>

	<!--end add category modal  -->



	<!--add product modal  -->


	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Product
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
					<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
						<input type="hidden" name="operation" value="addproduct" />
						
						<!--Product title  -->
						<div class="form-group">
							<input type="text" class="form-control" name="pName"
								placeholder="Enter product title" required />
						</div>

						<!--Product description  -->

						<div class="form-group">
							<textarea style="height: 100px" class="form-control"
								placeholder="Enter product description" name="pDescription"
								required></textarea>
						</div>

						<!--Product price  -->
						<div class="form-group">
							<input type="number" class="form-control" name="pPrice"
								placeholder="Enter product price" required />
						</div>

						<!-- Product discount -->
						<div class="form-group">
							<input type="number" class="form-control" name="pDiscount"
								placeholder="Enter product discount" required />
						</div>

						<!-- Product quantity -->
						<div class="form-group">
							<input type="number" class="form-control" name="pQuantity"
								placeholder="Enter product quantity" required />
						</div>

						<!-- Product category -->

						<%
						CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
						List<Category> list = cdao.getCategories();
						// Set the list as a request attribute
						%>

						<div class="form-group">
							<select name="catId" id="" class="form-control">
								<%
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>">
									<%=c.getCategoryTitle()%>
								</option>
								<%
								}
								%>
							</select>
						</div>


						<!-- Product file -->
						<div class="form-group">
							<label style="font-weight: bold;" for="pId">Upload image
								of the product</label> <br> <input type="file" name="pPic" id="pId"
								required />
						</div>
						
						<!-- Button -->

						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>

						</div>


					</form>
				</div>
			</div>
		</div>
	</div>

	<!--end add product modal  -->

	<%@ include file="component/common_modal.jsp"%>

</body>
</html>









