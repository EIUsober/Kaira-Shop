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

<link rel="stylesheet" href="./css/main.css" />
<link rel="icon" href="./images/logo-title.png" />
<title>Grocery Store Management</title>
</head>

<body>
	<p class="${enableUserMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${enableUserMessage}</p>
	<p class="${disableUserMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${disableUserMessage}</p>
	<p class="${addUserMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${addUserMessage}</p>
	<p class="${WrongConfirmPass==null ? " ": "alert-danger
		alert" }" style="size: 30px">${WrongConfirmPass}</p>
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
						<li class="account"
							style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
							<div class="slashLine" style="display: block"></div> Account
						</li>
						<a href="AdminControl?mode=adminHome">
							<li class="product" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Product
						</li>
						</a>
						<a href="AdminControl?mode=viewAllTasks">
							<li class="task" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Task
						</li>
						</a>
						<a href="AdminControl?mode=getAllOrders">
							<li class="profit" style="background-color: white; color: black">
								<div class="slashLine" style="display: none"></div> Order
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
						<div style="margin-right: 960px">
							<h2>Account</h2>
						</div>
						<button type="button" class="btn btn-success"
							id="btn-success-user" data-toggle="modal"
							data-target="#staticBackdrop">
							<i class="fa-solid fa-circle-plus"></i>Add User
						</button>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Username</th>
								<th scope="col">Location</th>
								<th scope="col">Email</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${acc}" var="a">
								<tr>
									<td>${a.getAccountId()}</td>
									<td>${a.getUsername()}</td>
									<td>${a.getLocation()}</td>
									<td>${a.getEmail()}</td>
									<td><c:if test="${a.getIsActive() == 1}">
											<a
												href="ManageAccount?mode=disableUser&userId=${a.getAccountId()}"
												onclick="if (confirm('Are you sure to disable this user?')) {
                                                        window.location.reload();
                                                    } else {
                                                        return false;
                                                    }"><i
												class="fa-solid fa-user-slash" data-id="A0001"></i></a>
										</c:if> <c:if test="${a.getIsActive() != 1}">
											<a
												href="ManageAccount?mode=enableUser&userId=${a.getAccountId()}"
												onclick="if (confirm('Are you sure to enable this user?')) {
                                                        window.location.reload();
                                                    } else {
                                                        return false;
                                                    }"><i
												class="fa-solid fa-square-check" data-id="A0001"></i></a>
										</c:if></td>
								</tr>
							</c:forEach>
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
					<form action="ManageAccount?mode=addAccount" method="post">
						<div class="form-group">
							<label for="exampleInputUsername">Username</label> <input
								name="username" type="text" class="form-control"
								id="exampleInputUsername" aria-describedby="emailHelp" /> <small
								id="accountCheck" class="form-text text-muted"
								style="display: none">Username can not be empty or this
								username is exist</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword">Password</label> <input
								name="password" type="password" class="form-control"
								id="exampleInputPassword" /> <small id="passwordCheck"
								class="form-text text-muted" style="display: none">Password
								cannot be empty</small>
						</div>
						<div class="form-group form-confirm-password">
							<label for="exampleInputConfirmPassword">Confirm Password</label>
							<input type="password" class="form-control" name="confirmPass"
								id="exampleInputConfirmPassword" />
						</div>
						<div class="form-group formInputLocation">
							<label for="exampleInputLocation">Location</label> <input
								name="location" type="text" class="form-control"
								id="exampleInputUsername" name="location" />
						</div>
						<div class="form-group formInputLocation">
							<label for="exampleInputLocation">Email</label> <input
								name="email" type="email" class="form-control"
								id="exampleInputUsername" />
						</div>
						<div class="modal-footer">
							<small id="successful" class="form-text text-muted"
								style="display: none"></small>
							<button type="button" class="btn btn-secondary close-modal"
								data-dismiss="modal">Close</button>
							<div class="form-add">
								<button type="submit" class="btn btn-primary add-button"
									id="add-user-button">Add</button>
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
</body>
</html>
