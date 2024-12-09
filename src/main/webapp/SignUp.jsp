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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="./css/login.css" />
<link rel="icon" href="./images/logo-title.png" />
<title>Grocery Store Management</title>
</head>
<body>
	<p class="${errorMessage == null ? "": "alert-danger alert" }">${errorMessage}</p>
	<form action="UserControl?mode=signup" method="post">
		<div class="login">
			<div class="row">
				<div class="col-sm-12 col-lg-12">
					<div class="media">
						<img src="./images/logo.png" class="mr-3" alt="Logo" id="logo" />
						<div class="media-body">
							<h5 class="mt-0">Grocery Store</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="sign-in-frame">
				<div class="row">
					<div class="col-sm-12 col-lg-12">
						<div class="login-frame">
							<div class="sign-in">
								<h2>Sign Up</h2>
							</div>
							<form>
								<div class="form-group">
									<label for="exampleInputUsername">Username</label> <input
										type="text" class="form-control" id="exampleInputUsername"
										aria-describedby="emailHelp" name="username" />
								</div>
								<div class="form-group">
									<label for="exampleInputPassword">Password</label>
									<div class="store">
										<input type="password" class="form-control password-input"
											id="exampleInputPassword" name="password" />
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword">Confirm Password</label>
									<div class="store">
										<input type="password" class="form-control password-input"
											id="exampleInputPassword" name="confirm" />
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputUsername">Email</label> <input
										type="email" class="form-control" id="exampleInputUsername"
										aria-describedby="emailHelp" name="email" />
								</div>
								<div class="row">
									<div class="col-sm-12 col-lg-12">
										<button type="submit" class="btn btn-primary login-button">
											Sign Up</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script type="module" src="./js/forLoginSignUp/loginCheck.js"></script>
</body>
</html>
