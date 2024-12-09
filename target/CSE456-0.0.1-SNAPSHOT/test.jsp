<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>Shopping Cart</title>
</head>
<body>
    <h1>Shopping Cart</h1>
    <table>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.product.productName}</td>
                <td>${item.quantity}</td>
                <td>${item.product.price}</td>
                <td>${item.product.price * item.quantity}</td>
                <td>
                    <form action="UserControl?mode=removeFromCart" method="post">
                        <input type="hidden" name="cartId" value="${item.cart.id}" />
                        <input type="hidden" name="cartItemId" value="${item.id}" />
                        <input type="hidden" name="action" value="remove" />
                        <button type="submit">Remove</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <form action="UserControl?mode=getAllProducts" method="get">
        <button type="submit">Continue Shopping</button>
    </form>
</body>
</html>
