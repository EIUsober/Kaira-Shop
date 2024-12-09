package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import context.DBContext;
import entity.Task;

public class TaskDAO {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public TaskDAO() {
	}
	
	public void updateTaskStatus(String status, String taskID) {
        String query = "update task set status = '" + status + "' where task_id = '" + taskID + "'";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
	
	public ArrayList<Task> getTaskByStaffId(String id) {
		ArrayList<Task> list = new ArrayList<Task>();
		String query = "SELECT * FROM Task where assignee_id = '"+ id +"'";
		try {
			con = DBContext.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery(query);
			while (rs.next()) {
				LocalDateTime dateTime = rs.getTimestamp(2).toLocalDateTime();
				Task task = new Task(rs.getString(1), dateTime, rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6));
				list.add(task);
			}
			ps.close();
			con.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return list;
	}
	
	public void addTask(Task t) {
        String query = "insert into task (created_date, creator_id, assignee_id, status, description) "
                + "values ('" + t.getCreatedTime() + "','" + t.getTaskGiverId() + "','" + t.getAssigneeId() + "',"
                + "'Undone','" + t.getDescription() + "')";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
	
	public ArrayList<Task> getAllTasks() {
		ArrayList<Task> list = new ArrayList<Task>();
		String query = "SELECT * FROM Task";
		try {
			con = DBContext.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery(query);
			while (rs.next()) {
				LocalDateTime dateTime = rs.getTimestamp(2).toLocalDateTime();
				Task task = new Task(rs.getString(1), dateTime, rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6));
				list.add(task);
			}
			ps.close();
			con.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return list;
	}
}
