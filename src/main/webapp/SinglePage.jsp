<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Fashion Store</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="author" content="TemplatesJungle">
<meta name="keywords" content="ecommerce,fashion,store">
<meta name="description"
	content="Bootstrap 5 Fashion Store HTML CSS Template">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&family=Marcellus&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/product.css">
<link rel="stylesheet" type="text/css" href="css/single.css">
</head>

<body>

	<div class="preloader text-white fs-6 text-uppercase overflow-hidden"></div>

	<div class="search-popup">
		<div class="search-popup-container">

			<form role="search" method="get" class="form-group" action="">
				<input type="search" id="search-form"
					class="form-control border-0 border-bottom"
					placeholder="Type and press enter" value="" name="s" />
				<button type="submit"
					class="search-submit border-0 position-absolute bg-white"
					style="top: 15px; right: 15px;">
					<svg class="search" width="24" height="24">
            <use xlink:href="#search"></use>
          </svg>
				</button>
			</form>

			<h5 class="cat-list-title">Browse Categories</h5>

			<ul class="cat-list">
				<li class="cat-list-item"><a href="#" title="Jackets">Jackets</a>
				</li>
				<li class="cat-list-item"><a href="#" title="T-shirts">T-shirts</a>
				</li>
				<li class="cat-list-item"><a href="#" title="Accessories">Accessories</a>
				</li>
			</ul>

		</div>
	</div>

	<div class="offcanvas offcanvas-end" data-bs-scroll="true"
		tabindex="-1" id="offcanvasCart" aria-labelledby="My Cart">
		<div class="offcanvas-header justify-content-center">
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<div class="order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Your cart</span> <span
						class="badge bg-primary rounded-pill">3</span>
				</h4>
				<ul class="list-group mb-3">
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Growers cider</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$12</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Fresh grapes</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$8</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Heinz tomato ketchup</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Total
							(USD)</span> <strong>$20</strong></li>
				</ul>

				<button class="w-100 btn btn-primary btn-lg" type="submit">Continue
					to Checkout</button>
			</div>
		</div>
	</div>

	<nav
		class="navbar navbar-expand-lg bg-light text-uppercase fs-6 p-3 border-bottom align-items-center">
		<jsp:include page="include/CustomerInclude.jsp"></jsp:include>
	</nav>
	<div class="checkout-container">
		<h1>Product Detail</h1>
		<c:set var="p" value="${productDetail}" />
		<form action="UserControl?mode=addToCart&productId=${p.getProductId()}"
			method="post">
			<input type="hidden" name="userId" value="${sessionScope.userAccount.getId()}" />
			<div class="product-info">
				<img src="${p.getImageUrl()}" alt="Product Image"
					style="width: 20%; height: auto; border-radius: 8px; margin-bottom: 15px;">
				<p>Product Name: ${p.getProductName()}</p>
				<p>Price: $ ${p.getPrice()}</p>
			</div>
			<div class="quantity-selector">
				<button type="button" onclick="updateQuantity(-1)">-</button>
				<input type="number" id="quantity" name="quantity" value="1" min="1">
				<button type="button" onclick="updateQuantity(1)">+</button>
			</div>
			<button class="add-to-cart" type="submit">Add to Cart</button>
		</form>
	</div>
	<jsp:include page="include/CustomerFooter.jsp"></jsp:include>

	<script src="js/jquery.min.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/SmoothScroll.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<script src="js/script.min.js"></script>
	<script>
		function updateQuantity(change) {
			const quantityInput = document.getElementById('quantity');
			let currentQuantity = parseInt(quantityInput.value);
			let newQuantity = currentQuantity + change;
			if (newQuantity < 1)
				newQuantity = 1;
			quantityInput.value = newQuantity;
		}
	</script>
</body>

</html>