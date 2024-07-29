#!/bin/bash

curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d '{
    "name": "source-connector",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "topic.prefix": "debezium.test",
        "database.hostname": "mysql",
        "database.port": "3306",
        "database.user": "root",
        "database.password": "debezium",
        "database.server.id": "185154",
        "database.include.list": "source",
        "table.include.list": "source.members",
        "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
        "schema.history.internal.kafka.topic": "debezium.schema-changes",
        "topic.creation.enable": "true",
        "topic.creation.default.replication.factor": "1",
        "topic.creation.default.partitions": "12",
        "topic.creation.default.cleanup.policy": "compact",
        "transforms": "route",
        "transforms.route.type": "io.debezium.transforms.ByLogicalTableRouter",
        "transforms.route.topic.regex": "debezium.test.([^.]+)\\.([^.]+)\\.([^.]+)",
        "transforms.route.topic.replacement": "test_$3",
        "transforms.route.key.enforce.uniqueness": "true",
        "converters": "timestampConverter",
        "timestampConverter.type": "oryanmoshe.kafka.connect.util.TimestampConverter",
        "timestampConverter.format.datetime": "YYYY-MM-dd HH:mm:ss",
        "timestampConverter.debug": "false"
    }
}'

curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d '{
    "name": "jdbc-connector",
    "config": {
        "connector.class": "io.debezium.connector.jdbc.JdbcSinkConnector",
        "tasks.max": "1",
        "topics.regex": "debezium.test.(.*)",
        "connection.url": "jdbc:mysql://mysql:3306/destination",
        "connection.username": "root",  
        "connection.password": "debezium",
        "schema.evolution": "basic",
        "quote.identifiers":"true",
        "primary.key.mode": "record_key",
        "primary.key.fields": "id",
        "insert.mode": "upsert",
        "table.name.format": "debezium_source_members",
        "delete.enabled": "true",
        "transforms": "timestamp",
        "transforms.timestamp.type":"oryanmoshe.kafka.connect.util.InsertTimestampTransform",
        "hibernate.c3p0.idle_test_period": "300"
    }
}'

