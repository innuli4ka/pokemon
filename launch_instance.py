import boto3
from botocore.exceptions import ClientError
from constants import AMI_ID, INSTANCE_TYPE, KEY, USER_DATA_FILE, SECURITY_GROUP_ID, REGION

def launch_instance():
    if not SECURITY_GROUP_ID:
        print("ERROR: SECURITY_GROUP_ID is empty. Please run security_group.py first and update constants.py.")
        return

    ec2 = boto3.client("ec2", region_name=REGION)

    try:
        with open(USER_DATA_FILE, encoding="utf-8") as f:
            user_data_script = f.read()

        response = ec2.run_instances(
            ImageId=AMI_ID,
            InstanceType=INSTANCE_TYPE,
            KeyName=KEY,
            MinCount=1,
            MaxCount=1,
            SecurityGroupIds=[SECURITY_GROUP_ID],
            UserData=user_data_script,
            TagSpecifications=[{
                'ResourceType': 'instance',
                'Tags': [{'Key': 'Name', 'Value': 'MyAppInstance'}]
            }]
        )

        instance_id = response['Instances'][0]['InstanceId']
        print(f"EC2 instance launched: {instance_id}")

    except ClientError as e:
        print("ERROR: Failed to launch EC2 instance.")
        print("AWS response:")
        print(e.response['Error']['Message'])

    except Exception as e:
        print("An unexpected error occurred:")
        print(str(e))
