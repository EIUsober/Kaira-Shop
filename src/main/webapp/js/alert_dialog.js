function confirmDelete(productId) {
    if (confirm("Are you sure you want to delete this product?")) {
        // Navigate to the delete URL if confirmed
        window.location.href = `AdminControl?mode=deleteProduct&product_id=${productId}`;
    }
    // Do nothing if canceled
}
