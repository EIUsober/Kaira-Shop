package dao;

import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import entity.Account;
import entity.Product;

public class AccountDAO {

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public AccountDAO() {
	}

	public void enableUser(String id) {
        String query = "update account set isActive = '1' where account_id = '" + id + "'";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void disableUser(String id) {
        String query = "update account set isActive = '0' where account_id = '" + id + "'";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
	
    public void addStaffAccount(String username, String password, String location, String email){
        password = doHashing(password);
        String query = "insert into account (username, password, location, email, isActive, isAdmin) values ('" + username + "','" + password + "','" + location + "','" + email + "', '1', '0')";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void addNormalUser(String username, String password, String location, String email){
        password = doHashing(password);
        String query = "insert into account_user (username, password, location, email) values ('" + username + "','" + password + "','" + location + "','" + email + "')";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
	
    public Account getAccount(Account a){
        try {
            String query = "select * from account where account_id = '" + a.getAccountId() + "'";
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
            while (rs.next()) {
                return new Account(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8)
                );
            }
            con.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
	public ArrayList<Account> getAllAccounts() {
		ArrayList<Account> list = new ArrayList<Account>();
		String query = "SELECT * FROM account";
		try {
			con = DBContext.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery(query);
			while (rs.next()) {
				Account acc = new Account(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8));
				list.add(acc);
			}
			ps.close();
			con.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return list;
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
}
