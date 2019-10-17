from elasticsearch import Elasticsearch
import json

client = Elasticsearch(hosts=["elastic:9200"])


def main():
    with open("./ArQiZjKz.json", mode="r") as file:
        data = json.load(file)

    for item in data['data']:
        print(client.index(index="test-index", body=item['_source']))
    


if __name__ == "__main__":
    main()