## README

The goal of this project is to allow a user to run a single file (`deploy.py`) that performs the following actions:

1. Creates a new Security Group that allows SSH access
2. Launches a new EC2 instance with all necessary configuration
3. Runs the `userdata.sh` script automatically when the instance boots
4. When the user connects via SSH, the `ui.py` file will run automatically

---

### Prerequisites

* An active AWS account with permissions to launch EC2 instances
* A `.pem` key file matching the key name defined in `constants.py`
* `boto3` and `python3` installed on your machine

---

### The `constants.py` file should include:

python
AMI_ID" = "ami-xxxxxxxxxxxxxxxxx"
KEY = "your-key-name"
REGION = "us-west-2"
SECURITY_GROUP_ID = ""  # Leave empty, the script will create one automatically
USER_DATA_FILE = "userdata.sh"

---

### How to run

1. Edit `constants.py` with your values
2. Run the following command:

   bash
   python3 deploy.py
   
3. If everything worked, a public IP address will be printed
4. Connect to the server:

   bash
   ssh -i your-key.pem ubuntu@<public-ip>
   
5. Once connected, the `ui.py` app will run automatically

---

### File structure

| File               | Description                                         |
| -------------------| --------------------------------------------------- |
| deployment.py      | Main script that runs the entire process            |
| constants.py       | Contains static configuration values                |
| security_group.py  | Creates a new security group with SSH enabled       |
| launch_instance.py | Launches the EC2 instance with the correct settings |
| userdata.sh        | Script that runs automatically on instance startup  |
| ui.py              | Your main app that runs when user connects via SSH  |

---

If something doesn't work, first check that all variables in `constants.py` are correctly set.

