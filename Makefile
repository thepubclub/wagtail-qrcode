poetry:
	poetry install

test:
	poetry run python testmanage.py test

lint:
	pre-commit run --all-files

add:
	git add .

commit:
	git commit

push:
	git push

dev:
	wagtail start sandbox
	rm sandbox/.dockerfiles sandbox/Dockerfile sandbox/requirements.txt sandbox/.dockerignore

dev-delete:
	rm -rf sandbox

run:
	poetry run sandbox/manage.py runserver

migrate:
	poetry run sandbox/manage.py migrate
