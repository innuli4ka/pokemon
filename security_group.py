import boto3
from constants import REGION

GROUP_NAME = "innas-security-group"
DESCRIPTION = "innas security group"
VPC_ID = "vpc-06963637bc8bb3a2b"

def create_security_group():
    ec2 = boto3.client("ec2", region_name=REGION)

    try:
        response = ec2.create_security_group(
            GroupName=GROUP_NAME,
            Description=DESCRIPTION,
            VpcId=VPC_ID
        )
        security_group_id = response['GroupId']
        print(f"Created security group: {GROUP_NAME} ({security_group_id})")

        # Add SSH access rule (port 22)
        ec2.authorize_security_group_ingress(
            GroupId=security_group_id,
            IpPermissions=[
                {
                    'IpProtocol': 'tcp',
                    'FromPort': 22,
                    'ToPort': 22,
                    'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
                }
            ]
        )
        print("SSH rule added (port 22 open to 0.0.0.0/0)")

        return security_group_id

    except Exception as e:
        print("Failed to create security group:", e)
        return None

if __name__ == "__main__":
    create_security_group()
