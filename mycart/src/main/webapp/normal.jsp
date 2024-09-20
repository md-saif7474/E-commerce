<%@page import="com.entities.User"%>
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
<title>Normal Page</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<h1>This is normal page</h1>
</body>
</html>