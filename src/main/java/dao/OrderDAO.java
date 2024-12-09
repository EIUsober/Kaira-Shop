package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import entity.Order;
import util.HibernateUtil;

public class OrderDAO {
	public boolean saveOrder(Order order) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			session.persist(order);
			transaction.commit();
			return true;
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while saving order: " + e.getMessage());
			return false;
		}
	}

	public List<Order> getAllOrders() {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			return session.createQuery("FROM Order", Order.class).list();
		} catch (Exception e) {
			System.out.println("Error while retrieving orders: " + e.getMessage());
			return null;
		}
	}
}
