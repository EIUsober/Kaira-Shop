package control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserAccountDAO;
import entity.CartItem;
import entity.Order;
import entity.OrderItem;
import entity.Product;
import entity.UserAccount;

/**
 * Servlet implementation class UserControl
 */
@WebServlet("/UserControl")
public class UserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String target = "CustomerPage.jsp";
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		UserAccount userAccount = (UserAccount) session.getAttribute("userAccount");
		CartItem cartItem = (CartItem) session.getAttribute("cartItem");
		ProductDAO productDAO = new ProductDAO();
		UserAccountDAO userAccountDAO = new UserAccountDAO();
		OrderDAO orderDAO = new OrderDAO();
		CartDAO cartDAO = new CartDAO();
		List<Product> listAllProducts;
		List<Product> listProductByCategory;
		List<Product> listProductByType;
		switch (mode) {
		case "saveOrder" -> {
			String fullName = request.getParameter("fullName");
			String phone = request.getParameter("phone");
			String totalPrice = request.getParameter("totalPrice");
			int userId = userAccount.getId();
			List<CartItem> cartItems = cartDAO.getAllItems(userId);
			List<OrderItem> orderItems = new ArrayList<>();
			for (CartItem i : cartItems) {
				OrderItem orderItem = new OrderItem();
				orderItem.setProductName(i.getProduct().getProductName());
				orderItem.setQuantity(i.getQuantity());
				orderItem.setPrice(i.getProduct().getPrice());
				orderItems.add(orderItem);
			}
			Order order = new Order();
			order.setCustomerName(fullName);
			order.setCustomerEmail(phone);
			order.setItems(orderItems);
			for (OrderItem orderItem : orderItems) {
				orderItem.setOrder(order);
			}
			boolean isOrderSaved = orderDAO.saveOrder(order);
			if (isOrderSaved) {
				productDAO.updateProductStock(order);
				cartDAO.deleteAllItems(userId);
				request.setAttribute("fullName", fullName);
				request.setAttribute("phone", phone);
				request.setAttribute("totalPrice", totalPrice);
				target = "CheckoutSuccess.jsp";
			} else {
				response.getWriter().write("Error while processing your order. Please try again.");
			}
		}
		case "signup" -> {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String confirmPass = request.getParameter("confirm");

			if (confirmPass.equals(password)) {
				userAccountDAO.signUpUser(username, password, email);
				request.setAttribute("successMessage", "Sign up success. Please log in.");
				target = "index.jsp";
			} else {
				request.setAttribute("errorMessage", "Password Confirm is wrong. Please try again.");
				target = "SignUp.jsp";
			}
		}
		case "searchProductByName" -> {
			String search = request.getParameter("query");
			listAllProducts = productDAO.searchProductByName(search);
			request.setAttribute("listSearchProduct", listAllProducts);
			target = "AllProduct.jsp";
		}
		case "checkoutSuccess" -> {
			userAccount = (UserAccount) session.getAttribute("userAccount");
			int userId = userAccount.getId();
			String fullName = request.getParameter("fullName");
			String phone = request.getParameter("phone");
			String totalPrice = request.getParameter("totalPrice");
			request.setAttribute("fullName", fullName);
			request.setAttribute("phone", phone);
			request.setAttribute("totalPrice", totalPrice);
			cartDAO.deleteAllItems(userId);

			target = "CheckoutSuccess.jsp";
		}
		case "removeFromCart" -> {
			int id = Integer.parseInt(request.getParameter("cartItemId"));
			cartDAO.removeItemFromCart(id);
			target = "UserControl?mode=viewCart";
		}
		case "addToCart" -> {
			if (userAccount == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			try {
				int userId = userAccount.getId();
				int productId = Integer.parseInt(request.getParameter("productId"));
				int quantity = Integer.parseInt(request.getParameter("quantity"));

				if (quantity < 1) {
					throw new IllegalArgumentException("Quantity must be at least 1");
				}

				Product product = productDAO.getProductById(productId);
				if (product == null) {
					throw new IllegalArgumentException("Product not found");
				}
				cartDAO.addItemToCart(userId, product, quantity);
				target = "UserControl?mode=viewCart";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", "Failed to add item to cart: " + e.getMessage());
				target = "error.jsp";
			}
			break;
		}
		case "viewCart" -> {
			int userId = userAccount.getId();
			List<CartItem> items = cartDAO.getAllItems(userId);
			int totalQuantity = items.stream().mapToInt(CartItem::getQuantity).sum();
			int totalMoney = items.stream().mapToInt(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
			request.setAttribute("items", items);
			request.setAttribute("totalQuantity", totalQuantity);
			request.setAttribute("totalMoney", totalMoney);
			target = "Cart.jsp";
			break;
		}
		case "pay" -> {
			int userId = userAccount.getId();
			List<CartItem> items = cartDAO.getAllItems(userId);
			int totalMoney = items.stream().mapToInt(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
			request.setAttribute("totalMoney", totalMoney);
			target = "vnpay.jsp";
			break;
		}
		case "detail" -> {
			int id = Integer.parseInt(request.getParameter("id"));
			Product product = productDAO.getProductById(id);
			request.setAttribute("productDetail", product);
			target = "SinglePage.jsp";
		}
		case "getProductByType" -> {
			String type = request.getParameter("type");
			listProductByType = productDAO.getProductByType(type);
			request.setAttribute("listProductByType", listProductByType);
			if (type.equals("men")) {
				target = "Male.jsp";
			} else {
				target = "Female.jsp";
			}
		}
		case "getProductByCategory" -> {
			String category = request.getParameter("category");
			listProductByCategory = productDAO.getProductByCategory(category);
			request.setAttribute("listProductByCategory", listProductByCategory);
			if (category.equals("jacket")) {
				target = "Jacket.jsp";
			} else if (category.equals("shirt")) {
				target = "Shirt.jsp";
			} else {
				target = "Perfume.jsp";
			}
		}
		case "getProductById" -> {
			int id = Integer.parseInt(request.getParameter("productId"));
			Product product = productDAO.getProductById(id);
			request.setAttribute("product", product);
		}
		case "getAllProducts" -> {
			listAllProducts = productDAO.getAllActiveProducts();
			request.setAttribute("listProducts", listAllProducts);
			target = "AllProduct.jsp";
		}
		case "userHome" -> {
			listAllProducts = productDAO.getAllActiveProducts();
			request.setAttribute("listProducts", listAllProducts);
		}
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(target);
		requestDispatcher.forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
