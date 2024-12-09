<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Checkout Success</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<div class="card">
			<div class="card-body">
				<h1 class="text-center text-success">
					<i class="fas fa-check-circle"></i> Success
				</h1>
				<h3 class="text-center">Thank you for your purchase,
					${fullName}!</h3>
				<p class="text-center">Your order has been successfully
					processed.</p>
				<p class="text-center">We will contact you soon at ${phone}.</p>
				<br>
				<div class="text-center">
					<a href="UserControl?mode=getAllProducts" class="btn btn-primary">Back
						to Shop</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
