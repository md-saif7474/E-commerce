<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
    <%@ include file="component/navbar.jsp"%>
    <div class="container" style="padding-top: 50px;">

        <div class="row">
            <div class="col-md-6 offset-md-3">
                <!-- Added the 'shadow' class here for a shadow effect -->
                <div class="card mt-3 shadow">
                    <div class="card-header custom-bg text-white">
                        <h3 class="text-center">Login</h3>
                    </div>
                    <div class="card-body ">
                    	<%@include file="component/message.jsp" %>
                    	
                    	
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="email" class="font-weight-bold" >Email address</label> 
                                <input name="email" type="email" class="form-control" id="exampleInputEmail1"
                                    aria-describedby="emailHelp" placeholder="Enter email">
                                <small id="emailHelp" class="form-text text-muted">We'll
                                    never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="password" class="font-weight-bold">Password</label> 
                                <input name="password" type="password" class="form-control" id="password"
                                    placeholder="Password">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary">Submit</button>
                                <button type="reset" class="btn btn-primary">Reset</button>
                            </div>
                            <a href="register.jsp" class="text-center d-block mt-2">If you are not registered yet, click here</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
