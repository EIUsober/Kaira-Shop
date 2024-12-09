package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.hibernate.Session;
import org.hibernate.query.Query;

import entity.UserAccount;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class UserAccountDAO {
	public boolean signUpUser(String username, String password, String email) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			String hashedPassword = doHashing(password);
			UserAccount newUser = new UserAccount();
			newUser.setUsername(username);
			newUser.setPassword(hashedPassword);
			newUser.setEmail(email);
			session.persist(newUser);
			transaction.commit();
			return true;
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while signing up user: " + e.getMessage());
			return false;
		}
	}

	public UserAccount userLogin(String username, String password) {
		UserAccount userAccount = null;
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			String hql = "FROM UserAccount WHERE username = :username AND password = :password";
			Query<UserAccount> query = session.createQuery(hql, UserAccount.class);
			query.setParameter("username", username);
			query.setParameter("password", doHashing(password));
			userAccount = query.uniqueResult();
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error retrieving user: " + e.getMessage());
		}
		return userAccount;
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
			Logger.getLogger(UserAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
		}
		return "";
	}
}
