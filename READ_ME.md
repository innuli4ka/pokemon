# Pokémon Drawer — Terraform Deployment

This project deploys an EC2 instance with a Pokémon drawing app that uses DynamoDB.
When you SSH into the instance, the app runs automatically.

---

## **Requirements**

- Terraform installed
- AWS credentials (**access key**, **secret key**, **session token**) — sandbox users use a temporary session token
- An existing key pair in AWS (e.g. `vockey`)

---

##  **How to use**

1️⃣ **Check your Terraform variables**  
Update `main.tf` if needed.  
This setup uses this tested **Ubuntu AMI**:  
