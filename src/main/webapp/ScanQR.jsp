<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QR Code Scanner</title>
</head>
<body>

<h2>Scan QR Code Using Camera</h2>

<!-- Video element to display the camera stream -->
<video id="preview" width="400" height="300"></video>

<!-- Display the scanned QR code data -->
<div>
    <h3>Scanned QR Code Data: <span id="qrCodeResult"></span></h3>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/instascan/1.0.0/instascan.min.js"></script>
<script>
    // Initialize the scanner and set up the camera
    let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });
    scanner.addListener('scan', function (content) {
        document.getElementById('qrCodeResult').textContent = content;
        // Here you can send the scanned content to the server if needed
    });

    // Request camera permissions and start scanning
    Instascan.Camera.getCameras().then(function (cameras) {
        if (cameras.length > 0) {
            scanner.start(cameras[0]); // Use the first available camera
        } else {
            console.error('No cameras found.');
            alert('No cameras found on this device.');
        }
    }).catch(function (e) {
        console.error(e);
        alert('Error accessing the camera: ' + e.message);
    });

</script>

</body>
</html>
