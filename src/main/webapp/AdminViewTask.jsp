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
<link rel="stylesheet" type="text/css" href="./css/alikebutton.css" />
<link rel="stylesheet" href="./css/main.css" />
<link rel="icon" href="./images/logo-title.png" />
<title>Grocery Store Management</title>
</head>

<body>
	<p class="${addTaskMessage==null ? " ": "alert-success
		alert" }" style="size: 30px">${addTaskMessage}</p>
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
						<li class="task"
							style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
							<div class="slashLine" style="display: block"></div> Task
						</li>
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
							<h2>Task</h2>
						</div>
						<button type="button" class="btn btn-success"
							id="btn-success-user" data-toggle="modal"
							data-target="#staticBackdrop">
							<i class="fa-solid fa-circle-plus"></i>Create Task
						</button>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Task Giver ID</th>
								<th scope="col">Assignee ID</th>
								<th scope="col">Created Time</th>
								<th scope="col">Status</th>
								<th scope="col">Description</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listAll}" var="a">
								<tr>
									<td>${a.getTaskId()}</td>
									<td>${a.getTaskGiverId()}</td>
									<td>${a.getAssigneeId()}</td>
									<td>${a.getCreatedTime()}</td>
									<c:if test="${a.getStatus().equals('Undone')}">
										<td style="background-color: lightcoral">${a.getStatus()}</td>
									</c:if>
									<c:if test="${a.getStatus().equals('Done')}">
										<td style="background-color: lightgreen">${a.getStatus()}</td>
									</c:if>
									<c:if test="${a.getStatus().equals('Executing')}">
										<td style="background-color: yellow">${a.getStatus()}</td>
									</c:if>
									<td>${a.getDescription()}</td>
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
					<form action="AdminControl?mode=addTask" method="post">
						<div class="form-group">
							<label for="exampleInputUsername">Task Giver ID</label> <input
								name="creatorId" type="text" class="form-control"
								value="${sessionScope.account.getAccountId()}"
								id="exampleInputUsername" /> <small id="accountCheck"
								class="form-text text-muted" style="display: none">Task
								Giver ID can not be empty or this Task Giver ID is exist</small>
						</div>
						<div class="form-group">
							<label for="exampleInputUsername">Assignee ID</label> <input
								name="assigneeId" type="text" class="form-control"
								id="exampleInputUsername" /> <small id="accountCheck"
								class="form-text text-muted" style="display: none">Assignee
								ID can not be empty or this Assignee ID is exist</small>
						</div>
						<div class="form-group">
							<label for="exampleInputUsername">Description</label> <input
								name="description" type="text" class="form-control"
								id="exampleInputUsername" /> <small id="accountCheck"
								class="form-text text-muted" style="display: none">Assignee
								ID can not be empty or this Assignee ID is exist</small>
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
