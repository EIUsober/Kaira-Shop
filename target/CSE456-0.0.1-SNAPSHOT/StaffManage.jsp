<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="css/main.css" />
<link rel="icon" href="./images/logo-title.png" />
<title>Grocery Store Management</title>
</head>
<body>
	<p class="${editMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${editMessage}</p>
	<p class="${addMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${addMessage}</p>
	<p class="${deleteMessage==null ? " ": "alert-danger
		alert" }" style="size: 30px">${deleteMessage}</p>
	<main>
		<div id="results"></div>
		<div class="row">
			<div class="col-2 col-lg-2 sidebar">
				<div class="list-logo">
					<div class="logo-title">
						<a href=""> <img src="images/logo.png" alt="logo" />
							<h2>Grocery</h2>
						</a>
					</div>
					<ul class="ul-List">
						<a href="StaffControl?mode=staffHome">
							<li class="product"
							style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
								<div class="slashLine" style="display: block"></div> Product
						</li>
						</a>
						<a href="StaffControl?mode=viewTaskByStaffId">
							<li class="task" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Task
						</li>
						</a>
						<a href="LoginControl?mode=signOut"><li class="login"
							style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Log Out
						</li></a>
					</ul>
				</div>
			</div>
			<div class="col-10 col-lg-10 left-col-infor">
				<div class="type-main">
					<jsp:include page="include/Header.jsp"></jsp:include>
				</div>
				<div class="main-information">
					<div class="button-user" style="display: flex">
						<div style="margin-right: 660px">
							<h2>Product</h2>
						</div>
						<div class="search-main">
							<form action="AdminControl" method="get">
								<input style="display: none" name="mode" type="text"
									value="searchProduct"> <input type="text" name="query"
									id="search" placeholder="Search for products..."
									value="${value}">
								<button type="submit" style="border: solid white 0px">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</form>
						</div>
						<button type="button" class="btn btn-success"
							id="btn-success-product" data-toggle="modal"
							data-target="#staticBackdrop">
							<i class="fa-solid fa-circle-plus"></i>Add Product
						</button>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Name</th>
								<th scope="col" class="taskID">Quantity</th>
								<th scope="col">Price</th>
								<th scope="col" class="taskID">Location</th>
								<th scope="col">Type</th>
								<th scope="col">Status</th>
								<th scope="col">Sold</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${listProducts != null}">
								<c:forEach items="${listProducts}" var="l">
									<tr>
										<td>${l.getProductName()}</td>
										<td>${l.getQuantity()}</td>
										<td>${l.getPrice()}</td>
										<td>${l.getPosition()}</td>
										<td>${l.getType()}</td>
										<td>${l.getCategory()}</td>
										<td>${l.getSold()}</td>
										<td>${l.getStatus()}</td>
										<td><a class="button-like"
											href="AdminControl?mode=editInfo&productId=${l.getProductId()}">
												<i class="fas fa-edit"></i>
										</a> <a class="button-like" onclick="return confirmDelete()"
											href="AdminControl?mode=deleteProduct&product_id=${l.getProductId()}">
												<i class="fa-solid fa-delete-left"></i>
										</a></td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${listProduct != null}">
								<c:forEach items="${listProduct}" var="l">
									<tr>
										<td>${l.getProductName()}</td>
										<td>${l.getQuantity()}</td>
										<td>${l.getPrice()}</td>
										<td>${l.getPosition()}</td>
										<td>${l.getType()}</td>
										<td>${l.getCategory()}</td>
										<td>${l.getSold()}</td>
										<td>${l.getStatus()}</td>
										<td><a class="button-like"
											href="AdminControl?mode=editInfo&productId=${l.getProductId()}">
												<i class="fas fa-edit"></i>
										</a> <a class="button-like" onclick="return confirmDelete()"
											href="AdminControl?mode=deleteProduct&product_id=${l.getProductId()}">
												<i class="fa-solid fa-delete-left"></i>
										</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<div class="profit-template" style="display: none">
						<div class="chart-container">
							<div class="chart-box">
								<canvas id="pieChart"></canvas>
							</div>
							<div class="chart-box">
								<canvas id="lineChart"></canvas>
							</div>
						</div>
						<div class="chart-container">
							<div class="chart-box">
								<canvas id="pieChart-money"></canvas>
							</div>
							<div class="chart-box">
								<canvas id="lineChart-money"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- style="width: 100%; max-width: 600px" -->
	<!-- ------------------------------------------- -->
	<!-- Template Add -->
	<!-- ------------------------------------------- -->
	<div class="modal fade" id="staticBackdrop" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true" class="close-modal">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="StaffControl?mode=addNewProduct" method="post">
						<div class="form-group">
							<label for="exampleInputName">Name</label> <input type="text"
								class="form-control" id="exampleInputName" name="productName"
								aria-describedby="emailHelp" /> <small id="nameCheck"
								class="form-text text-muted" style="display: none">Name
								can not be empty</small>
						</div>
						<div class="form-group">
							<label for="exampleInputQuantity">Quantity</label> <input
								type="number" class="form-control" id="exampleInputQuantity"
								name="productQuantity" aria-describedby="emailHelp" /> <small
								id="quantityCheck" class="form-text text-muted"
								style="display: none">Quantity only contains numbers</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPrice">Price</label> <input type="number"
								class="form-control" id="exampleInputPrice" name="productPrice"
								aria-describedby="emailHelp" /> <small id="priceCheck"
								class="form-text text-muted" style="display: none">Price
								only contains numbers</small>
						</div>
						<div class="form-group">
							<label>Type:</label> <select name="type" required>
								<option value="Men">Men</option>
								<option value="Women">Women</option>
							</select>
						</div>

						<div class="form-group">
							<label>Category:</label> <select name="category" required>
								<option value="Shirt" ${p.category == 'Shirt' ? 'selected' : ''}>Shirt</option>
								<option value="Jacket"
									${p.category == 'Jacket' ? 'selected' : ''}>Jacket</option>
								<option value="Perfume"
									${p.category == 'Perfume' ? 'selected' : ''}>Perfume</option>
							</select>
						</div>
						<div class="form-group">
							<label for="exampleInputName">Location</label> <input type="text"
								class="form-control" id="location" name="productPosition"
								name="productPosition" aria-describedby="emailHelp" /> <small
								id="nameCheck" class="form-text text-muted"
								style="display: none">Location can not be empty</small>
						</div>
						<div class="modal-footer">
							<small id="successful" class="form-text text-muted"
								style="display: none"></small>
							<button type="button" class="btn btn-secondary close-modal"
								data-dismiss="modal">Close</button>
							<div class="form-add">
								<button type="submit" class="btn btn-primary add-button"
									id="add-product-button">Add</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="./js/alert_dialog.js"></script>
	<script src="./js/searching.js"></script>

</body>
</html>
