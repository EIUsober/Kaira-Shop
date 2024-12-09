<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<li class="product"
			style="background-color: rgb(231, 237, 255); color: rgb(24, 20, 243);">
			<div class="slashLine" style="display: block"></div> Product
		</li>
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