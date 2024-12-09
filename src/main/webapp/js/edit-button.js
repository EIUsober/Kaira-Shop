document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function() {
                const productId = this.getAttribute('data-id');
                
                // Set the product ID in the modal form
                document.getElementById('productId').value = productId;

                // Optionally, you can load additional product details here via AJAX if needed
            });
        });

        // Function to submit the edit form
        function submitEditForm() {
            const form = document.getElementById('editForm');
            const productId = form.productId.value;
            const productName = form.productName.value;
            
            // Add form submission logic here, e.g., sending data via AJAX
            console.log(`Submitting form for Product ID: ${productId}, Product Name: ${productName}`);
            
            // Close the modal after submission
            $('#editModal').modal('hide');
        }