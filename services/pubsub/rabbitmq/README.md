# RabbitMQ

- https://www.rabbitmq.com/tutorials/tutorial-one-python

## Usage

1. Create a virutal environment: `pyenv virtualenv rabbitmq`, `pyenv activate rabbitmq`
2. Install pika `pip3 install pika --upgrade`
3. Start broker with `docker-compose up -d`
4. From one terminal, start listener: `python3 receive.py`
5. From another, publish message: `python3 send.py`