# .PHONY: list
# list:
# 	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Commands for development"
	@echo "====================================================================="
	@echo "   admin:	Create superuser"
	@echo "    mail:	Start mail server"
	@echo " migrate:	Apply migrations"
	@echo "     run:	Run the development server"
	@echo "    test:	Run tests"

admin:
	@echo "from django.contrib.auth import get_user_model; get_user_model().objects.create_superuser('test', 'test@test.com', 'test')" | uv run manage.py shell
	@echo "Created superuser with username 'test' and password 'test'"

mail:
	@echo "Starting mail server"
	@docker rm -f mailhog
	@cp tests/local.py.example tests/local.py
	@docker run -it -p 8025:8025 -p 1025:1025 --name mailhog mailhog/mailhog

migrate:
	@uv run manage.py migrate

run:
	@uv run manage.py runserver 0.0.0.0:8000

test:
	@echo "Running tests..."
	@uv run coverage run manage.py test --deprecation all
	@uv run coverage report -m

