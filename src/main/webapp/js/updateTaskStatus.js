function updateStatus() {
                if (confirm('Update Success!')) {
                    window.location.href = 'http://localhost:8080/CSE456/StaffControl?mode=viewTaskByStaffId';
                } else {
                    return false;
                }
            }