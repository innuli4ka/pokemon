from security_group import create_security_group
from launch_instance import launch_instance
import os

from constants import SECURITY_GROUP_ID

def update_constants_file(new_sg_id):
    lines = []
    with open("constants.py", "r") as f:
        for line in f:
            if line.startswith("SECURITY_GROUP_ID"):
                lines.append(f'SECURITY_GROUP_ID = "{new_sg_id}"\n')
            else:
                lines.append(line)
    with open("constants.py", "w") as f:
        f.writelines(lines)
    print(f"Updated SECURITY_GROUP_ID in constants.py to {new_sg_id}")

def deploy():
    if not SECURITY_GROUP_ID:
        print("No SECURITY_GROUP_ID found. Creating new security group...")
        sg_id = create_security_group()
        if sg_id:
            update_constants_file(sg_id)
        else:
            print("Failed to create security group. Aborting.")
            return
    else:
        print("Using existing SECURITY_GROUP_ID from constants.py")

    print("Launching EC2 instance...")
    launch_instance()

if __name__ == "__main__":
    deploy()
