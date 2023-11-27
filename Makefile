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

.PHONY: bw
# help: bw				- build web app
bw:
	@cd web-app; BUILDKIT_PROGRESS=plain docker compose -f docker-compose.yml up --build -d; cd ..

.PHONY: cpw

# help: cpw				- cp out latest build files of web app
cpw:
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

.PHONY: bm
# help: bm				- build mifos community
bm:
	@cd community-app; BUILDKIT_PROGRESS=plain docker build -t mifos-community-app . && \
	docker run --name mifos-ui -it -d -p 28000:80 mifos-community-app

.PHONY: cpm

# help: cpm				- cp out latest build files of mifos community
cpm:
	@cp ~/devcode/fineract/containers/nginx/community-app/scripts/drillR.js ~/Desktop/
	@rm -rf ~/devcode/fineract/containers/nginx/community-app
	@docker cp mifos-ui:/usr/share/nginx/html ~/devcode/fineract/containers/nginx/
	@mv ~/devcode/fineract/containers/nginx/html ~/devcode/fineract/containers/nginx/community-app
	@mv ~/Desktop/drillR.js containers/nginx/community-app/scripts/drillR.js

	@rm -rf ~/devcode/lite-fineract/community-app
	@cp -r ~/devcode/fineract/containers/nginx/community-app ~/devcode/lite-fineract
