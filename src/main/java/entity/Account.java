package entity;

public class Account {
	private String id;
	private String accountId;
	private String username;
	private String password;
	private int isAdmin;
	private int isActive;
	private String location;
	private String email;

	public Account(String id, String accountId, String username, String password, int isAdmin, int isActive,
			String email, String location) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
		this.isActive = isActive;
		this.location = location;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Account [id=" + id + ",accountId=" + accountId + ", username=" + username + ", password=" + password
				+ ", isAdmin=" + isAdmin + ", isActive=" + isActive + ", location=" + location + ", email=" + email
				+ "]";
	}

}
