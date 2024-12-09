package control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.AccountDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.TaskDAO;
import entity.Account;
import entity.Order;
import entity.Product;
import entity.Task;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 100 // 100 MB
)

@WebServlet("/AdminControl")
public class AdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String target = "AdminManage.jsp";
		String mode = request.getParameter("mode");
		ProductDAO productDAO = new ProductDAO();
		List<Product> listAllProducts;
		List<Order> listAllOrders;
		ArrayList<Task> listAllTasks;
		TaskDAO taskDAO = new TaskDAO();
		AccountDAO loginDAO = new AccountDAO();
		OrderDAO orderDAO = new OrderDAO();
		HttpSession session = request.getSession();
		Account a = (Account) session.getAttribute("account");
		Account account = loginDAO.getAccount(a);
		switch (mode) {
		case "getAllOrders" -> {
			listAllOrders = orderDAO.getAllOrders();
			request.setAttribute("listAllOrders", listAllOrders);
			target = "AllOrders.jsp";
		}
		case "getAllCustomerProducts" -> {
			listAllProducts = productDAO.getAllActiveProducts();
			request.setAttribute("listProducts", listAllProducts);
			target = "AllProduct.jsp";
		}
		case "addTask" -> {
			String taskId = request.getParameter("taskId");
			String creatorId = request.getParameter("creatorId");
			String assigneeId = request.getParameter("assigneeId");
			String status = request.getParameter("status");
			String description = request.getParameter("description");

			Task task = new Task(taskId, LocalDateTime.now(), creatorId, assigneeId, status, description);
			taskDAO.addTask(task);
			request.setAttribute("addTaskMessage", "Add task successfully!");
			target = "AdminControl?mode=viewAllTasks";
		}
		case "viewAllTasks" -> {
			account = (Account) session.getAttribute("account");
			listAllTasks = taskDAO.getAllTasks();
			session.setAttribute("account", account);
			request.setAttribute("listAll", listAllTasks);
			target = "AdminViewTask.jsp";
		}
		case "manageAccount" -> {
			target = "Account.jsp";
		}
		case "searchProduct" -> {
			String search = request.getParameter("query");
			listAllProducts = productDAO.searchProductByName(search);
			request.setAttribute("listProduct", listAllProducts);
		}
		case "editInfo" -> {
			int id = Integer.parseInt(request.getParameter("productId"));
			Product p = productDAO.getProductById(id);
			request.setAttribute("p", p);
			target = "EditProduct.jsp";
		}
		case "editProduct" -> {
			int id = Integer.parseInt(request.getParameter("productId"));
			String productName = request.getParameter("productName");
			int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
			int productPrice = Integer.parseInt(request.getParameter("productPrice"));
			String productPosition = request.getParameter("productPosition");
			String type = request.getParameter("type");
			String category = request.getParameter("category");
			Part imgFilePart = request.getPart("image");

			Product product = productDAO.getProductById(id);
			if (imgFilePart != null && imgFilePart.getSize() > 0) {
				String imagesDirPath = getServletContext().getRealPath("/") + "images2";
				File imagesDir = new File(imagesDirPath);
				if (!imagesDir.exists()) {
					imagesDir.mkdirs();
				}

				String newImageName = productName.replaceAll(" ", "") + ".jpg";
				String newImagePath = imagesDirPath + "\\" + newImageName;
				String relativeImagePath = "images2/" + newImageName;

				// Save the new image
				try (InputStream fileContent = imgFilePart.getInputStream();
						FileOutputStream fos = new FileOutputStream(newImagePath)) {
					byte[] buffer = new byte[1024];
					int bytesRead;
					while ((bytesRead = fileContent.read(buffer)) != -1) {
						fos.write(buffer, 0, bytesRead);
					}
				}

				product.setImageUrl(relativeImagePath);
			}
			product.setProductName(productName);
			product.setQuantity(productQuantity);
			product.setPrice(productPrice);
			product.setPosition(productPosition);
			product.setType(type);
			product.setCategory(category);

			productDAO.editProduct(product);

			request.setAttribute("editMessage", "Edit Successful!");
			target = "AdminControl?mode=adminHome";
		}
		case "deleteProduct" -> {
			int productId = Integer.parseInt(request.getParameter("product_id"));
			productDAO.deleteProduct(productId);
			request.setAttribute("deleteMessage", "Delete product successfully!");
			target = "AdminControl?mode=adminHome";
		}
		case "addNewProduct" -> {
			String productName = request.getParameter("productName");
			int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
			int productPrice = Integer.parseInt(request.getParameter("productPrice"));
			String productPosition = request.getParameter("productPosition");
			String type = request.getParameter("type");
			String category = request.getParameter("category");

			Part imgFilePart = request.getPart("image");
			String imagesDirPath = getServletContext().getRealPath("/") + "images2";
			File imagesDir = new File(imagesDirPath);
			if (!imagesDir.exists() && !imagesDir.mkdirs()) {
				throw new IOException("Failed to create directory: " + imagesDirPath);
			}
			// E:\Eclipse
			// Project\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\CSE456\images2
			String image = productName.replaceAll(" ", "");
			String imagePath = imagesDirPath + "\\" + image + ".jpg";
			String relativeImagePath = "images2/" + image + ".jpg";

			try (InputStream fileContent = imgFilePart.getInputStream();
					FileOutputStream fos = new FileOutputStream(imagePath)) {
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = fileContent.read(buffer)) != -1) {
					fos.write(buffer, 0, bytesRead);
				}
			}

			Product product = new Product();
			product.setProductName(productName);
			product.setQuantity(productQuantity);
			product.setPrice(productPrice);
			product.setPosition(productPosition);
			product.setType(type);
			product.setCategory(category);
			product.setImageUrl(relativeImagePath);
			product.setStatus(1);
			productDAO.addNewProduct(product);
			request.setAttribute("addMessage", "Add product successfully!");
			target = "AdminControl?mode=adminHome";
		}
		case "adminHome" -> {
			listAllProducts = productDAO.getAllProducts();
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

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
