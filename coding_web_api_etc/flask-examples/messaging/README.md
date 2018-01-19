Celery / rabbitMQ example
=========================

Ref: https://www.digitalocean.com/community/tutorials/how-to-use-celery-with-rabbitmq-to-queue-tasks-on-an-ubuntu-vps

* Requirements and steps:

- In terminal one:
```
	sudo yum install python-pip rabbitmq-server
	sudo pip install virtualenv
	sudo rabbitmq-server
```

- In terminal two:
```
	virtualenv venv
	source venv/bin/activate
	pip install celery
	celery worker -A tasks &
	python run.py
```
