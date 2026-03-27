#  WordPress Deployment on AWS using Terraform

This project demonstrates how to deploy a **WordPress website on AWS** using **Terraform**, with an EC2 instance hosting the application and an RDS MySQL database as the backend.

Below is a step-by-step guide to help you understand and implement the project.

---

## 1. Launch Infrastructure using Terraform

This project uses Terraform to provision:

* EC2 Instance (Amazon Linux)
* RDS MySQL Database
* Security Groups
* Default VPC

### Initialize Terraform

```bash
terraform init
```

### Deploy Infrastructure

```bash
terraform apply -var="key_name=YOUR_KEY_NAME"
```

> ⚠️ Important: Use the AWS key pair **name only**, not the `.pem` file.

---

## 2. Connect to Your EC2 Instance

After deployment, copy the EC2 public IP and connect using SSH:

```bash
ssh -i /path/to/your-key.pem ec2-user@your-ec2-public-ip
```

---

## 3. Install and Configure Apache & PHP

Update system packages:

```bash
sudo yum update -y
```

Install required packages:

```bash
sudo yum install -y httpd php php-mysqlnd wget
```

Start and enable Apache:

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
```

You should see:

```text
active (running)
```

---

## 4. Access the Web Server

Open your browser and navigate to:

```text
http://your-ec2-public-ip
```

You should see the Apache default page.

---

## 5. Download and Set Up WordPress

Navigate to the web root directory:

```bash
cd /var/www/html
```

Download WordPress:

```bash
sudo wget https://wordpress.org/latest.tar.gz
```

Extract files:

```bash
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* .
sudo rm -rf wordpress latest.tar.gz
```

---

## 6. Configure WordPress

Create configuration file:

```bash
sudo cp wp-config-sample.php wp-config.php
```

Edit the file:

```bash
sudo vi wp-config.php
```

Update the following values:

```php
define('DB_NAME', 'wordpress');
define('DB_USER', 'your_db_username');
define('DB_PASSWORD', 'your_db_password');
define('DB_HOST', 'your_rds_endpoint');
```

---

## 7. Set Permissions

```bash
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## 8. Access WordPress Setup

Open your browser:

```text
http://your-ec2-public-ip
```

You should see the WordPress setup page.

---

## 9. Complete Installation

* Choose language
* Enter site details
* Create admin user
* Click Install

🎉 Your WordPress site is now live!

---

## 10. Configure RDS Database

Ensure your RDS instance is:

* Running
* Accessible from EC2 (via security group)
* Using correct credentials

> ⚠️ Note: RDS may take a few minutes to become available after deployment.

---

## 11. Common Issues & Fixes

### ❌ Connection Refused

* Apache not running:

```bash
sudo systemctl start httpd
```

---

### ❌ Permission Denied (SSH)

```bash
chmod 400 your-key.pem
```

---

### ❌ Invalid Key Pair

* Ensure correct key name is used in Terraform:

```bash
-var="key_name=yourkey"
```

---

### ❌ WordPress Not Loading

Check files:

```bash
ls /var/www/html
```

---

### ❌ Database Connection Error

* Wait for RDS to finish initializing
* Verify DB credentials

---

## 12. Project Structure

```bash
.
├── main.tf
├── variables.tf
├── outputs.tf
├── user_data.sh
```

---

## 13. Cleanup Resources

To destroy all resources:

```bash
terraform destroy
```

---

## 🔧 Future Improvements

* Add HTTPS (SSL/TLS)
* Use Load Balancer (ALB)
* Enable Auto Scaling
* Store Terraform state in S3
* Add monitoring with CloudWatch

---

## 📌 Conclusion

This project demonstrates how to deploy a real-world application using:

* Terraform (Infrastructure as Code)
* AWS EC2 + RDS
* Apache + PHP
* WordPress

It also highlights practical debugging and troubleshooting skills required in real DevOps environments.

---
