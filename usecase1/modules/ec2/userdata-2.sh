#!/bin/bash
# Update system
yum update -y

# Install Apache
yum install httpd -y

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

mkdir /var/www/html/registers
# Create a simple HTML page
cat <<EOF > /var/www/html/registers/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Amazon Linux Web Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            text-align: center;
            padding-top: 100px;
        }
        h1 {
            color: #333;
        }
        p {
            font-size: 18px;
            color: #666;
        }
    </style>
</head>
<body>
    <h1>Welcome to Your Amazon Linux Web Server!</h1>
    <p>Page 3. Register </p>
</body>
</html>
EOF

sudo ln -s /var/www/html/registers/index.html /var/www/html/index.html
