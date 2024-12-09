<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="./css/main.css" />
<link rel="icon" href="./images/logo-title.png" />
<title>Grocery Store Management</title>
<style>
</style>
</head>

<body>
	<main>
		<div class="row">
			<div class="col-2 col-lg-2 sidebar">
				<div class="list-logo">
					<div class="logo-title">
						<a href=""> <img src="images/logo.png" alt="logo" />
							<h2>Grocery</h2>
						</a>
					</div>
					<ul class="ul-List">
						<a href="ManageAccount?mode=getAllAccounts">
							<li class="account" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Account
						</li>
						</a>
						<a href="AdminControl?mode=adminHome">
							<li class="product" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Product
						</li>
						</a>
						<a href="AdminControl?mode=viewAllTasks">
							<li class="product" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Task
						</li>
						</a>
						<li class="profit"
							style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
							<div class="slashLine" style="display: block"></div> Order
						</li>
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
						<div style="margin-right: 960px">
							<h2>Task</h2>
						</div>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">Order ID</th>
								<th scope="col">Customer Name</th>
								<th scope="col">Customer Phone</th>
								<th scope="col">Order Items</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listAllOrders}" var="a">
								<tr>
									<td>${a.getId()}</td>
									<td>${a.getCustomerName()}</td>
									<td>${a.getCustomerEmail()}</td>
									<td>
										<ul>
											<c:forEach var="item" items="${a.items}">
												<li>${item.productName}(Quantity:${item.quantity},
													Price: ${item.price})</li>
											</c:forEach>
										</ul>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	<script src="./js/updateTaskStatus.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
