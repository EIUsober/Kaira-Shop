package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import entity.Order;
import entity.OrderItem;
import entity.Product;
import util.HibernateUtil;

public class ProductDAO {
	public ProductDAO() {
	}

	public boolean updateProductStock(Order order) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			for (OrderItem item : order.getItems()) {
				String productName = item.getProductName();
				Product product = session.createQuery("FROM Product WHERE productName = :productName", Product.class)
						.setParameter("productName", productName).uniqueResult();
				if (product != null) {
					product.setQuantity(product.getQuantity() - item.getQuantity());
					product.setSold(product.getSold() + item.getQuantity());
					session.merge(product);
				}
			}
			transaction.commit();
			return true;
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while updating product stock: " + e.getMessage());
			return false;
		}
	}

	public List<Product> searchProductByName(String productName) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Product WHERE productName LIKE :productName OR category LIKE :productName";
			return session.createQuery(hql, Product.class).setParameter("productName", "%" + productName + "%").list();
		} catch (Exception e) {
			System.out.println("Error retrieving products: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	public List<Product> getProductByType(String type) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Product WHERE type = :type";
			return session.createQuery(hql, Product.class).setParameter("type", type).list();
		} catch (Exception e) {
			System.out.println("Error retrieving products: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	public List<Product> getProductByCategory(String category) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Product WHERE category = :category";
			return session.createQuery(hql, Product.class).setParameter("category", category).list();
		} catch (Exception e) {
			System.out.println("Error retrieving products: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	public Product getProductById(int id) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Product WHERE productId = :productId";
			return session.createQuery(hql, Product.class).setParameter("productId", id).uniqueResult();
		} catch (Exception e) {
			System.out.println("Error retrieving product: " + e.getMessage());
			return null;
		}
	}

	public List<Product> getAllProducts() {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Product";
			return session.createQuery(hql, Product.class).list();
		} catch (Exception e) {
			System.out.println("Error retrieving products: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	public List<Product> getAllActiveProducts() {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			// HQL query to retrieve all active products
			String hql = "FROM Product WHERE status = 1";
			return session.createQuery(hql, Product.class).list();
		} catch (Exception e) {
			System.out.println("Error retrieving products: " + e.getMessage());
			return new ArrayList<>(); // Return an empty list in case of an error
		}
	}

	public void addNewProduct(Product product) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();

			session.persist(product);

			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while adding product: " + e.getMessage());
		}
	}

	public void deleteProduct(int productId) {
		Transaction transaction = null;

		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();

			Product product = session.get(Product.class, productId);

			if (product != null) {
				product.setStatus(0);
				session.merge(product);
				System.out.println("Product status set to 0 (disabled) successfully.");
			} else {
				System.out.println("Product not found with ID: " + productId);
			}

			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while disabling product: " + e.getMessage());
		}
	}

	public void editProduct(Product product) {
		Transaction transaction = null;

		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			session.merge(product);
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null)
				transaction.rollback();
			System.out.println("Error editing product: " + e.getMessage());
		}
	}
}
