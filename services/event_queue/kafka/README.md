# Kafka

- https://kafka.apache.org/quickstart

## Usage

1. Start kafka with `docker-compose up -d`
2. Install kafka CLI: `brew install kafka`
3. Create a topic: `kafka-topics --create --topic quickstart-events --bootstrap-server localhost:9092`
4. Start a producer: `kafka-console-producer --topic quickstart-events --bootstrap-server localhost:9092`
5. Start a consumer: `kafka-console-consumer --topic quickstart-events --from-beginning --bootstrap-server localhost:9092`
6. Write some messages into the producer console