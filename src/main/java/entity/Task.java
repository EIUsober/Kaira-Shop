package entity;

import java.time.LocalDateTime;

public class Task {
	private String taskId;
	private LocalDateTime createdTime;
	private String taskGiverId;
	private String assigneeId;
	private String status;
	private String description;
	
	public Task(String taskId, LocalDateTime createdTime, String taskGiverId, String assigneeId, String status,
			String description) {
		super();
		this.taskId = taskId;
		this.createdTime = createdTime;
		this.taskGiverId = taskGiverId;
		this.assigneeId = assigneeId;
		this.status = status;
		this.description = description;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalDateTime createdTime) {
		this.createdTime = createdTime;
	}

	public String getTaskGiverId() {
		return taskGiverId;
	}

	public void setTaskGiverId(String taskGiverId) {
		this.taskGiverId = taskGiverId;
	}

	public String getAssigneeId() {
		return assigneeId;
	}

	public void setAssigneeId(String assigneeId) {
		this.assigneeId = assigneeId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
