<%

User user = (User) session.getAttribute("current_user");
if (user == null) {
	session.setAttribute("message", "You are not logged in!! Login first then try");
	response.sendRedirect("login.jsp");
	return;
} 
%>





<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout Page</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
	<%@ include file="component/navbar.jsp"%>
	<div class="container" style="padding-top: 50px;">
		<div class="row mt-3">
			<div class="col-md-7">
				<div class="card">
					<div class="card-body">
						<h3 class="mb-3 text-center">Your selected Items</h3>
						<div class="cart-body"></div>
					</div>
				</div>


			</div>
			<div class="col-md-5">

				<div class="card">
					<div class="card-body">
						<h3 class="mb-3 text-center">Your details</h3>
						<form>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>

							<div class="form-group">
								<label for="name">Name</label> <input type="text"
									class="form-control" id="name" placeholder="Enter your name">
							</div>

							<div class="form-group">
								<label for="address">Your address</label>
								<textarea class="form-control" id="address" placeholder="Enter your address"
									rows="3"></textarea>
							</div>
							
							<div class="container text-center">
								<button class="btn btn-outline-success">Order Now</button>
								<button class="btn btn-outline-primary">Continue shopping </button>
							</div>


						</form>

					</div>
				</div>
			</div>

		</div>
	</div>

	</div>


	<%@ include file="component/common_modal.jsp"%>
</body>
</html>