
import json

if __name__ == "__main__":
    with open('./scripts/ast.json') as fd:
        obj = json.load(fd)
        print(obj)
