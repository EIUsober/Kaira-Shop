package control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.LoginDAO;
import dao.UserAccountDAO;
import entity.Account;
import entity.UserAccount;

/**
 * Servlet implementation class LoginControl
 */
@WebServlet("/LoginControl")
public class LoginControl extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		String target = "index.jsp";
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		LoginDAO loginDAO = new LoginDAO();
		UserAccountDAO userAccountDAO = new UserAccountDAO();
		Account account = (Account) session.getAttribute("account");
		UserAccount userAccount = (UserAccount) session.getAttribute("userAccount");

		switch (mode) {
		case "login" -> {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			account = loginDAO.login(username, password);
			userAccount = userAccountDAO.userLogin(username, password);

			if (account == null && userAccount == null) {
				request.setAttribute("mess", "Wrong Username or Password");
			} else if (account != null) {
				if (account.getIsActive() == 1) {
					session.setAttribute("account", account);
					target = "Header.jsp";
					if (account.getIsAdmin() == 1) {
						target = "AdminControl?mode=adminHome";
					} else if (account.getIsAdmin() == 0) {
						target = "StaffControl?mode=staffHome";
					}
				} else {
					request.setAttribute("inactive", "Wrong Username or Password");
					target = "index.jsp";
				}
			} else if (userAccount != null) {
				session.setAttribute("userAccount", userAccount);
				target = "UserControl?mode=userHome";
			}
		}

		case "signOutUser" -> {
			session.removeAttribute("userAccount");
			target = "CustomerPage.jsp";
		}
		case "signOut" -> {
			session.removeAttribute("account");
			target = "index.jsp";
		}
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(target);
		requestDispatcher.forward(request, response);

	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
	// + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
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