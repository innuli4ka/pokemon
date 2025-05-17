AMI_ID =  "ami-039f97a3f98ab3761"
KEY = "innas-key-pair"
INSTANCE_TYPE = "t2.micro"
UI_FILE = "ui.py"
REGION = "us-west-2"
USER_DATA_FILE = "user_data.sh"
SECURITY_GROUP_ID = "" # Need to fill after running security_group.py
API_BASE_URL = "https://pokeapi.co/api/v2"
POKEMON_LIST_URL = f"{API_BASE_URL}/pokemon?limit=10000&offset=0"
