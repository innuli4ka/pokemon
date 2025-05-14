import json
import os

DB_FILE = "pokemon_db.json"

def load_pokemon_db():
    if not os.path.exists(DB_FILE):
        return {}
    with open(DB_FILE, "r") as file:
        return json.load(file)

def save_pokemon_to_db(pokemon):
    db = load_pokemon_db()
    db[pokemon["name"]] = pokemon
    with open(DB_FILE, "w") as file:
        json.dump(db, file, indent=4)
