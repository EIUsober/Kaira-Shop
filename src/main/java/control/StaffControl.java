package control;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.AccountDAO;
import dao.ProductDAO;
import dao.TaskDAO;
import entity.Account;
import entity.Product;
import entity.Task;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class StaffControl
 */
@WebServlet("/StaffControl")
@MultipartConfig
public class StaffControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String target = "StaffManage.jsp";
		String mode = request.getParameter("mode");
		ProductDAO productDAO = new ProductDAO();
		List<Product> listAllProducts;
		ArrayList<Task> listAllTasks;
		TaskDAO taskDAO = new TaskDAO();
        AccountDAO loginDAO = new AccountDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        Account account = loginDAO.getAccount(a);
		switch (mode) {
		case "updateTaskStatus" -> {
            String taskid = request.getParameter("id");
            String status = request.getParameter("status");
            taskDAO.updateTaskStatus(status, taskid);
            target = "StaffControl?mode=viewTaskByStaffId";
        }
		case "viewTaskByStaffId" -> {
			listAllTasks = taskDAO.getTaskByStaffId(a.getAccountId());
			request.setAttribute("listTaskByStaff", listAllTasks);
			target = "Task.jsp";
		}
		case "addTask" -> {
			String taskId = request.getParameter("taskId");
			String creatorId = request.getParameter("creatorId");
			String assigneeId = request.getParameter("assigneeId");
			String status = request.getParameter("status");
			String description = request.getParameter("description");

			Task task = new Task(taskId, LocalDateTime.now(), creatorId , assigneeId, status, description);
			taskDAO.addTask(task);
			request.setAttribute("addTaskMessage", "Add task successfully!");
            target = "StaffControl?mode=viewTaskById";
		}
		case "addNewProduct" -> {
			String productName = request.getParameter("productName");
			int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
			int productPrice = Integer.parseInt(request.getParameter("productPrice"));
			String productPosition = request.getParameter("productPosition");
			String type = request.getParameter("type");
			String category = request.getParameter("category");

			Product product = new Product();
			product.setProductName(productName);
			product.setQuantity(productQuantity);
			product.setPrice(productPrice);
			product.setPosition(productPosition);
			product.setType(type);
			product.setCategory(category);
			product.setStatus(1);
			productDAO.addNewProduct(product);
			request.setAttribute("addMessage", "Add product successfully!");
			target = "StaffControl?mode=staffHome";
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

	        Product product = productDAO.getProductById(id);

	        product.setProductName(productName);
	        product.setQuantity(productQuantity);
	        product.setPrice(productPrice);
	        product.setPosition(productPosition);
	        product.setType(type);
	        product.setCategory(category);

	        productDAO.editProduct(product);

	        request.setAttribute("editMessage", "Edit Successful!");
	        target = "StaffControl?mode=staffHome";		}
		case "deleteProduct" -> {
			int productId = Integer.parseInt(request.getParameter("product_id"));
			productDAO.deleteProduct(productId);
			request.setAttribute("deleteMessage", "Delete product successfully!");
			target = "StaffControl?mode=staffHome";		}
		case "searchProduct" -> {
			String search = request.getParameter("query");
			listAllProducts = productDAO.searchProductByName(search);
			request.setAttribute("listProduct", listAllProducts);
		}
		case "staffHome" -> {
			listAllProducts = productDAO.getAllProducts();
			request.setAttribute("listProducts", listAllProducts);
		}
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(target);
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
