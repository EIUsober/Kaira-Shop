document.addEventListener("DOMContentLoaded", function() {
        // Get the alert element
        const alertMessage = document.getElementById("editMessage");
        
        // Check if the element exists
        if (alertMessage) {
            // Set a timeout to hide the message after 2 seconds
            setTimeout(() => {
                alertMessage.style.display = "none";
            }, 2000); // 2000ms = 2 seconds
        }
    });