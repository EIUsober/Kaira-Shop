package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import entity.Cart;
import entity.CartItem;
import entity.Product;
import entity.UserAccount;
import util.HibernateUtil;

public class CartDAO {
	public CartDAO() {
	}

	public Cart getCartByUserId(int userId) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Cart WHERE user.id = :userId";
			return session.createQuery(hql, Cart.class).setParameter("userId", userId).uniqueResult();
		}
	}

	public void addItemToCart(int userId, Product product, int quantity) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();

			// Fetch the cart
			Cart cart = session.createQuery("FROM Cart WHERE user.id = :userId", Cart.class)
					.setParameter("userId", userId).uniqueResult();
			if (cart == null) {
				UserAccount user = session.get(UserAccount.class, userId);
				cart = new Cart(user);
				session.persist(cart);
			}

			// Check if the item already exists in the cart
			CartItem cartItem = cart.getItems().stream()
					.filter(item -> item.getProduct().getProductId() == product.getProductId()).findFirst()
					.orElse(null);

			if (cartItem == null) {
				// Add new cart item
				cartItem = new CartItem();
				cartItem.setCart(cart);
				cartItem.setProduct(product);
				cartItem.setQuantity(quantity);
				session.persist(cartItem);
				cart.getItems().add(cartItem);
			} else {
				// Update quantity for existing item
				cartItem.setQuantity(cartItem.getQuantity() + quantity);
				session.merge(cartItem);
			}
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				e.printStackTrace();
				transaction.rollback();
			}
			System.out.println("Error while adding item to cart: " + e.getMessage());
		}
	}

	public void removeItemFromCart(int cartItemId) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			CartItem cartItem = session.get(CartItem.class, cartItemId);
			if (cartItem != null) {
				Cart cart = cartItem.getCart();
				cart.getItems().remove(cartItem);
				session.remove(cartItem);
			}
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			System.out.println("Error while removing item from cart: " + e.getMessage());
		}
	}

	public List<CartItem> getAllItems(int userId) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			String hql = "FROM Cart WHERE user.id = :userId";
			Cart cart = session.createQuery(hql, Cart.class).setParameter("userId", userId).uniqueResult();
			if (cart != null) {
				Hibernate.initialize(cart.getItems());
				return cart.getItems();
			} else {
				return new ArrayList<>();
			}
		} catch (Exception e) {
			System.out.println("Error while retrieving items from cart: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	public void deleteAllItems(int userId) {
	    Transaction transaction = null;
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        transaction = session.beginTransaction();

	        String hql = "FROM Cart WHERE user.id = :userId";
	        Cart cart = session.createQuery(hql, Cart.class)
	                           .setParameter("userId", userId)
	                           .uniqueResult();
	        if (cart != null) {
	            for (CartItem item : cart.getItems()) {
	                session.remove(item);
	            }
	            cart.getItems().clear();
	        }

	        transaction.commit();
	    } catch (Exception e) {
	        if (transaction != null) {
	            transaction.rollback();
	        }
	        System.out.println("Error while deleting items from cart: " + e.getMessage());
	    }
	}


}
