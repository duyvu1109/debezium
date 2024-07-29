FROM quay.io/debezium/connect:2.6

# Deploy MySQL JDBC Driver
COPY ./plugins/mysql-connector-j-8.4.0.jar /kafka/libs

# custom timestamp converter
COPY ./plugins/TimestampConverter-1.2.3-SNAPSHOT.jar ${KAFKA_CONNECT_PLUGINS_DIR}/debezium-connector-jdbc/
COPY ./plugins/TimestampConverter-1.2.3-SNAPSHOT.jar ${KAFKA_CONNECT_PLUGINS_DIR}/debezium-connector-mysql/

# remove redundant plugins
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-ibmi
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-postgres
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-informix
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-spanner
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-sqlserver
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-vitess
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-mongodb
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-db2
RUN rm -rf $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-oracle

# copy metric configs for debezium
# https://github.com/debezium/debezium-examples/tree/main/monitoring/debezium-jmx-exporter
RUN mkdir /kafka/etc && cd /kafka/etc &&\
        curl -so jmx_prometheus_javaagent.jar \
        https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/1.0.0/jmx_prometheus_javaagent-1.0.0.jar

COPY ./plugins/jmx-exporter-config.yml /kafka/etc/jmx-exporter-config.yml


# custom jdbc
# RUN rm ${KAFKA_CONNECT_PLUGINS_DIR}/debezium-connector-jdbc/debezium-connector-*
# COPY debezium-connector-jdbc-3.0.0-SNAPSHOT.jar ${KAFKA_CONNECT_PLUGINS_DIR}/debezium-connector-jdbc/