#!/bin/bash

word=$1

# Retrieving article IDs
id_url="https://ord.uib.no/api/articles?w="$1"&dict=bm%2Cnn&wc=NOUN&scope=eif"
id_json=$(curl -s -X 'GET' "$id_url" -H 'accept: application/json')
bm_ids=$(echo $id_json | jq '.["articles"]' | jq '.["bm"]')
nn_ids=$(echo $id_json | jq '.["articles"]' | jq '.["nn"]')

# Cleaning ID lists
bm_ids=$(echo $bm_ids | sed 's/\[//g' | sed 's/\]//g'  | sed 's/,//g')
nn_ids=$(echo $nn_ids | sed 's/\[//g' | sed 's/\]//g'  | sed 's/,//g')

# Fetching definitions
for id in $bm_ids
do
  article_url="https://ord.uib.no/bm/article/"$id".json"
  article_json=$(curl -s -X 'GET' $article_url -H 'accept: application/json')
  definition=$(echo $article_json | jq '.body.definitions[0].elements[0].content')
  if [ "$definition" == "null" ]
  then
    definition=$(echo $article_json | jq '.body.definitions[0].elements[0].elements[0].content')
  fi
  definition_clean=$(echo $definition | sed 's/\"//g')
  echo $id ":" $definition_clean
done
