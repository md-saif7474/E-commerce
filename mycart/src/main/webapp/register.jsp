<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New user</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>

	<%@ include file="component/navbar.jsp"%>

	<div class="container-fluid" style="padding-top: 50px;">
		<div class="row mt-3">

			<div class="col-md-4 offset-md-4">

				<div class="card shadow-lg bg-light">
						<%@include file="component/message.jsp" %>
					<div class="card-body px-5">
						<div class="container text-center mt-auto">
							<img style="max-width: 50px;" alt="" src="img/signup_5822138.png">
						</div>

						<h3 class="text-center my-2">Sign up here!!</h3>

						<form action="RegisterSevlet" method="post">

							<div class="form-group">
								<label for="name">User Name</label> <input name="user_name" type="text"
									class="form-control" id="name" placeholder="Enter here" required>
							</div>

							<div class="form-group">
								<label for="email">Email</label> <input name="user_email" type="email"
									class="form-control" id="email" placeholder="Enter here" required>
							</div>

							<div class="form-group">
								<label for="password">Password</label> <input name="user_password" type="password"
									class="form-control" id="password" placeholder="Enter here" required>
							</div>

							<div class="form-group">
								<label for="phone">Phone Number</label> <input name="user_phone" type="number"
									class="form-control" id="phone" placeholder="Enter here" required>
							</div>

							<div class="form-group">
								<label for="address">Address</label>
								<textarea name="user_address" class="form-control" placeholder="Enter your address" required></textarea>
							</div>

							<div class="container text-center">
								<button class="btn btn-outline-success">Register</button>
								<button class="btn btn-outline-warning">Reset</button>

							</div>


						</form>

					</div>
				</div>

			</div>

		</div>

	</div>



</body>
</html>