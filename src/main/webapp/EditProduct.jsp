<%-- 
    Document   : Edit
    Created on : Jan 9, 2024, 4:50:02 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous" />

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	<div class="container">
		<!-- edit form column -->
		<div class="col-lg-12 text-lg-center">
			<br>
			<h2>Edit Information</h2>
		</div>
		<div class="col-lg-8 push-lg-4 personal-info">
			<c:set var="l" value="${p}" />
			<form role="form" action="AdminControl?mode=editProduct"
				method="post" style="margin-left: 200px; width: 600px" enctype="multipart/form-data">
				<input type="text" id="productId" name="productId"
					value="${l.getProductId()}" hidden="true" />
				<div class="form-group">
					<label for="productName">Name</label> <input class="form-control"
						type="text" id="productName" value="${l.getProductName()}"
						name="productName" />
				</div>

				<div class="form-group">
					<label for="productQuantity">Quantity</label> <input type="number"
						class="form-control" id="productQuantity" name="productQuantity"
						value="${l.getQuantity()}" min="0" required /> <small
						id="quantityCheck" class="form-text text-muted"
						style="display: none">Quantity only contains numbers</small>
				</div>

				<div class="form-group">
					<label for="productPrice">Price</label> <input type="number"
						class="form-control" id="productPrice" name="productPrice"
						value="${l.getPrice()}" min="0" required /> <small
						id="priceCheck" class="form-text text-muted" style="display: none">Price
						only contains numbers</small>
				</div>
				<div class="form-group">

					<label>Type:</label> <select name="type" required>
						<option value="Men" ${p.type == 'Men' ? 'selected' : ''}>Men</option>
						<option value="Women" ${p.type == 'Women' ? 'selected' : ''}>Women</option>
					</select>
				</div>

				<div class="form-group">

					<label>Category:</label> <select name="category" required>
						<option value="Shirt" ${p.category == 'Shirt' ? 'selected' : ''}>Shirt</option>
						<option value="Jacket" ${p.category == 'Jacket' ? 'selected' : ''}>Jacket</option>
						<option value="Perfume"
							${p.category == 'Perfume' ? 'selected' : ''}>Perfume</option>
					</select>
				</div>
				<%-- <div class="form-group">
					<label>Current Image:</label> <img src="${p.getImageUrl()}"
						alt="Product Image" width="100">
				</div> --%>
				<div class="form-group">
					<label>Upload New Image:</label> <input type="file" name="image">
				</div>
				<div class="form-group">
					<label for="productPosition">Location</label> <input type="text"
						class="form-control" id="productPosition" name="productPosition"
						value="${l.getPosition()}" required /> <small id="nameCheck"
						class="form-text text-muted" style="display: none">Location
						can not be empty</small>
				</div>
				<div class="form-group row">
					<div class="col-lg-9 offset-lg-3">
						<a href="AdminControl?mode=adminHome" class="btn btn-dark">Cancel</a>
						<button type="submit" class="btn btn-primary">Edit</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
