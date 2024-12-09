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
						<c:if test="${sessionScope.account.getIsAdmin() != 1}">
							<a href="StaffControl?mode=staffHome">
								<li class="product"
								style="background-color: white; color: black">
									<div class="slashLine" style="display: none"></div> Product
							</li>
							</a>
						</c:if>
						<li class="task"
							style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
							<div class="slashLine" style="display: block"></div> Task
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
								<th scope="col">ID</th>
								<th scope="col">Task Giver ID</th>
								<th scope="col">Assignee ID</th>
								<th scope="col">Created Time</th>
								<th scope="col">Status</th>
								<th scope="col">Description</th>
							</tr>
						</thead>
						<tbody>
								<c:forEach items="${listTaskByStaff}" var="a">
									<tr>
										<td>${a.getTaskId()}</td>
										<td>${a.getTaskGiverId()}</td>
										<td>${a.getAssigneeId()}</td>
										<td>${a.getCreatedTime()}</td>
										<td>
											<div class="dropdown" style="display: flex; width: 170px">
												<input type="text" class="form-control" id="selectedItem"
													placeholder="${a.getStatus()}" disabled="">
												<button class="btn btn-secondary dropdown-toggle"
													type="button" data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false"></button>
												<div class="dropdown-menu"
													aria-labelledby="dropdownMenuButton">
													<a class="dropdown-item"
														href="StaffControl?mode=updateTaskStatus&id=${a.getTaskId()}&status=Executing"
														onclick="updateStatus()">Executing</a> <a
														class="dropdown-item"
														href="StaffControl?mode=updateTaskStatus&id=${a.getTaskId()}&status=Done"
														onclick="updateStatus()">Done</a>
												</div>
											</div>
										</td>
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
