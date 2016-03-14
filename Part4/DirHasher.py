import hashlib
import json
import requests
from os import listdir
from os.path import isfile, join


hasher = hashlib.md5()
knownVir = []
results = []

def checkThis (resHash, fileName):
    r = requests.get("https://cymon.io/api/nexus/v1/malware/" + resHash + "/events").json()
    if r['count'] == 0:
        print("Hash: " + resHash + "\nsafe")
    else :
		results.append(r)
        last = r['count']-1
        print("Hash: " + resHash + "\n FILE NOT SAFE!")
        print("Flagged as: " + r['results'][last]['tag'])
        knownVir.append(fileName)    

def hashThis (folder):
    files = listdir(folder)
    for i in files :
        thisFile = join(folder,i)
        if isfile(thisFile):
            
            print("\n----\nFile Name: " + i)    
            with open(thisFile, 'rb') as afile:
                buf = afile.read()
                hasher.update(buf)
                checkThis(hasher.hexdigest(), i)                



print("==========\nWelcome to Malware Scanner using Cymon\n==========")
folder = input('What directory would you like to scan? ')

hashThis(folder)
    
print("\n\n===========RESULT===========\nMalicious files found: ", len(knownVir))
print(', '.join(knownVir))



with open('output.csv', 'w') as csvfile:
    fieldnames = ['title', 'tag', 'count']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

	foreach( $results as $res)
    writer.writerow({'title': res['results'][0]['title'], 'tag': res['results'][0]['tag'], 'count': res['count']})






