# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: latest-mifos-ui Makefile help
# help:

UNAME := $(shell uname)

.PHONY: help
# help: help				- Please use "make <target>" where <target> is one of
help:
	@grep "^# help\:" Makefile | sed 's/\# help\: //' | sed 's/\# help\://'

.PHONY: ba
# help: ba				- build application
ba:
	@cd web-app; docker compose -f docker-compose.yml up --build -d; cd ..

.PHONY: cp
# help: cp				- cp out latest build files
cp:
	@cp ~/devcode/fineract/containers/nginx/html/assets/.env.js ~/Desktop
	@rm -rf ~/devcode/fineract/containers/nginx/html/

	@docker cp web-app-mifosx-web-app-1:/usr/share/nginx/html ~/devcode/fineract/containers/nginx/

	@mv ~/Desktop/.env.js ~/devcode/fineract/containers/nginx/html/assets/.env.js
	@rm ~/devcode/fineract/containers/nginx/html/assets/env.js
