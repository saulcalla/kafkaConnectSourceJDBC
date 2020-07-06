ARG CONFLUENT_VERSION=5.5.0

FROM confluentinc/cp-kafka-connect-base:${CONFLUENT_VERSION}

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:0.3.2  \
	&& confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest

ADD ojdbc6.jar /tmp/connect/lib/ojdbc6.jar

#ADD delta_configs/ak-tools-ccloud.delta /tmp/ak-tools-ccloud.delta

#ENV  CONNECT_BOOTSTRAP_SERVERS 'pkc-419q3.us-east4.gcp.confluent.cloud:9092'
ENV  CONNECT_REST_PORT 8083
ENV  CONNECT_GROUP_ID "connect"
ENV  CONNECT_CONFIG_STORAGE_TOPIC connect-configs
ENV  CONNECT_OFFSET_STORAGE_TOPIC connect-offsets
ENV  CONNECT_STATUS_STORAGE_TOPIC connect-statuses
ENV  CONNECT_REPLICATION_FACTOR 3
ENV  CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR 3
ENV  CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR 3
ENV  CONNECT_STATUS_STORAGE_REPLICATION_FACTOR 3
ENV  CONNECT_KEY_CONVERTER "org.apache.kafka.connect.storage.StringConverter"
ENV  CONNECT_VALUE_CONVERTER "io.confluent.connect.avro.AvroConverter"
ENV  CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE "true"
ENV  CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL https://psrc-l7opw.europe-west3.gcp.confluent.cloud
ENV  CONNECT_VALUE_CONVERTER_BASIC_AUTH_CREDENTIALS_SOURCE USER_INFO
#ENV  CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO 5AQX3ORUCM2FWRTL:UAKDGvgqYLGlwJ4hhRRhPJXWMDT3McUKnVV3i7PFwiqjqvdikXUhHEbdi6D1D/IT
ENV  CONNECT_INTERNAL_KEY_CONVERTER "org.apache.kafka.connect.json.JsonConverter"
ENV  CONNECT_INTERNAL_VALUE_CONVERTER "org.apache.kafka.connect.json.JsonConverter"
ENV  CONNECT_REST_ADVERTISED_HOST_NAME "connect"
ENV  #CONNECT_PLUGIN_PATH "/usr/share/java,/usr/share/confluent-hub-components"
ENV  CONNECT_LOG4J_ROOT_LOGLEVEL INFO
ENV  CONNECT_LOG4J_LOGGERS org.reflections=ERROR
ENV  # CLASSPATH required due to CC-2422
ENV  CLASSPATH /usr/share/java/monitoring-interceptors/monitoring-interceptors-${CONFLUENT_VERSION}.jar:/tmp/connect/lib/ojdbc6.jar
ENV  # Connect worker
ENV  CONNECT_SECURITY_PROTOCOL SASL_SSL
#ENV  CONNECT_SASL_JAAS_CONFIG 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
#ENV  SASL_JAAS_CONFIG_PROPERTY_FORMAT 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
ENV  CONNECT_SASL_MECHANISM PLAIN
ENV  CONNECT_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM "HTTPS"
ENV  # Connect producer
ENV  CONNECT_PRODUCER_SECURITY_PROTOCOL SASL_SSL
#ENV  CONNECT_PRODUCER_SASL_JAAS_CONFIG 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
ENV  CONNECT_PRODUCER_SASL_MECHANISM PLAIN
ENV  CONNECT_PRODUCER_INTERCEPTOR_CLASSES "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"
ENV  CONNECT_PRODUCER_CONFLUENT_MONITORING_INTERCEPTOR_SECURITY_PROTOCOL SASL_SSL
#ENV  CONNECT_PRODUCER_CONFLUENT_MONITORING_INTERCEPTOR_SASL_JAAS_CONFIG 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
ENV  CONNECT_PRODUCER_CONFLUENT_MONITORING_INTERCEPTOR_SASL_MECHANISM PLAIN
ENV  # Connect consumer
ENV  CONNECT_CONSUMER_SECURITY_PROTOCOL SASL_SSL
#ENV  CONNECT_CONSUMER_SASL_JAAS_CONFIG 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
ENV  CONNECT_CONSUMER_SASL_MECHANISM PLAIN
ENV  CONNECT_CONSUMER_INTERCEPTOR_CLASSES "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"
ENV  CONNECT_CONSUMER_CONFLUENT_MONITORING_INTERCEPTOR_SECURITY_PROTOCOL SASL_SSL
#ENV  CONNECT_CONSUMER_CONFLUENT_MONITORING_INTERCEPTOR_SASL_JAAS_CONFIG 'org.apache.kafka.common.security.plain.PlainLoginModule   required username="BK7FTHVPHDR6VHUD"   password="OgBhS5FtNk74yLbZS+a4/Tk5xXCvWvvCfUhvleiw06wxr1oy9u91OFvo4i5cwrTf";'
ENV  CONNECT_CONSUMER_CONFLUENT_MONITORING_INTERCEPTOR_SASL_MECHANISM PLAIN