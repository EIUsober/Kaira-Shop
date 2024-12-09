package control;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.AccountDAO;
import dao.LoginDAO;
import entity.Account;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ManageAccount")
public class ManageAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String target = "Account.jsp";
		String mode = request.getParameter("mode");
		ArrayList<Account> listAcc;
		AccountDAO accountDAO = new AccountDAO();
		switch (mode) {
		case "enableUser" -> {
			String id = request.getParameter("userId");
			accountDAO.enableUser(id);
			request.setAttribute("enableUserMessage", "Enable User Successful!");
			target = "ManageAccount?mode=getAllAccounts";
		}
		case "disableUser" -> {
			String id = request.getParameter("userId");
			accountDAO.disableUser(id);
			request.setAttribute("disableUserMessage", "Disable User Successful!");
			target = "ManageAccount?mode=getAllAccounts";
		}
		case "addAccount" -> {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String confirmPass = request.getParameter("confirmPass");
			String location = request.getParameter("location");
			String email = request.getParameter("email");
			
			if (confirmPass.equals(password)) {
				accountDAO.addStaffAccount(username, password, location, email);
				request.setAttribute("addUserMessage", "Add New User Successful!");
			} else {
				request.setAttribute("WrongConfirmPass", "Wrong Confirm Password!");
			}
			target = "ManageAccount?mode=getAllAccounts";
		}
		case "getAllAccounts" -> {
			listAcc = accountDAO.getAllAccounts();
			request.setAttribute("acc", listAcc);
		}
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(target);
		requestDispatcher.forward(request, response);
	}
	public static String doHashing(String password) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");

			messageDigest.update(password.getBytes());
			byte[] resultByteArray = messageDigest.digest();
			StringBuilder sb = new StringBuilder();
			for (byte b : resultByteArray) {
				sb.append(String.format("%02x", b));
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException ex) {
			Logger.getLogger(LoginDAO.class.getName()).log(Level.SEVERE, null, ex);
		}
		return "";
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
