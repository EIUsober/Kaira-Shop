<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/cart.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<title>Cart</title>
</head>
<body>
	<section class="h-100 h-custom" style="background-color: #d2c9ff;">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-12">
					<div class="card card-registration card-registration-2"
						style="border-radius: 15px;">
						<div class="card-body p-0">
							<div class="row g-0">
								<div class="col-lg-8">
									<div class="p-5">
										<div
											class="d-flex justify-content-between align-items-center mb-5">
											<h1 class="fw-bold mb-0">Shopping Cart</h1>
											<h6 class="mb-0 text-muted">${totalQuantity}items</h6>
										</div>
										<hr class="my-4">
										<c:forEach items="${items}" var="item">
											<div
												class="row mb-4 d-flex justify-content-between align-items-center">
												<div class="col-md-2 col-lg-2 col-xl-2">
													<img src="${item.getProduct().getImageUrl()}"
														alt="Product Image"
														style="width: 100%; height: auto; border-radius: 8px; margin-bottom: 15px;">
												</div>
												<div class="col-md-3 col-lg-3 col-xl-3">
													<h6 class="text-muted">${item.getProduct().getCategory()}</h6>
													<h6 class="mb-0">${item.getProduct().getProductName()}</h6>
												</div>
												<input type="hidden" name="cartId"
													value="${item.getCart().getId()}" /> <input type="hidden"
													name="cartItemId" value="${item.getId()}" />
												<div class="col-md-3 col-lg-3 col-xl-2 d-flex">
													<button class="btn btn-link px-2"
														onclick="updateQuantity(this, -1)">
														<i class="fas fa-minus"></i>
													</button>
													<input id="quantity-${item.getId()}" min="1"
														name="quantity" value="${item.getQuantity()}"
														type="number" class="form-control form-control-sm"
														onchange="updateTotal()" />
													<button class="btn btn-link px-2"
														onclick="updateQuantity(this, 1)">
														<i class="fas fa-plus"></i>
													</button>
												</div>
												<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
													<h6 class="mb-0">
														<span class="item-price" style="display: none">${item.getProduct().getPrice()}</span>
													</h6>
													<h6 class="mb-0">
														Item Total: $ <span class="item-total">${item.getProduct().getPrice() * item.getQuantity()}</span>
													</h6>
												</div>
												<div class="col-md-1 col-lg-1 col-xl-1 text-end">
													<a
														href="UserControl?mode=removeFromCart&cartItemId=${item.getId()}"
														class="text-muted"><i class="fas fa-times"></i></a>
												</div>
											</div>
											<hr class="my-4">
										</c:forEach>
										<div class="pt-5">
											<h6 class="mb-0">
												<a href="UserControl?mode=getAllProducts" class="text-body"><i
													class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a>
											</h6>
										</div>
									</div>
								</div>
								<div class="col-lg-4 bg-body-tertiary">
									<div class="p-5">
										<h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
										<hr class="my-4">

										<h5 class="text-uppercase mb-3">Shipping</h5>

										<div class="mb-4 pb-2">
											<p>Free shipping fee</p>
										</div>
										<form action="UserControl?mode=checkoutSuccess" method="post">
											<h5 class="text-uppercase mb-3">Full Name</h5>

											<div class="mb-5">
												<div data-mdb-input-init class="form-outline">
													<input type="text" id="form3Examplea2"
														class="form-control form-control-lg" name="fullName" />
												</div>
											</div>
											<h5 class="text-uppercase mb-3">Phone Number</h5>

											<div class="mb-5">
												<div data-mdb-input-init class="form-outline">
													<input type="number" id="form3Examplea2"
														class="form-control form-control-lg" name="phone" />
												</div>
											</div>

											<hr class="my-4">

											<div class="d-flex justify-content-between mb-4">
												<h5 class="text-uppercase">Total price</h5>
												<h5>
													$<span id="total-price">${totalMoney}</span> <input
														type="hidden" name="totalPrice" value="${totalMoney}" />
												</h5>
											</div>

											<button type="submit" data-mdb-button-init
												data-mdb-ripple-init class="btn btn-dark btn-block btn-lg"
												data-mdb-ripple-color="dark">Check out</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		</div>
	</section>
	<script>
		function updateQuantity(button, change) {
			var input = button.parentNode.querySelector('input[type=number]');
			var newValue = parseInt(input.value) + change;
			if (newValue >= 1) {
				input.value = newValue;
				updateItemTotal(input);
				updateTotal();
			}
		}

		function updateItemTotal(input) {
			var price = parseFloat(input.parentNode.nextElementSibling
					.querySelector('.item-price').innerText);
			var itemTotal = price * parseInt(input.value);
			input.parentNode.nextElementSibling.querySelector('.item-total').innerText = itemTotal
					.toFixed(2);
		}

		function updateTotal() {
			var total = 0;
			document
					.querySelectorAll('input[name="quantity"]')
					.forEach(
							function(input) {
								var price = parseFloat(input.parentNode.nextElementSibling
										.querySelector('.item-price').innerText);
								total += parseInt(input.value) * price;
							});
			document.getElementById('total-price').innerText = total.toFixed(2);
		}
	</script>

</body>
</html>