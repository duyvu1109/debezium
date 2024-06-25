#!/bin/bash

# command for testing
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:58767/connectors/ -d @source.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:58767/connectors/ -d @source-myhistory.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:58767/connectors/ -d @jdbc-sink.json
curl -X DELETE http://localhost:58767/connectors/source-connector -k
curl -X DELETE http://localhost:58767/connectors/source-connector-myhistory -k
curl -X DELETE http://localhost:58767/connectors/jdbc-sink -k


curl -X DELETE http://localhost:8083/connectors/jdbc-sink -k


curl http://localhost:8083/connectors/source-connector/status -k
curl http://localhost:8083/connectors/jdbc-sink-pig-service_wallets/status -k
curl http://localhost:8083/connectors/jdbc-sink-pig/status -k
