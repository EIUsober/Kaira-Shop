<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="type" style="margin-right: 200px">
	<h2 id="type-title">Manage</h2>
</div>
<div class="setting">
	<i class="fa-solid fa-gear"></i>
</div>
<div class="notification">
	<div class="countNotSeen" style="display: none"></div>
	<i class="fa-regular fa-bell"></i>
	<div class="show-notification">
		<div class="each-notification" data-id="7">
			<div class="media">
				<img src="./images/avatar1.png" class="align-self-center mr-3"
					alt="..." />
				<div class="media-body">
					<small class="mb-0"> <strong>S0001</strong> has made <strong>T_A0001_2</strong>
						<span class="status-done span-status"> done </span>
					</small>
					<div class="timestamp">2 hours ago</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="user">
	<div class="store-user-img">
		<img src="images/avatar1.png" alt="avatar1" />
		<div class="user-profile">
			<div class="infor-user-profile">
				<div class="media">
					<img src="./images/avatar1.png" class="align-self-center mr-3"
						alt="..." />
					<div class="media-body">
						<h6 class="mt-0">
							${sessionScope.account.getUsername()} <br />
							<c:if test="${sessionScope.account.getIsAdmin() != 1}">
								<small>Staff</small>
							</c:if>
							<c:if test="${sessionScope.account.getIsAdmin() == 1}">
								<small>Admin</small>
							</c:if>
						</h6>
						<div class="contact-email">
							<i class="fa-regular fa-envelope"></i> <small>${sessionScope.account.getEmail()}</small>
						</div>
					</div>
				</div>
			</div>
			<form action="LoginControl?mode=signOut" method="POST">
				<button type="submit" class="btn btn-outline-danger log-out-profile">Log Out
				</button>
			</form>

		</div>
	</div>
</div>
