import requests
import random
from readapi import API_BASE_URL, POKEMON_LIST_URL
from db import load_pokemon_db, save_pokemon_to_db

def get_pokemon_data(name_or_id):
    db = load_pokemon_db()
    if str(name_or_id).lower() in db:
        return db[str(name_or_id).lower()]

    url = f"{API_BASE_URL}/pokemon/{name_or_id}"
    response = requests.get(url)

    if response.status_code != 200:
        print("Error: Pokémon not found.")
        return None

    data = response.json()
    pokemon_info = {
        "id": data["id"],
        "name": data["name"],
        "height": data["height"],
        "weight": data["weight"],
        "types": [t["type"]["name"] for t in data["types"]]
    }

    save_pokemon_to_db(pokemon_info)
    return pokemon_info

def print_pokemon_info(pokemon):
    print(f"ID: {pokemon['id']}")
    print(f"Name: {pokemon['name']}")
    print(f"Height: {pokemon['height']}")
    print(f"Weight: {pokemon['weight']}")
    print(f"Types: {', '.join(pokemon['types'])}")

def get_random_pokemon_data():
    response_random = requests.get(POKEMON_LIST_URL)
    data_random = response_random.json()
    results = data_random["results"]

    random_pokemon = random.choice(results)
    random_name = random_pokemon["name"]

    return get_pokemon_data(random_name)

random_pokemon = get_random_pokemon_data()
