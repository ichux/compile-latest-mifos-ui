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

.PHONY: bwa
# help: bwa				- build web app
bwa:
	@cd web-app; BUILDKIT_PROGRESS=plain docker compose -f docker-compose.yml up --build -d; cd ..

.PHONY: cpwa

# help: cpwa				- cp out latest build files of web app
cpwa:
	@cp ~/devcode/fineract/containers/nginx/web-app/assets/.env.js ~/Desktop
	@cp ~/devcode/fineract/containers/nginx/web-app/assets/env.js ~/Desktop
	@rm -rf ~/devcode/fineract/containers/nginx/web-app/

	@docker cp web-app-mifosx-web-app-1:/usr/share/nginx/html ~/devcode/fineract/containers/nginx/web-app

	@mv ~/Desktop/.env.js ~/devcode/fineract/containers/nginx/web-app/assets/.env.js
	@mv ~/Desktop/env.js ~/devcode/fineract/containers/nginx/web-app/assets/env.js

	@#------
	@cp ~/devcode/lite-fineract/web-app/assets/env.js ~/Desktop
	@rm -rf ~/devcode/lite-fineract/web-app
	@cp -r ~/devcode/fineract/containers/nginx/web-app ~/devcode/lite-fineract
	@mv ~/Desktop/env.js ~/devcode/lite-fineract/web-app/assets/env.js

.PHONY: bca
# help: bca				- build mifos community
bca:
	@cd community-app; BUILDKIT_PROGRESS=plain docker build -t mifos-community-app . && \
	docker run --name mifos-ui -it -d -p 28000:80 mifos-community-app

.PHONY: cpca

# help: cpca				- cp out latest build files of mifos community
cpca:
	@mkdir -p ~/Desktop/ca-keeps
	@cp ~/devcode/fineract/containers/nginx/community-app/scripts/routes-initialTasks-webstorage-configuration.*.js ~/Desktop/ca-keeps
	@cp ~/devcode/fineract/containers/nginx/community-app/index.html ~/Desktop/ca-keeps/
	@rm -rf ~/devcode/fineract/containers/nginx/community-app
	@docker cp mifos-ui:/usr/share/nginx/html ~/devcode/fineract/containers/nginx/community-app
	@cp drillR.js ~/devcode/fineract/containers/nginx/community-app/scripts/drillR.js

	@docker cp mifos-ui:/usr/share/nginx/html ~/Desktop/html
	@echo "edit all necessary files at '~/Desktop/html' using '~/Desktop/ca-keeps' then run: make 'cplf'"

# help: cplf				- cp out latest build files to ~/devcode/lite-fineract
cplf:
	@rm -rf ~/devcode/lite-fineract/community-app
	@cp -r ~/devcode/fineract/containers/nginx/community-app ~/devcode/lite-fineract
