import urllib.request, json
import wget

with urllib.request.urlopen("https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") as url:
    data = json.loads(url.read().decode())

    for state in data['products']:
        for x in state['images']:
            wget.download(x['src'])
