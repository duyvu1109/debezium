# Custom Debezium Connect

**Description:**
Custom Debezium Connect is an enhanced version of the open-source Debezium Connect platform, tailored to specific business requirements. This project incorporates custom connectors, Prometheus integration for robust monitoring, and additional features to optimize data ingestion and transformation pipelines.


**Usage:**
```
docker build -t debezium:<custom_tag> .
```

**Development**
```
docker compose up -d --build
bash register.sh
```